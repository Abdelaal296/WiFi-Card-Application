import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:wifi_card/constants.dart';
import 'package:wifi_card/core/utils/api_service.dart';
import 'package:wifi_card/features/Users/data/models/user_model/user_model.dart';
import 'package:wifi_card/features/myTransations/data/transaction/transaction.dart';
import 'package:wifi_card/features/signUp/data/signUp_model.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersStates> {
  UsersCubit() : super(UsersInitialState());
  static UsersCubit get(context) => BlocProvider.of(context);

  List<AllUserModel> networkPeople = [];
  List<AllUserModel> shopPeople = [];
  List<AllUserModel> currentPeople = [];
  late bool isSelected;
  AllUserModel? allModel;

  void init() async {
    isSelected = true;
    await getUsers();
    await getUsersNotVerified();
    await getTransactions();
    getFees();
    getNotifications();
    currentPeople = networkPeople;

    emit(UpdateButtonState());
  }

  void changeButtonColor() {
    isSelected = !isSelected;
    emit(UsersChangeColorButtonState());
  }

  void changeToNewtworkPeople() async {
    await getUsers();
    currentPeople = networkPeople;
    emit(UsersNavigationState());
  }

  void changeToShopPeople() async {
    await getUsers();
    currentPeople = shopPeople;
    emit(UsersNavigationState());
  }

  List<AllUserModel> users = [];

  Future getUsers() async {
    emit(GetUsersLoadingState());
    await DioHelper.getData(
      url: 'all/users',
      token: token,
    ).then((value) {
      List<dynamic>? userData = value.data['data'];
      users = [];
      users = userData!.map((data) => AllUserModel.fromJson(data)).toList();

      shopPeople = [];
      networkPeople = [];

      users.forEach((element) {
        if (element.status == 1) {
          if (element.userRole!.name == 'shop_owner') {
            shopPeople.add(element);
          } else {
            networkPeople.add(element);
          }
        }
      });
      emit(GetUsersSuccessState());
    }).catchError((error) {
      emit(GetUsersFailureState(error: error.toString()));
    });
  }

  List<AllUserModel> usersNotVerified = [];

  Future getUsersNotVerified() async {
    emit(GetUsersNotVerifiedLoadingState());
    await DioHelper.getData(
      url: 'all/users/notVerified',
      token: token,
    ).then((value) {
      List<dynamic>? userData = value.data['data'];
      usersNotVerified =
          userData!.map((data) => AllUserModel.fromJson(data)).toList();

      emit(GetUsersNotVerifiedSuccessState());
    }).catchError((error) {
      emit(GetUsersNotVerifiedFailureState(error: error.toString()));
    });
  }

  RegisterModel? loginModel;
  void verifyAccount(AllUserModel model, int status) {
    DioHelper.postData(
      url: 'verify/account/${model.id}',
      data: {
        'status': status,
      },
      token: token,
    ).then((value) {
      loginModel = RegisterModel.fromJSon(value.data);
      if (status == 1) {
        shopPeople.add(model);
      }
      usersNotVerified.remove(model);

      emit(VerifyUserSuccessState(messgae: value.data['message']));
    }).catchError((error) {
      emit(VerifyUserFailureState(error: error.toString()));
    });
  }

  void verifyNetworkOwner(AllUserModel model) {
    DioHelper.getData(
      url: 'update/user/account/${model.id}',
      token: token,
    ).then((value) {
      loginModel = RegisterModel.fromJSon(value.data);
      networkPeople.add(model);
      shopPeople.remove(model);

      emit(VerifyNetworkOwnerSuccessState(messgae: value.data['message']));
    }).catchError((error) {
      emit(VerifyNetworkOwnerFailureState(error: error.toString()));
    });
  }

  Future banUser(AllUserModel model) async {
    await DioHelper.getData(
      url: 'ban/user/${model.id}',
      token: token,
    ).then((value) {
      loginModel = RegisterModel.fromJSon(value.data);
      model.ban = 1 - model.ban!;
      changeBan(model.ban!);

      emit(BanUserSuccessState(messgae: value.data['message']));
    }).catchError((error) {
      emit(BanUserFailureState(error: error.toString()));
    });
  }

  int getusersNotVerifiedLength() {
    return usersNotVerified.length;
  }

  void update() async {
    await getUsers();
    getUsersNotVerified();
    emit(UpdateState());
  }

  late Widget banWidget;
  void displayBan(AllUserModel model) {
    banWidget = model.ban == 1
        ? const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              'فك الحظر',
              style: TextStyle(
                  color: KPrimaryColor2,
                  fontFamily: Kprimaryfont,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          )
        : const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(children: [
              Text(
                "حظر",
                style: TextStyle(
                    fontSize: 22,
                    fontFamily: Kprimaryfont,
                    color: Colors.black),
              ),
              Icon(
                Icons.block,
                size: 45,
                color: Colors.red,
              ),
            ]));
  }

  void changeBan(int ban) {
    print(ban);
    banWidget = ban == 1
        ? const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              'فك الحظر',
              style: TextStyle(
                  color: KPrimaryColor2,
                  fontFamily: Kprimaryfont,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          )
        : const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(children: [
              Text(
                "حظر",
                style: TextStyle(
                    fontSize: 22,
                    fontFamily: Kprimaryfont,
                    color: Colors.black),
              ),
              Icon(
                Icons.block,
                size: 45,
                color: Colors.red,
              ),
            ]));
    emit(ChangeBanState());
  }

  Future showUser(int id) async {
    emit(ShowUserLoadingState());
    await DioHelper.getData(
      url: 'user/show/${id}',
      token: token,
    ).then((value) {
      allModel = AllUserModel.fromJson(value.data);

      emit(ShowUserSuccessState());
    }).catchError((error) {
      emit(ShowUserFailureState(error: error.toString()));
    });
  }

  List<Transaction> transactions = [];

  Future getTransactions() async {
    emit(GetTransactionsLoadingState());
    await DioHelper.getData(
      url: 'admin/transactions',
      token: token,
    ).then((value) {
      List<dynamic>? userData = value.data['data'];
      transactions = [];
      transactions =
          userData!.map((data) => Transaction.fromJson(data)).toList();

      emit(GetTransactionsSuccessState());
    }).catchError((error) {
      emit(GetTransactionsFailureState(error: error.toString()));
    });
  }

  num fees = 0;

  void getFees() {
    DioHelper.getData(
      url: 'admin/fees',
      token: token,
    ).then((value) {
      fees = value.data['data'];
      emit(GetFeesSuccessState());
    }).catchError((error) {
      emit(GetFessFailureState(error: error.toString()));
    });
  }

  

  void getNotifications() {
    DioHelper.getData(
      url: 'notifications/count',
      token: token,
    ).then((value) {
      count = value.data['data ']['notification_count'];
      print(count);
      emit(GetNotificationSuccessState());
    }).catchError((error) {
      emit(GetNotificationFailureState(error: error.toString()));
    });
  }
}
