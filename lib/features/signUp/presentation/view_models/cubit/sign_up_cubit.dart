import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:wifi_card/core/utils/api_service.dart';
import 'package:wifi_card/features/signUp/data/signUp_model.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());
  static SignUpCubit get(context) => BlocProvider.of(context);

  RegisterModel? loginModel;
  void userRegister({
    required String commercial_activity,
    required String password,
    required String password_confirmation,
    required String distributor_account_number,
    required String name,
    required String phone,
    required String address,
  }) {
    emit(SignUpLoadingSate());
    DioHelper.postData(
      url: 'register',
      data: {
        'full_name': name,
        'commercial_activity': commercial_activity,
        'phone_number': phone,
        'address': address,
        'distributor_account_number': distributor_account_number,
        'password': password,
        'password_confirmation': password_confirmation,
      },
    ).then((value) {
      if (value.statusCode! >= 200 && value.statusCode! < 300) {
        loginModel = RegisterModel.fromJSon(value.data);
        emit(SignUpSuccessState(loginModel));
      } else {
        emit(SignUpErrorState(error: '${value.data['message']}'));
      }
    }).catchError((error) {
      emit(SignUpErrorState(error: error));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changeSuffix() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SignUpChangeSuffix());
  }

  bool isLoading = false;
}
