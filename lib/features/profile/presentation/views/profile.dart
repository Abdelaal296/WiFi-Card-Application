import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wifi_card/constants.dart';
import 'package:wifi_card/core/widgets/custom_flutter_toast.dart';
import 'package:wifi_card/core/widgets/custom_text_field.dart';
import 'package:wifi_card/features/profile/presentation/view_models/cubit/profile_cubit.dart';
import 'package:wifi_card/features/wifiCard/presentation/views/widgets/custom_alert_dialog_button.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  TextEditingController usercontroller = TextEditingController();
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  var form_key1 = GlobalKey<FormState>();
  var form_key2 = GlobalKey<FormState>();
  ProfileCubit profileCubit = ProfileCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => profileCubit,
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            body: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 300,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Image.asset(
                        'assets/images/profile.png',
                        width: 150,
                      ),
                      Text(
                        '${model!.fullName}',
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
                        model!.userRole!.name == 'shop_owner'
                            ? 'صاحب دكانه'
                            : 'صاحب شبكة',
                        style: const TextStyle(
                          fontSize: 14,
                        ),
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
                            content: '${model!.id}',
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomProfileItem(
                            subtitle: '',
                            icon: Icons.phone_android,
                            name: 'رقم الهاتف',
                            content: '${model!.phoneNumber}',
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomProfileItem(
                            subtitle: '${model!.fullName}',
                            onPressed: () {
                              usercontroller.text = model!.fullName!;
                              showDialog(
                                  context: context,
                                  builder: (context) => BlocProvider.value(
                                        value: profileCubit,
                                        child: Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: BlocConsumer<ProfileCubit,
                                              ProfileState>(
                                            listener: (context, state) {
                                              if (state
                                                  is UpdateUserNameSuccessState) {
                                                showToast(
                                                    text: state.message,
                                                    state: ToastStates.SUCCESS);
                                                Navigator.pop(context);
                                              }
                                            },
                                            builder: (context, state) {
                                              return AlertDialog(
                                                title: Form(
                                                  key: form_key1,
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      children: [
                                                        const Text(
                                                          'تحديث اسم الدخول',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  Kprimaryfont,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        const SizedBox(
                                                          height: 20,
                                                        ),
                                                        CustomTextField(
                                                          hintText:
                                                              'اسم الدخول',
                                                          controller:
                                                              usercontroller,
                                                          prefix: Icons.person,
                                                        ),
                                                        const SizedBox(
                                                          height: 30,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                                child:
                                                                    CustomAlertDialogButton(
                                                              text: 'تحديث',
                                                              color:
                                                                  Colors.green,
                                                              onPressed: () {
                                                                if (form_key1
                                                                    .currentState!
                                                                    .validate()) {
                                                                  ProfileCubit.get(
                                                                          context)
                                                                      .updateUsername(
                                                                          username:
                                                                              usercontroller.text);
                                                                }
                                                              },
                                                            )),
                                                            const SizedBox(
                                                              width: 5,
                                                            ),
                                                            Expanded(
                                                                child:
                                                                    CustomAlertDialogButton(
                                                              text: 'الغاء',
                                                              color: Colors.red,
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                            )),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ));
                            },
                            icon: Icons.person,
                            name: 'اسم الدخول',
                            content: 'تحديث',
                            isClick: true,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomProfileItem(
                            subtitle: '',
                            icon: Icons.lock,
                            name: 'كلمة السر',
                            content: 'تحديث',
                            isClick: true,
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => BlocProvider.value(
                                        value: profileCubit,
                                        child: Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: BlocConsumer<ProfileCubit,
                                              ProfileState>(
                                            listener: (context, state) {
                                              if (state
                                                  is UpdatePasswordSuccessState) {
                                                showToast(
                                                    text: state.message,
                                                    state: ToastStates.SUCCESS);
                                              }
                                            },
                                            builder: (context, state) {
                                              return AlertDialog(
                                                insetPadding:
                                                    const EdgeInsets.all(16.0),
                                                title: Container(
                                                  width: double.infinity,
                                                  child: Form(
                                                    key: form_key2,
                                                    child:
                                                        SingleChildScrollView(
                                                      child: Column(
                                                        children: [
                                                          const Text(
                                                            'تغيير كلمة السر',
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    Kprimaryfont,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          const SizedBox(
                                                            height: 20,
                                                          ),
                                                          CustomTextField(
                                                            obsecure:
                                                                ProfileCubit.get(
                                                                        context)
                                                                    .isPassword,
                                                            hintText:
                                                                'الكلمة السر الحالية',
                                                            controller:
                                                                controller1,
                                                            prefix: Icons.lock,
                                                            suffix: ProfileCubit
                                                                    .get(
                                                                        context)
                                                                .suffix,
                                                            suffixPressed: () {
                                                              ProfileCubit.get(
                                                                      context)
                                                                  .changeSuffix();
                                                            },
                                                          ),
                                                          const SizedBox(
                                                            height: 15,
                                                          ),
                                                          CustomTextField(
                                                            obsecure:
                                                                ProfileCubit.get(
                                                                        context)
                                                                    .isPassword,
                                                            hintText:
                                                                'كلمة السر لجديدة',
                                                            controller:
                                                                controller2,
                                                            prefix: Icons.lock,
                                                            suffix: ProfileCubit
                                                                    .get(
                                                                        context)
                                                                .suffix,
                                                            suffixPressed: () {
                                                              ProfileCubit.get(
                                                                      context)
                                                                  .changeSuffix();
                                                            },
                                                          ),
                                                          const SizedBox(
                                                            height: 15,
                                                          ),
                                                          CustomTextField(
                                                            obsecure:
                                                                ProfileCubit.get(
                                                                        context)
                                                                    .isPassword,
                                                            hintText:
                                                                'تاكيد كلمة السر الجديدة',
                                                            controller:
                                                                controller3,
                                                            prefix: Icons.lock,
                                                            suffix: ProfileCubit
                                                                    .get(
                                                                        context)
                                                                .suffix,
                                                            suffixPressed: () {
                                                              ProfileCubit.get(
                                                                      context)
                                                                  .changeSuffix();
                                                            },
                                                          ),
                                                          const SizedBox(
                                                            height: 30,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                  child:
                                                                      CustomAlertDialogButton(
                                                                text: 'تحديث',
                                                                color: Colors
                                                                    .green,
                                                                onPressed: () {
                                                                  if (form_key2
                                                                      .currentState!
                                                                      .validate()) {
                                                                    ProfileCubit.get(context).updatePassword(
                                                                        newPassword:
                                                                            controller2
                                                                                .text,
                                                                        newPassword_confirmation:
                                                                            controller3
                                                                                .text,
                                                                        OldPassword:
                                                                            controller1.text);
                                                                  }
                                                                },
                                                              )),
                                                              const SizedBox(
                                                                width: 5,
                                                              ),
                                                              Expanded(
                                                                  child:
                                                                      CustomAlertDialogButton(
                                                                text: 'الغاء',
                                                                color:
                                                                    Colors.red,
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                              )),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ));
                            },
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
      ),
    );
  }
}

class CustomProfileItem extends StatelessWidget {
  CustomProfileItem(
      {super.key,
      required this.name,
      required this.content,
      required this.icon,
      this.color = KPrimaryColor1,
      required this.subtitle,
      this.onPressed,
      this.onTap,
      this.isClick = false});

  final String name;
  final String content;
  final String subtitle;
  final IconData icon;
  Color color;
  bool isClick;
  Function()? onPressed;
  Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: InkWell(
        onTap: onTap,
        child: ListTile(
          horizontalTitleGap: 5,
          leading: Icon(
            icon,
            color: KPrimaryColor2,
          ),
          trailing: isClick
              ? TextButton(
                  onPressed: onPressed,
                  child: Text('$content',
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          decoration: TextDecoration.underline,
                          color: Color.fromARGB(255, 11, 85, 146),
                          fontFamily: Kprimaryfont,
                          fontSize: 20)),
                )
              : Text('$content',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: KPrimaryColor2,
                      fontFamily: Kprimaryfont,
                      fontSize: 20)),
          title: Text(
            '$name ',
            style: const TextStyle(
                color: KPrimaryColor2, fontFamily: Kprimaryfont, fontSize: 20),
          ),
          subtitle: subtitle.isEmpty
              ? null
              : Text(
                  '$subtitle',
                  style: const TextStyle(color: KPrimaryColor2),
                ),
        ),
      ),
    );
  }
}
