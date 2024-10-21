part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeGetBalanceLoadingState extends HomeState {}

final class HomeGetBalanceSucessState extends HomeState {}

final class HomeGetBalanceFailureState extends HomeState {
  final String error;

  HomeGetBalanceFailureState({required this.error});
}
