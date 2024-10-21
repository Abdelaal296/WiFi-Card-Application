import 'dart:developer';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wifi_card/constants.dart';
import 'package:wifi_card/core/widgets/custom_button.dart';
import 'package:wifi_card/core/widgets/custom_flutter_toast.dart';
import 'package:wifi_card/core/widgets/custom_text_field.dart';
import 'package:wifi_card/features/signUp/presentation/view_models/cubit/sign_up_cubit.dart';

class CustomRegisterInputFields extends StatelessWidget {
  CustomRegisterInputFields({
    super.key,
    required this.usernameController,
    required this.activeBussinessController,
    required this.phoneController,
    required this.addressController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.accountController,
  });

  final TextEditingController usernameController;
  final TextEditingController activeBussinessController;
  final TextEditingController phoneController;
  final TextEditingController addressController;

  final TextEditingController passwordController;
  final TextEditingController accountController;
  final TextEditingController confirmPasswordController;
  var form_key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: BlocConsumer<SignUpCubit, SignUpState>(
        listener: (context, state) {
          if (state is SignUpSuccessState) {
            log(state.resgisterModel!.message!);
            showToast(
                text: state.resgisterModel!.message!,
                state: ToastStates.SUCCESS);
            Navigator.pop(context);
          } else if (state is SignUpErrorState) {
            log(state.error);
            showToast(text: state.error, state: ToastStates.ERROR);
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: form_key,
              child: Column(
                children: [
                  CustomTextField(
                    color: const Color.fromARGB(255, 226, 172, 168),
                    type: TextInputType.name,
                    controller: usernameController,
                    hintText: 'الاسم الرباعى',
                    prefix: Icons.groups_2,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    color: const Color.fromARGB(255, 226, 172, 168),
                    type: TextInputType.name,
                    controller: activeBussinessController,
                    hintText: 'النشاط التجارى',
                    prefix: Icons.home_work,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    type: TextInputType.phone,
                    controller: phoneController,
                    hintText: '(كود البلد) رقم الهاتف',
                    prefix: Icons.phone_android,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    type: TextInputType.streetAddress,
                    controller: addressController,
                    hintText: 'العنوان',
                    prefix: Icons.home,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    type: TextInputType.phone,
                    controller: accountController,
                    hintText: 'رقم حساب الموزع (اختيارى)',
                    prefix: Icons.phone_enabled,
                    isNullable: true,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    obsecure: SignUpCubit.get(context).isPassword,
                    type: TextInputType.visiblePassword,
                    hintText: 'كلمة المرور',
                    controller: passwordController,
                    prefix: Icons.lock,
                    suffix: SignUpCubit.get(context).suffix,
                    suffixPressed: () {
                      SignUpCubit.get(context).changeSuffix();
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    obsecure: SignUpCubit.get(context).isPassword,
                    type: TextInputType.visiblePassword,
                    hintText: 'تاكيد كلمة المرور',
                    controller: confirmPasswordController,
                    prefix: Icons.lock,
                    suffix: SignUpCubit.get(context).suffix,
                    suffixPressed: () {
                      SignUpCubit.get(context).changeSuffix();
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ConditionalBuilder(
                    condition: state is! SignUpLoadingSate,
                    builder: (context) => CustomButton(
                      flag: true,
                      onTap: () {
                        if (form_key.currentState!.validate()) {
                          SignUpCubit.get(context).userRegister(
                              commercial_activity:
                                  activeBussinessController.text,
                              password: passwordController.text,
                              password_confirmation:
                                  confirmPasswordController.text,
                              distributor_account_number:
                                  accountController.text,
                              name: usernameController.text,
                              phone: phoneController.text,
                              address: addressController.text);
                        }
                      },
                      pheight: 55,
                      text: 'التسجيل',
                    ),
                    fallback: (context) => const Center(
                        child: CircularProgressIndicator(
                      color: KPrimaryColor2,
                    )),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
