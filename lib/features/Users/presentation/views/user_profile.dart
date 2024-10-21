import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wifi_card/core/widgets/custom_flutter_toast.dart';
import 'package:wifi_card/features/Users/data/models/user_model/user_model.dart';
import 'package:wifi_card/features/Users/presentation/view_models/cubit/users_cubit.dart';
import 'package:wifi_card/features/Users/presentation/views/widgets/chat_user.dart';
import 'package:wifi_card/features/myTransations/presentation/views/my_transactions.dart';

import '../../../../constants.dart';
import '../../../profile/presentation/views/profile.dart';

class UserProfileScreen extends StatelessWidget {
  UserProfileScreen({Key? key, required this.model, required this.iSNetwork})
      : super(key: key);
  final AllUserModel model;
  final bool iSNetwork;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UsersCubit>();
    return BlocConsumer<UsersCubit, UsersStates>(
      listener: (context, state) {
        if (state is VerifyNetworkOwnerSuccessState) {
          showToast(text: state.messgae, state: ToastStates.SUCCESS);
          // UsersCubit.get(context).update();
        }
        if (state is BanUserSuccessState) {
          showToast(text: state.messgae, state: ToastStates.SUCCESS);
        }
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leadingWidth: 120,
            leading: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: ChatUserScreen(
                                    allUserModel: model,
                                  ))));
                    },
                    icon: const Icon(
                      Icons.chat,
                      color: Colors.black,
                      size: 25,
                    ))
              ],
            ),
            elevation: 0.0,
            backgroundColor: Colors.white,
            actions: iSNetwork
                ? [
                    InkWell(
                        onTap: () async {
                          await UsersCubit.get(context).banUser(model);
                        },
                        child: UsersCubit.get(context).banWidget),
                  ]
                : [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: GestureDetector(
                        onTap: () {
                          UsersCubit.get(context).verifyNetworkOwner(model);
                        },
                        child: const Row(
                          children: [
                            Text(
                              "صاحب شبكة",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: Kprimaryfont,
                                  color: Colors.black),
                            ),
                            Icon(
                              Icons.assignment_turned_in,
                              size: 30,
                              color: Colors.green,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
          ),
          body: Column(
            children: [
              Container(
                width: double.infinity,
                height: 260,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Image.asset(
                      'assets/images/profile.png',
                      width: 150,
                    ),
                    Text(
                      model.fullName!,
                      style: const TextStyle(
                        color: KPrimaryColor2,
                        fontSize: 24,
                        fontFamily: Kprimaryfont,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      !iSNetwork ? 'صاحب دكانه' : 'صاحب شبكة',
                      style: const TextStyle(
                          fontSize: 14, fontFamily: Kprimaryfont),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xff710019),
                          Color.fromARGB(255, 227, 134, 134)
                        ], // Define your gradient colors here
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [0.3, 1],
                        // Optional: define stops for the gradient
                      ),
                      color: KPrimaryColor2,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.0),
                          topRight: Radius.circular(16.0))),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        CustomProfileItem(
                          subtitle: '',
                          icon: Icons.numbers,
                          name: 'رقم الحساب',
                          content: '${model.id}',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomProfileItem(
                          subtitle: '',
                          icon: Icons.phone,
                          name: 'رقم الهاتف',
                          content: '${model.phoneNumber}',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomProfileItem(
                          subtitle: '',
                          icon: Icons.home_filled,
                          name: ' العنوان',
                          content: '${model.address}',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomProfileItem(
                          subtitle: '',
                          icon: Icons.change_circle_rounded,
                          name: 'عملياته',
                          content: '',
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: MyTransactionsScreen(
                                            id: model.id!))));
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        !iSNetwork
                            ? CustomProfileItem(
                                subtitle: '',
                                icon: Icons.delete_forever,
                                name:
                                    model.ban == 1 ? 'فك الحظر' : ' حظر الحساب',
                                content: '',
                                onTap: () async {
                                  await UsersCubit.get(context).banUser(model);
                                },
                              )
                            : const SizedBox(
                                height: 10,
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
    ;
  }
}
