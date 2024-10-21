import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wifi_card/constants.dart';
import 'package:wifi_card/features/adminChat/data/admin_chat_model.dart';
import 'package:wifi_card/features/adminChat/presentation/views/chat_last_seen.dart';
import 'package:wifi_card/features/chat/data/models/message_model.dart';
import 'package:wifi_card/features/chat/presentation/view_models/cubit/chat_cubit.dart';

class AdminChatScreen extends StatelessWidget {
  AdminChatScreen({super.key});
  TextEditingController search = TextEditingController();
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: users.orderBy('lastUpdated', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<AdminMessageModel> usersList = [];
            if (snapshot.hasData) {
              for (int i = 0; i < snapshot.data!.docs.length; i++) {
                AdminMessageModel.fromJSon(snapshot.data!.docs[i]);

                usersList
                    .add(AdminMessageModel.fromJSon(snapshot.data!.docs[i]));
              }
            }
            return Scaffold(
              appBar: AppBar(
                title: const Text('التواصل'),
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(children: [
                  const SizedBox(
                    height: 12,
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: usersList.length,
                        itemBuilder: (context, index) =>
                            buildChat(usersList[index])),
                  ),
                ]),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget buildChat(AdminMessageModel adminMessageModel) {
    MessageModel? messageModel;

    return BlocProvider(
      create: (context) => ChatCubit(),
      child: BlocConsumer<ChatCubit, ChatState>(
        listener: (context, state) {},
        builder: (context, state) {
          return StreamBuilder(
              stream:
                  ChatCubit.get(context).getLastMessage(adminMessageModel.id!),
              builder: (context, snapshot) {
                final data = snapshot.data?.docs;
                final list = data
                        ?.map((e) => MessageModel.fromJSon(e.data()))
                        .toList() ??
                    [];
                if (list.isNotEmpty) messageModel = list[0];

                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Directionality(
                                textDirection: TextDirection.rtl,
                                child: ChatLastSeenScreen(
                                  id: adminMessageModel.id!,
                                ))));
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 10.0),
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: KPrimaryColor2,
                      borderRadius: BorderRadius.circular(16.0),
                      gradient: const LinearGradient(
                        colors: [
                          Colors.white,
                          Color.fromARGB(255, 219, 180, 180)
                        ], // Define your gradient colors here
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        stops: [0.3, 1],
                        // Optional: define stops for the gradient
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                                radius: 35,
                                backgroundImage: AssetImage(
                                  'assets/images/profile.png',
                                )),
                          ],
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${adminMessageModel.name}",
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontFamily: Kprimaryfont,
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      '${messageModel?.message}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Colors.black,
                                        fontFamily: Kprimaryfont,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  Row(
                                    children: [
                                      Text(messageModel == null
                                          ? ''
                                          : '${DateTime.parse(messageModel!.createdAt).hour}:${DateTime.parse(messageModel!.createdAt).minute}  ${DateTime.parse(messageModel!.createdAt).day}/${DateTime.parse(messageModel!.createdAt).month}'),
                                      messageModel?.isRead == false
                                          ? const SizedBox(
                                              width: 5,
                                            )
                                          : Container(),
                                      messageModel?.isRead == false
                                          ? const Icon(
                                              Icons.circle,
                                              color: Color.fromARGB(
                                                  255, 18, 217, 28),
                                              size: 10,
                                            )
                                          : Container(),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
