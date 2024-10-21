part of 'report_and_card_cubit.dart';

@immutable
abstract class ReportAndCardState {}

final class ReportAndCardInitial extends ReportAndCardState {}

final class GetCardNumbersLoadingState extends ReportAndCardState {}

final class GetCardNumbersSuccessState extends ReportAndCardState {}

final class GetCardNumbersFailureState extends ReportAndCardState {
  final String error;

  GetCardNumbersFailureState({required this.error});
}
