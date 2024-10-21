part of 'wifi_cabin_cubit.dart';

@immutable
abstract class WifiCabinState {}

final class WifiCabinInitial extends WifiCabinState {}

final class WifiCabinChangeHeart extends WifiCabinState {}

final class WifiCabinChangeCounter extends WifiCabinState {}

final class WifiCabinNavigationState extends WifiCabinState {}

final class WifiCabinChangeColorButtonState extends WifiCabinState {}

final class WifiCabinChangeFavouriteState extends WifiCabinState {}

final class GetNetworksCabinLoadingState extends WifiCabinState {}

final class GetNetworksCabinSuccessState extends WifiCabinState {}

final class GetNetworksCabinFailureState extends WifiCabinState {
  final String error;

  GetNetworksCabinFailureState({required this.error});
}

final class MakeNetworkCabinfavLoadingState extends WifiCabinState {}

final class MakeNetworkCabinfavSuccessState extends WifiCabinState {}

final class MakeNetworkCabinfavFailureState extends WifiCabinState {
  final String error;

  MakeNetworkCabinfavFailureState({required this.error});
}

final class DeleteFavLoadingState extends WifiCabinState {}

final class DeleteFavSuccessState extends WifiCabinState {
  final String message;

  DeleteFavSuccessState({required this.message});
}

final class DeleteFavFailureState extends WifiCabinState {
  final String error;

  DeleteFavFailureState({required this.error});
}

final class GetCategoriesNetworkLoadingState extends WifiCabinState {}

final class GetCategoriesNetworkSuccessState extends WifiCabinState {}

final class GetCategoriesNetworkFailureState extends WifiCabinState {
  final String error;

  GetCategoriesNetworkFailureState({required this.error});
}

final class PayCardLoadingState extends WifiCabinState {}

final class PayCardfavSuccessState extends WifiCabinState {
  final List<CardTransactionModel> card_number;

  PayCardfavSuccessState({required this.card_number});
}

final class PayCardfavFailureState extends WifiCabinState {
  final String error;

  PayCardfavFailureState({required this.error});
}

final class GetBalanceUpdateLoadingState extends WifiCabinState {}

final class GetBalanceUpdateSucessState extends WifiCabinState {}

final class GetBalanceUpdateFailureState extends WifiCabinState {
  final String error;

  GetBalanceUpdateFailureState({required this.error});
}

final class SendCardLoadingState extends WifiCabinState {}

final class SendCardfavSuccessState extends WifiCabinState {
  final String message;

  SendCardfavSuccessState({required this.message});
}

final class SendCardfavFailureState extends WifiCabinState {
  final String error;

  SendCardfavFailureState({required this.error});
}
