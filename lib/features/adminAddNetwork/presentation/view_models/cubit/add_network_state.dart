part of 'add_network_cubit.dart';

@immutable
sealed class AddNetworkState {}

final class AddNetworkInitial extends AddNetworkState {}

final class AddNetworkLoadingState extends AddNetworkState {}

final class AddNetworkSuccessState extends AddNetworkState {
  final String message;

  AddNetworkSuccessState({required this.message});
}

final class AddNetworkFailure extends AddNetworkState {
  final String error;

  AddNetworkFailure({required this.error});
}

final class GetNetworksLoadingState extends AddNetworkState {}

final class GetNetworksSuccessState extends AddNetworkState {}

final class GetNetworksFailureState extends AddNetworkState {
  final String error;

  GetNetworksFailureState({required this.error});
}

final class UpdateNetworkLoadingState extends AddNetworkState {}

final class UpdateNetworkSuccessState extends AddNetworkState {
  final String message;

  UpdateNetworkSuccessState({required this.message});
}

final class UpdateNetworkFailure extends AddNetworkState {
  final String error;

  UpdateNetworkFailure({required this.error});
}

final class DeleteNetworkLoadingState extends AddNetworkState {}

final class DeleteNetworkSuccessState extends AddNetworkState {
  final String message;

  DeleteNetworkSuccessState({required this.message});
}

final class DeleteNetworkFailure extends AddNetworkState {
  final String error;

  DeleteNetworkFailure({required this.error});
}

final class ChangeReminning extends AddNetworkState {}

final class GetAdminBalanceLoadingState extends AddNetworkState {}

final class GetAdminBalanceSuccessState extends AddNetworkState {}

final class GetAdminBalanceFailureState extends AddNetworkState {
final String error;

GetAdminBalanceFailureState({required this.error});
}

