part of 'my_transaction_cubit.dart';

@immutable
abstract class MyTransactionState {}

final class MyTransactionInitial extends MyTransactionState {}

final class GetMyTransactionLoadingState extends MyTransactionState {}

final class GetMyTransactionSuccessState extends MyTransactionState {}

final class GetMyTransactionFailureState extends MyTransactionState {
  final String error;

  GetMyTransactionFailureState({required this.error});
}

final class GetTransactionLoadingState extends MyTransactionState {}

final class GetTransactionSuccessState extends MyTransactionState {}

final class GetTransactionFailureState extends MyTransactionState {
  final String error;

  GetTransactionFailureState({required this.error});
}
