part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginChangeSuffix extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  LoginModel? loginModel;

  LoginSuccessState(this.loginModel);
}

class LoginErrorState extends LoginState {
  final String error;

  LoginErrorState(this.error);
}

class ForgetPasswordLoadingState extends LoginState {}

class ForgetPasswordSuccessState extends LoginState {
  LoginModel? loginModel;

  ForgetPasswordSuccessState(this.loginModel);
}

class ForgetPasswordErrorState extends LoginState {
  final String error;

  ForgetPasswordErrorState(this.error);
}

class ResetPasswordLoadingState extends LoginState {}

class ResetPasswordSuccessState extends LoginState {
  LoginModel? loginModel;

  ResetPasswordSuccessState(this.loginModel);
}

class ResetPasswordErrorState extends LoginState {
  final String error;

  ResetPasswordErrorState(this.error);
}
