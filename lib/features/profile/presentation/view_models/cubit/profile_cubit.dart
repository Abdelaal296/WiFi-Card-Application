import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:wifi_card/constants.dart';
import 'package:wifi_card/core/utils/api_service.dart';
import 'package:wifi_card/features/Users/data/models/user_model/user_model.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  static ProfileCubit get(context) => BlocProvider.of(context);

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changeSuffix() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ProfileChangeSuffix());
  }

  void updateUsername({
    required String username,
  }) {
    emit(UpdateUserNameLoadingState());
    DioHelper.postData(
      url: 'change/userName',
      data: {
        'full_name': username,
        '_method': 'PUT',
      },
      token: token,
    ).then((value) {
      model!.fullName = username;

      emit(UpdateUserNameSuccessState(message: value.data['message']));
    }).catchError((error) {
      emit(UpdateUserNameFailure(error: error));
    });
  }

  void updatePassword({
    required String newPassword,
    required String newPassword_confirmation,
    required String OldPassword,
  }) {
    emit(UpdatePasswordLoadingState());
    DioHelper.postData(
      url: 'change/password',
      data: {
        'newPassword': newPassword,
        'newPassword_confirmation': newPassword_confirmation,
        'oldPassword': OldPassword,
        '_method': 'PUT',
      },
      token: token,
    ).then((value) {
      emit(UpdatePasswordSuccessState(message: value.data['message']));
    }).catchError((error) {
      emit(UpdatePasswordFailure(error: error));
    });
  }
}
