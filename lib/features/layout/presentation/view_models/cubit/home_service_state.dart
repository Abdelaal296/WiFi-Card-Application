part of 'home_service_cubit.dart';

@immutable
abstract class HomeServiceState {}

final class HomeServiceInitial extends HomeServiceState {}

final class HomeServiceChangeBottomBar extends HomeServiceState {}

final class ShowMeLoadingState extends HomeServiceState {}

final class ShowMeSuccessState extends HomeServiceState {}

final class ShowMeFailureState extends HomeServiceState {
  final String error;

  ShowMeFailureState({required this.error});
}

final class GetBalanceLoadingState extends HomeServiceState {}

final class GetBalanceSucessState extends HomeServiceState {}

final class GetBalanceFailureState extends HomeServiceState {
  final String error;

  GetBalanceFailureState({required this.error});
}

final class GetAboutsUserLoadingState extends HomeServiceState {}

final class GetAboutsUserSuccessState extends HomeServiceState {}

final class GetAboutsUserFailureState extends HomeServiceState {
  final String error;

  GetAboutsUserFailureState({required this.error});
}

final class GetUserNotificationSuccessState extends HomeServiceState {}

final class GetUserNotificationFailureState extends HomeServiceState {
  final String error;

  GetUserNotificationFailureState({required this.error});
}
final class GetMyTransactionHomeLoadingState extends HomeServiceState {}

final class GetMyTransactionHomeSuccessState extends HomeServiceState {}

final class GetMyTransactionHomeFailureState extends HomeServiceState {
final String error;

GetMyTransactionHomeFailureState({required this.error});
}
