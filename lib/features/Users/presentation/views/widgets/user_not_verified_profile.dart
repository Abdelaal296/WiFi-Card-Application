import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wifi_card/constants.dart';
import 'package:wifi_card/core/widgets/custom_button.dart';
import 'package:wifi_card/core/widgets/custom_flutter_toast.dart';
import 'package:wifi_card/features/Users/data/models/user_model/user_model.dart';
import 'package:wifi_card/features/Users/presentation/view_models/cubit/users_cubit.dart';
import 'package:wifi_card/features/Users/presentation/views/users_not_verified.dart';
import 'package:wifi_card/features/profile/presentation/views/profile.dart';
import 'package:wifi_card/features/signUp/data/signUp_model.dart';

class UserNotVerifiedProfileScreen extends StatelessWidget {
  UserNotVerifiedProfileScreen({
    Key? key,
    required this.model,
  }) : super(key: key);

  final AllUserModel model;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UsersCubit, UsersStates>(
      listener: (context, state) {
        if (state is VerifyUserSuccessState) {
          showToast(text: state.messgae, state: ToastStates.SUCCESS);
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
            elevation: 0.0,
            backgroundColor: Colors.white,
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: GestureDetector(
                  onTap: () {
                    UsersCubit.get(context).verifyAccount(model, 1);
                  },
                  child: Row(
                    children: [
                      Text(
                        "موافقة",
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
              ),
              SizedBox(
                width: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: GestureDetector(
                  onTap: () {
                    UsersCubit.get(context).verifyAccount(model, 0);
                  },
                  child: Row(
                    children: [
                      Text(
                        "رفض",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: Kprimaryfont,
                            color: Colors.black),
                      ),
                      Icon(
                        Icons.delete,
                        size: 30,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 5,
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
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Image.asset(
                      'assets/images/profile.png',
                      width: 150,
                    ),
                    Text(
                      model.fullName!,
                      style: TextStyle(
                        color: KPrimaryColor2,
                        fontSize: 24,
                        fontFamily: Kprimaryfont,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'صاحب دكانه',
                      style: TextStyle(fontSize: 14, fontFamily: Kprimaryfont),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
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
                        SizedBox(
                          height: 20,
                        ),
                        CustomProfileItem(
                          subtitle: '',
                          icon: Icons.numbers,
                          name: 'رقم الحساب',
                          content: '${model.id}',
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomProfileItem(
                          subtitle: '',
                          icon: Icons.phone,
                          name: 'رقم الهاتف',
                          content: '${model.phoneNumber}',
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomProfileItem(
                          subtitle: '',
                          icon: Icons.home_filled,
                          name: ' العنوان',
                          content: '${model.address}',
                        ),
                        SizedBox(
                          height: 30,
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
