import 'package:auto_direction/auto_direction.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wifi_card/constants.dart';
import 'package:wifi_card/features/Users/data/models/user_model/user_model.dart';
import 'package:wifi_card/features/chat/data/models/message_model.dart';
import 'package:wifi_card/features/chat/presentation/view_models/cubit/chat_cubit.dart';
import 'package:wifi_card/features/chat/presentation/views/widgets/chat_bubble.dart';

// ignore: must_be_immutable
class ChatUserScreen extends StatelessWidget {
  ChatUserScreen({super.key, required this.allUserModel});
  final AllUserModel allUserModel;

  TextEditingController controller = TextEditingController();
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    CollectionReference messages = FirebaseFirestore.instance
        .collection('users')
        .doc(allUserModel.id.toString())
        .collection('messages');
    return BlocProvider(
      create: (context) => ChatCubit(),
      child: BlocConsumer<ChatCubit, ChatState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return StreamBuilder<QuerySnapshot>(
              stream: messages.orderBy('createdAt').snapshots(),
              builder: (context, snapshot) {
                List<MessageModel> messagesList = [];
                if (snapshot.hasData) {
                  for (int i = 0; i < snapshot.data!.docs.length; i++) {
                    MessageModel message =
                        MessageModel.fromJSon(snapshot.data!.docs[i]);
                    print(message.role_type);
                    print(message.isRead);
                    print(user_role);
                    if (message.role_type != user_role) {
                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(allUserModel.id.toString())
                          .collection('messages')
                          .doc(snapshot.data!.docs[i].id)
                          .update({'isRead': true});
                    }
                    messagesList.add(message);
                  }
                  WidgetsBinding.instance!.addPostFrameCallback((_) {
                    scrollController.animateTo(
                      scrollController.position.maxScrollExtent,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    );
                  });
                  return Scaffold(
                      appBar: AppBar(
                        automaticallyImplyLeading: false,
                        centerTitle: true,
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              'التواصل',
                              style: TextStyle(
                                  fontFamily: 'ٌRubik',
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      body: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              controller: scrollController,
                              itemCount: messagesList.length,
                              itemBuilder: (context, index) {
                                return messagesList[index].role_type != 'admin'
                                    ? ChatBubbleForBot(
                                        message: messagesList[index].message,
                                      )
                                    : ChatBubble(
                                        message: messagesList[index].message,
                                      );
                              },
                            ),
                          ),
                          Container(
                            color: KPrimaryColor2,
                            padding: const EdgeInsets.all(16.0),
                            child: AutoDirection(
                              text: ChatCubit.get(context).text ?? "",
                              child: TextField(
                                controller: controller,
                                onChanged: (value) {
                                  ChatCubit.get(context).updateText(value);
                                },
                                // keyboardType: TextInputType.multiline,
                                // minLines: 1,
                                // maxLines: 2,
                                style: const TextStyle(color: Colors.white),
                                onSubmitted: (value) {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                },
                                decoration: InputDecoration(
                                    hintText: 'اكتب رسالتك....',
                                    hintStyle: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: Kprimaryfont),
                                    suffixIcon: IconButton(
                                      icon: const Icon(
                                        Icons.send,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        ChatCubit.get(context)
                                            .initAdmin(allUserModel);
                                        FirebaseFirestore.instance
                                            .collection('users')
                                            .doc(allUserModel.id.toString())
                                            .collection('messages')
                                            .add({
                                          'message': controller.text,
                                          'role_type': user_role!,
                                          'createdAt':
                                              DateTime.now().toString(),
                                          'isRead': true,
                                        });
                                        controller.clear();
                                        scrollController.animateTo(
                                            scrollController
                                                .position.maxScrollExtent,
                                            duration: Duration(seconds: 1),
                                            curve: Curves.fastOutSlowIn);
                                      },
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: const BorderSide(
                                          color: Colors.white,
                                        )),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: const BorderSide(
                                          color: Colors.white,
                                        )),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: const BorderSide(
                                          color: Colors.white,
                                        ))),
                              ),
                            ),
                          ),
                        ],
                      ));
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              });
        },
      ),
    );
  }
}
