import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:wifi_card/constants.dart';
import 'package:wifi_card/core/utils/api_service.dart';
import 'package:wifi_card/features/networks/data/card_number_model.dart';
import 'package:http/http.dart' as http;

part 'card_numbers_state.dart';

class CardNumbersCubit extends Cubit<CardNumbersState> {
  CardNumbersCubit() : super(CardNumbersInitial());
  static CardNumbersCubit get(context) => BlocProvider.of(context);

  List<CardNumberModel> cardNumbers = [];

  void getCardNumbers(int id) async {
    emit(GetCardNumbersLoadingState());
    await DioHelper.getData(
      url: 'card/numbers/$id',
      token: token,
    ).then((value) {
      List<dynamic>? userData = value.data['data']['card_numbers'];
      cardNumbers = [];
      cardNumbers =
          userData!.map((data) => CardNumberModel.fromJson(data)).toList();

      emit(GetCardNumbersSuccessState());
    }).catchError((error) {
      emit(GetCardNumbersFailureState(error: error.toString()));
    });
  }

  void addCard({
    required String category_id,
    required String network_id,
    required String cards,
  }) async {
    var url = Uri.parse('https://wificard.online/api/card/number/store');
    await http.post(url, body: {
      'card_category_id': category_id,
      'network_id': network_id,
      'card_numbers': cards
    }, headers: {
      'fcsToken': 'fcsToken',
      "Accept": "application/json",
      'Authorization': token ?? '',
    }).then((value) {
      var responseBody = jsonDecode(value.body);
      var message = responseBody['message'];
      if(value.statusCode==422)
        {
          var responseBody = jsonDecode(value.body);
          var message = responseBody['errors']["card_number"][0];
          print (message);
          emit(AddCardNumbersErrorState(error:message.toString()));
        }
      else
      emit(AddCardNumbersSuccessState(message: message));
    }).catchError((error) {
      emit(AddCardNumbersErrorState(error:error));
    });
  }

  void deleteCard({
    required int category_id,
    required int network_id,
  }) {
    emit(DeleteCardLoadingState());
    DioHelper.deleteData(
      url: 'card/number/delete/${category_id}',
      token: token,
    ).then((value) {
      getCardNumbers(network_id);
      emit(DeleteCardSuccessState(message: value.data['message']));
    }).catchError((error) {
      emit(DeleteCardFailure(error: error));
    });
  }
}
