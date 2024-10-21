part of 'users_cubit.dart';

@immutable
abstract class UsersStates {}

final class UsersInitialState extends UsersStates {}

final class UsersNavigationState extends UsersStates {}

final class UsersChangeColorButtonState extends UsersStates {}

final class GetUsersLoadingState extends UsersStates {}

final class GetUsersSuccessState extends UsersStates {}

final class GetUsersFailureState extends UsersStates {
  final String error;

  GetUsersFailureState({required this.error});
}

final class GetUsersNotVerifiedLoadingState extends UsersStates {}

final class GetUsersNotVerifiedSuccessState extends UsersStates {}

final class GetUsersNotVerifiedFailureState extends UsersStates {
  final String error;

  GetUsersNotVerifiedFailureState({required this.error});
}

final class VerifyUserSuccessState extends UsersStates {
  final String messgae;

  VerifyUserSuccessState({required this.messgae});
}

final class VerifyUserFailureState extends UsersStates {
  final String error;

  VerifyUserFailureState({required this.error});
}

final class VerifyNetworkOwnerSuccessState extends UsersStates {
  final String messgae;

  VerifyNetworkOwnerSuccessState({required this.messgae});
}

final class VerifyNetworkOwnerFailureState extends UsersStates {
  final String error;

  VerifyNetworkOwnerFailureState({required this.error});
}

final class BanUserSuccessState extends UsersStates {
  final String messgae;

  BanUserSuccessState({required this.messgae});
}

final class BanUserFailureState extends UsersStates {
  final String error;

  BanUserFailureState({required this.error});
}

final class UpdateState extends UsersStates {}

final class UpdateButtonState extends UsersStates {}

final class ChangeBanState extends UsersStates {}

final class ShowUserLoadingState extends UsersStates {}

final class ShowUserSuccessState extends UsersStates {}

final class ShowUserFailureState extends UsersStates {
  final String error;

  ShowUserFailureState({required this.error});
}

final class GetTransactionsLoadingState extends UsersStates {}

final class GetTransactionsSuccessState extends UsersStates {}

final class GetTransactionsFailureState extends UsersStates {
  final String error;

  GetTransactionsFailureState({required this.error});
}

final class GetFeesSuccessState extends UsersStates {}

final class GetFessFailureState extends UsersStates {
  final String error;

  GetFessFailureState({required this.error});
}

final class GetNotificationSuccessState extends UsersStates {}

final class GetNotificationFailureState extends UsersStates {
  final String error;

  GetNotificationFailureState({required this.error});
}
