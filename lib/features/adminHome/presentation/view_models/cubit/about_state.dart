part of 'about_cubit.dart';

@immutable
abstract class AboutState {}

final class AboutInitial extends AboutState {}

final class AboutLoadingState extends AboutState {}

final class AboutSuccessState extends AboutState {
  final String message;

  AboutSuccessState({required this.message});
}

final class AboutFailureState extends AboutState {
  final String error;

  AboutFailureState({required this.error});
}

final class GetAboutsLoadingState extends AboutState {}

final class GetAboutsSuccessState extends AboutState {}

final class GetAboutsFailureState extends AboutState {
  final String error;

  GetAboutsFailureState({required this.error});
}

final class UpdateAboutLoadingState extends AboutState {}

final class UpdateAboutSuccessState extends AboutState {
  final String message;

  UpdateAboutSuccessState({required this.message});
}

final class UpdateAboutFailure extends AboutState {
  final String error;

  UpdateAboutFailure({required this.error});
}

final class DeleteAboutLoadingState extends AboutState {}

final class DeleteAboutSuccessState extends AboutState {
  final String message;

  DeleteAboutSuccessState({required this.message});
}

final class DeleteAboutFailure extends AboutState {
  final String error;

  DeleteAboutFailure({required this.error});
}
