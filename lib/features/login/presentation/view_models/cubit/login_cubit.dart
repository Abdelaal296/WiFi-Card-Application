import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:wifi_card/core/utils/api_service.dart';
import 'package:wifi_card/features/login/data/models/login_model.dart';
import 'package:wifi_card/features/signUp/data/signUp_model.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(context) => BlocProvider.of(context);

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changeSuffix() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(LoginChangeSuffix());
  }

  LoginModel? loginModel;
  void userLogin({
    required String phone,
    required String password,
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(
      url: 'login',
      data: {
        'phone_number': phone,
        'password': password,
      },
    ).then((value) {
      if (value.statusCode! >= 200 && value.statusCode! < 300) {
        loginModel = LoginModel.fromJSon(value.data);
        emit(LoginSuccessState(loginModel));
      } else {
        if (value.statusCode == 401) {
          emit(LoginErrorState(value.data['error']));
        } else {
          emit(LoginErrorState(value.data['message']));
        }
      }
    }).catchError((error) {
      log(error.toString());
      emit(LoginErrorState(error));
    });
  }



  void forgetPassword({
    required String phone,
  }) {
    emit(ForgetPasswordLoadingState());
    DioHelper.postData(
      url: 'forget/password',
      data: {
        'phone_number': phone,
      },
    ).then((value) {
     
      emit(ForgetPasswordSuccessState(loginModel));
     
    }).catchError((error) {
      log(error.toString());
      emit(ForgetPasswordErrorState(error));
    });
  }



  void resetPassword({
    required String phone,
    required String password,
    required String passwordConfirm,
    required String verifyCode,
  }) {
    emit(ResetPasswordLoadingState());
    DioHelper.postData(
      url: 'reset/password',
      data: {
        'phone_number': phone,
        'password': password,
        'password_confirmation': passwordConfirm,
        'verification_code': verifyCode,
      },
    ).then((value) {
      
        emit(ResetPasswordSuccessState(loginModel));
     
    }).catchError((error) {
      log(error.toString());
      emit(ResetPasswordErrorState(error));
    });
  }
}
