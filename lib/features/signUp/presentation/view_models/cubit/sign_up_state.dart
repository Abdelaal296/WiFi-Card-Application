part of 'sign_up_cubit.dart';

@immutable
abstract class SignUpState {}

final class SignUpInitial extends SignUpState {}

final class SignUpChangeSuffix extends SignUpState {}

final class SignUpLoadingSate extends SignUpState {}

final class SignUpSuccessState extends SignUpState {
  RegisterModel? resgisterModel;

  SignUpSuccessState(this.resgisterModel);
}

final class SignUpErrorState extends SignUpState {
  final String error;

  SignUpErrorState({required this.error});
}
