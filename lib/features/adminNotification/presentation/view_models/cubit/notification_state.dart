part of 'notification_cubit.dart';

@immutable
abstract class NotificationState {}

final class NotificationInitial extends NotificationState {}

final class GetNotificationLoadingState extends NotificationState {}

final class GetUNotificationSuccessState extends NotificationState {}

final class GetNotificationFailureState extends NotificationState {
  final String error;

  GetNotificationFailureState({required this.error});
}


final class UpdateNotificationLoadingState extends NotificationState {}

final class UpdateNotificationSuccessState extends NotificationState {
  final String message;

  UpdateNotificationSuccessState({required this.message});
}

final class UpdateNotificationFailure extends NotificationState {
  final String error;

  UpdateNotificationFailure({required this.error});
}

final class DeleteNotificationLoadingState extends NotificationState {}

final class DeleteNotificationSuccessState extends NotificationState {
  final String message;

  DeleteNotificationSuccessState({required this.message});
}

final class DeleteNotificationFailure extends NotificationState {
  final String error;

  DeleteNotificationFailure({required this.error});
}