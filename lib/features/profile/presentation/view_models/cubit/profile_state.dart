part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileChangeSuffix extends ProfileState {}

final class UpdateUserNameLoadingState extends ProfileState {}

final class UpdateUserNameSuccessState extends ProfileState {
  final String message;

  UpdateUserNameSuccessState({required this.message});
}

final class UpdateUserNameFailure extends ProfileState {
  final String error;

  UpdateUserNameFailure({required this.error});
}

final class UpdatePasswordLoadingState extends ProfileState {}

final class UpdatePasswordSuccessState extends ProfileState {
  final String message;

  UpdatePasswordSuccessState({required this.message});
}

final class UpdatePasswordFailure extends ProfileState {
  final String error;

  UpdatePasswordFailure({required this.error});
}
