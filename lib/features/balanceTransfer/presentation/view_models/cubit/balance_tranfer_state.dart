part of 'balance_tranfer_cubit.dart';

@immutable
abstract class BalanceTranferState {}

final class BalanceTranferInitial extends BalanceTranferState {}

final class AddTransactionLoadingState extends BalanceTranferState {}

final class AddTransactionSuccessState extends BalanceTranferState {
  final String message;

  AddTransactionSuccessState({required this.message});
}

final class AddTransactionFailure extends BalanceTranferState {
  final String error;

  AddTransactionFailure({required this.error});
}

final class GetUsersBalanceLoadingState extends BalanceTranferState {}

final class GetUsersBalanceSuccessState extends BalanceTranferState {}

final class GetUsersBalanceFailureState extends BalanceTranferState {
  final String error;

  GetUsersBalanceFailureState({required this.error});
}

final class GetNetworksBalanceLoadingState extends BalanceTranferState {}

final class GetNetworksBalanceSuccessState extends BalanceTranferState {}

final class GetNetworksBalanceFailureState extends BalanceTranferState {
  final String error;

  GetNetworksBalanceFailureState({required this.error});
}
