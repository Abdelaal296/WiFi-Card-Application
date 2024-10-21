import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:wifi_card/constants.dart';
import 'package:wifi_card/core/utils/api_service.dart';
import 'package:wifi_card/features/Users/data/models/user_model/user_model.dart';
import 'package:wifi_card/features/chat/data/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  static ChatCubit get(context) => BlocProvider.of(context);

  void init() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.id!.toString())
        .set({
      'name': model!.fullName,
      'id': model!.id,
      'lastUpdated': DateTime.now(),
    });
  }

  void initAdmin(AllUserModel allUserModel) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(allUserModel.id.toString())
        .set({
      'name': allUserModel.fullName,
      'id': allUserModel.id,
      'lastUpdated': DateTime.now(),
    });
  }

  void sendNotification(int id) {
    DioHelper.postData(
      url: 'notification/message',
      data: {
        'user_id': id,
      },
      token: token,
    ).then((value) {

      print(value.data['message']);
     

      emit(SendNotificationSuccessState(message: value.data['message']));
    }).catchError((error) {
      emit(SendNotificationFailureState(error: error.toString()));
    });
  }

  // void addMessage({required String message, required int id}) {
  //   messagesList.add(MessageModel(message, id));
  //   emit(ChatSuccess());
  // }

  String? text;
  void updateText(String newText) {
    text = newText;
    emit(ChatUpdateText());
  }

  List<MessageModel> messages = [];

  void getMessages() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.id.toString())
        .collection('messages')
        .orderBy('createdAt')
        .snapshots()
        .listen((event) {
      messages = [];

      event.docs.forEach((element) {
        print(element);
        messages.add(MessageModel.fromJSon(element.data()));
      });
      emit(GetMessageSuccessState());
      print(messages);
    });
  }

  void sendMessage({
    required String message,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.id.toString())
        .collection('messages')
        .add({
      'message': message,
      'role_type': user_role!,
      'createdAt': DateTime.now().toString()
    }).then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      print(error);
      emit(SendMessageFailureState());
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getLastMessage(int id) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(id.toString())
        .collection('messages')
        .orderBy('createdAt', descending: true)
        .limit(1)
        .snapshots();
  }
}
