import 'dart:convert';

import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:wifi_card/constants.dart';
import 'package:wifi_card/core/utils/api_service.dart';
import 'package:wifi_card/core/widgets/custom_flutter_toast.dart';
import 'package:wifi_card/features/networks/data/category_model.dart';
import 'package:wifi_card/features/wifiCard/data/card_model/card_model.dart';
import 'package:wifi_card/features/wifiCard/data/card_model/favourite_user.dart';

import '../../../../../device.dart';
import '../../../../card_transaction/data/card_trans_model.dart';
import '../../../data/print_info.dart';

part 'wifi_cabin_state.dart';

class WifiCabinCubit extends Cubit<WifiCabinState> {
  WifiCabinCubit() : super(WifiCabinInitial());
  static WifiCabinCubit get(context) => BlocProvider.of(context);

  int counter = 1;

  bool isHeart = false;

  void changHeart() {
    isHeart = !isHeart;
    emit(WifiCabinChangeHeart());
  }

  void addOne() {
    counter++;
    emit(WifiCabinChangeCounter());
  }

  void subtractOne() {
    if (counter > 1) counter--;
    emit(WifiCabinChangeCounter());
  }

  List<CardModel> allNetworks = [];
  List<CardModel> favourites = [];
  List<CardModel> currentNetworks = [];
  late bool isSelected;

  void init() async {
    isSelected = true;
    await getNetworksCabin();
    currentNetworks = allNetworks;

    emit(WifiCabinInitial());
  }

  void changeButtonColor() {
    isSelected = !isSelected;
    emit(WifiCabinChangeColorButtonState());
  }

  void changeToAllNewtworks() {
    currentNetworks = allNetworks;
    emit(WifiCabinNavigationState());
  }

  void changeToShopPeople() {
    currentNetworks = favourites;
    emit(WifiCabinNavigationState());
  }

  void addToFavourites(CardModel model) {
    favourites.add(model);
    emit(WifiCabinChangeFavouriteState());
  }

  void removeToFavourites(CardModel model) {
    favourites.remove(model);
    emit(WifiCabinChangeFavouriteState());
  }

  Future getNetworksCabin() async {
    emit(GetNetworksCabinLoadingState());
    await DioHelper.getData(
      url: 'networks',
      token: token,
    ).then((value) {
      List<dynamic>? userData = value.data['data'];
      allNetworks = userData!.map((data) => CardModel.fromJson(data)).toList();

      print(allNetworks);
      favourites = [];

      allNetworks.forEach((element) {
        if (element.favouriteUser != null) favourites.add(element);
      });

      emit(GetNetworksCabinSuccessState());
    }).catchError((error) {
      emit(GetNetworksCabinFailureState(error: error.toString()));
    });
  }

  void makeFav({
    required int id,
    required CardModel model,
  }) {
    emit(MakeNetworkCabinfavLoadingState());
    DioHelper.postData(
            url: 'favourite/store',
            data: {
              'network_id': id,
            },
            token: token)
        .then((value) {
      print(value.data['message']);
      addToFavourites(model);
      model.favouriteUser = FavouriteUser();
      getNetworksCabin();
      currentNetworks = allNetworks;

      emit(MakeNetworkCabinfavSuccessState());
    }).catchError((error) {
      emit(MakeNetworkCabinfavFailureState(error: error.toString()));
    });
  }

  void deleteFav({
    required int id,
    required CardModel model,
  }) {
    emit(DeleteFavLoadingState());
    DioHelper.deleteData(
      url: 'favourite/delete/$id',
      token: token,
    ).then((value) {
      removeToFavourites(model);
      model.favouriteUser = null;

      getNetworksCabin();
      emit(DeleteFavSuccessState(message: value.data['message']));
    }).catchError((error) {
      emit(DeleteFavFailureState(error: error));
    });
  }

  List<CategoryModel> categories = [];
  void getCategories(int id) async {
    emit(GetCategoriesNetworkLoadingState());
    await DioHelper.getData(
      url: 'network/show/$id',
      token: token,
    ).then((value) {
      List<dynamic>? userData = value.data['data']['card_categories'];
      categories =
          userData!.map((data) => CategoryModel.fromJson(data)).toList();

      emit(GetCategoriesNetworkSuccessState());
    }).catchError((error) {
      emit(GetCategoriesNetworkFailureState(error: error.toString()));
    });
  }

  void payCard({
    required int card_id,
    required int cate_id,
    required int quantity,
  }) {
    emit(PayCardLoadingState());
    DioHelper.postData(
            url: 'pay/card/number/$card_id/$cate_id',
            data: {
              'quantity': quantity,
            },
            token: token)
        .then((value) {
      if (value.statusCode == 404) {
        emit(PayCardfavFailureState(error: value.data["message"]));
      } else {
        List<dynamic>? userData = value.data['data'];
        List<CardTransactionModel> Cards = userData!
            .map((data) => CardTransactionModel.fromJson(data))
            .toList();
        print(value.data['data'][0]['card_number']);
        getNetworksCabin();
        print(Cards);
        emit(PayCardfavSuccessState(card_number: Cards));
      }
    }).catchError((error) {
      emit(PayCardfavFailureState(error: error.toString()));
    });
  }

  void sendcard({
    required String card_id,
    required String Phone,
  }) async {
    var url = Uri.parse('https://wificard.online/api/send/cardNumber');
    await http.post(url, body: {
      'card_number': card_id,
      'phone_number': Phone,
    }, headers: {
      'fcsToken': 'fcsToken',
      "Accept": "application/json",
      'Authorization': token ?? '',
    }).then((value) {
      var responseBody = jsonDecode(value.body);
      if (value.statusCode == 422) {
        var responseBody = jsonDecode(value.body);
        var message = responseBody['errors']["card_number"][0];
        print(message);
        emit(SendCardfavFailureState(error: message.toString()));
      } else {
        var responseBody = jsonDecode(value.body);
        var message = responseBody['message'];
        getNetworksCabin();
        print(message);
        emit(SendCardfavSuccessState(message: message));
      }
    }).catchError((error) {
      emit(SendCardfavFailureState(error: error.toString()));
    });
  }

  Future<void> startPrint(
      BluetoothDevice? device, PrintInfo data, context) async {
    if (device != null && device.address != null) {
      BluetoothPrint bluetoothPrint = BluetoothPrint.instance;
      await bluetoothPrint.connect(device);
      print("zzzzzzzzzzz${device.connected}");

      Map<String, dynamic> config = Map();
      List<LineText> list = [];

      list.add(
        LineText(
          type: LineText.TYPE_TEXT,
          content: "data",
          weight: 2,
          width: 2,
          height: 2,
          align: LineText.ALIGN_CENTER,
          linefeed: 1,
        ),
      );
    } else {
      showToast(text: "رجاء اختيار طابعه", state: ToastStates.ERROR);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Directionality(
                  textDirection: TextDirection.rtl, child: PrintPage())));
    }
  }
}
