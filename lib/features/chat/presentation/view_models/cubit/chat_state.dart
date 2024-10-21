part of 'chat_cubit.dart';

@immutable
abstract class ChatState {}

final class ChatInitial extends ChatState {}

final class ChatSuccess extends ChatState {}

final class ChatUpdateText extends ChatState {}

final class ChatScrollText extends ChatState {}

final class GetMessageLoadingState extends ChatState {}

final class GetMessageSuccessState extends ChatState {}

final class GetMessageFailureState extends ChatState {}

final class SendMessageSuccessState extends ChatState {}

final class SendMessageFailureState extends ChatState {}

final class SendNotificationSuccessState extends ChatState {
  final String message;

  SendNotificationSuccessState({required this.message});
}
final class SendNotificationFailureState extends ChatState {
  final String error;

  SendNotificationFailureState({required this.error});
}
