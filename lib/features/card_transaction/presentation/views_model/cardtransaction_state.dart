part of 'cardtransaction_cubit.dart';

@immutable
abstract class CardtransactionState {}

class CardtransactionInitial extends CardtransactionState {}

final class GetCardTransactionLoadingState extends CardtransactionState {}

final class GetCardTransactionSuccessState extends CardtransactionState {}

final class GetCardTransactionFailureState extends CardtransactionState {
  final String error;

  GetCardTransactionFailureState({required this.error});
}

final class GetAllCardTransactionLoadingState extends CardtransactionState {}

final class GetAllCardTransactionSuccessState extends CardtransactionState {}

final class GetAllCardTransactionFailureState extends CardtransactionState {
  final String error;

  GetAllCardTransactionFailureState({required this.error});
}
