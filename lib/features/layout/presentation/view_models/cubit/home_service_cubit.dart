import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:wifi_card/constants.dart';
import 'package:wifi_card/core/utils/api_service.dart';
import 'package:wifi_card/features/Users/data/models/user_model/user_model.dart';
import 'package:wifi_card/features/adminHome/data/about.dart';
import 'package:wifi_card/features/home/presentation/views/home.dart';
import 'package:wifi_card/features/more/presentation/views/more.dart';

import '../../../../card_transaction/presentation/views/card_transaction.dart';
import '../../../../myTransations/data/transaction/transaction.dart';

part 'home_service_state.dart';

class HomeServiceCubit extends Cubit<HomeServiceState> {
  HomeServiceCubit() : super(HomeServiceInitial());
  static HomeServiceCubit get(context) => BlocProvider.of(context);

  int selectedindex = 0;
  List screens = [HomeScreen(), CardTransaction(), MoreScreen()];

  void changeBottomBar(int index) {
    selectedindex = index;
    emit(HomeServiceChangeBottomBar());
  }

  void showUser() async {
    emit(ShowMeLoadingState());
    try {
      var value = await DioHelper.getData(
        url: 'me',
        token: token,
      );
      print(value.data['data']);
      model = AllUserModel.fromJson(value.data['data']);

      emit(ShowMeSuccessState());
    } catch (error) {
      emit(ShowMeFailureState(error: error.toString()));
    }
  }

  void getBalance() async {
    await DioHelper.getData(
      url: 'balance',
      token: token,
    ).then((value) {
      balance = value.data['data']['balance'];
      fees = value.data['data']['fees'];
      print(balance);

      emit(GetBalanceSucessState());
    }).catchError((error) {
      emit(GetBalanceFailureState(error: error.toString()));
    });
  }

  List<About> abouts = [];

  void getAbouts() async {
    emit(GetAboutsUserLoadingState());
    await DioHelper.getData(
      url: 'abouts',
      token: token,
    ).then((value) {
      List<dynamic>? userData = value.data['data'];
      abouts = [];
      abouts = userData!.map((data) => About.fromJson(data)).toList();

      emit(GetAboutsUserSuccessState());
    }).catchError((error) {
      emit(GetAboutsUserFailureState(error: error.toString()));
    });
  }

  int count = 0;

  void getNotifications() {
    DioHelper.getData(
      url: 'notifications/count',
      token: token,
    ).then((value) {
      count = value.data['data ']['notification_count'];
      print(count);
      emit(GetUserNotificationSuccessState());
    }).catchError((error) {
      emit(GetUserNotificationFailureState(error: error.toString()));
    });
  }

  List transations = [];
  void getMyHomeTransaction() async {
    emit(GetMyTransactionHomeLoadingState());
    await DioHelper.getData(
      url: 'transactions',
      token: token,
    ).then((value) {
      List<dynamic>? userData = value.data['data'];
      transations = [];
      transations =
          userData!.map((data) => Transaction.fromJson(data)).toList();

      emit(GetMyTransactionHomeSuccessState());
    }).catchError((error) {
      emit(GetMyTransactionHomeFailureState(error: error.toString()));
    });
  }
}
