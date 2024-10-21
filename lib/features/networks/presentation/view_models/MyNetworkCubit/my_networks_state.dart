part of 'my_networks_cubit.dart';

@immutable
abstract class MyNetworksState {}

final class MyNetworksInitial extends MyNetworksState {}

final class GetMyNetworksLoadingState extends MyNetworksState {}

final class GetMyNetworksSuccessState extends MyNetworksState {}

final class GetMyNetworksFailureState extends MyNetworksState {
  final String error;

  GetMyNetworksFailureState({required this.error});
}
