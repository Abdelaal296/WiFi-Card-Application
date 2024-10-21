part of 'card_numbers_cubit.dart';

@immutable
abstract class CardNumbersState {}

final class CardNumbersInitial extends CardNumbersState {}

final class GetCardNumbersLoadingState extends CardNumbersState {}

final class GetCardNumbersSuccessState extends CardNumbersState {}

final class GetCardNumbersFailureState extends CardNumbersState {
  final String error;

  GetCardNumbersFailureState({required this.error});
}

final class AddCardNumbersSuccessState extends CardNumbersState {
  final String message;

  AddCardNumbersSuccessState({required this.message});
}

final class AddCardNumbersErrorState extends CardNumbersState {
  final String error;

  AddCardNumbersErrorState({required this.error});
}

final class DeleteCardLoadingState extends CardNumbersState {}

final class DeleteCardSuccessState extends CardNumbersState {
  final String message;

  DeleteCardSuccessState({required this.message});
}

final class DeleteCardFailure extends CardNumbersState {
  final String error;

  DeleteCardFailure({required this.error});
}
