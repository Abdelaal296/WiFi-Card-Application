import 'dart:developer';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wifi_card/constants.dart';
import 'package:wifi_card/core/utils/cache_helper.dart';
import 'package:wifi_card/core/widgets/custom_button.dart';
import 'package:wifi_card/core/widgets/custom_flutter_toast.dart';
import 'package:wifi_card/core/widgets/custom_text_field.dart';

import 'package:wifi_card/features/adminHome/presentation/views/admin_home.dart';
import 'package:wifi_card/features/home/presentation/views/home.dart';
import 'package:wifi_card/features/layout/presentation/views/service_layout.dart';
import 'package:wifi_card/features/login/presentation/view_models/cubit/login_cubit.dart';
import 'package:wifi_card/features/login/presentation/views/widgets/custom_sign_up_row.dart';
import 'package:wifi_card/features/otp/presentation/view/optscreen.dart';

class CustomInputFields extends StatelessWidget {
  CustomInputFields({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  var form_key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            showToast(text: 'Login Sucessfully', state: ToastStates.SUCCESS);
            user_role = state.loginModel!.role_type;
            log(user_role!);
            token =
                '${state.loginModel!.token_type}${state.loginModel!.access_token!}';
            log(token!);
            CacheHelper.putData(key: 'token', value: '${state.loginModel!.token_type}${state.loginModel!.access_token!}');
            CacheHelper.putData(key: 'user_role', value: user_role!);
            if (state.loginModel!.role_type == 'admin') {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Directionality(
                          textDirection: TextDirection.rtl,
                          child: AdminHomeScreen())));
            } else {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Directionality(
                          textDirection: TextDirection.rtl,
                          child: ServiceLayout())));
            }
          } else if (state is LoginErrorState) {
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
                    type: TextInputType.phone,
                    hintText: 'رقم الهاتف',
                    controller: emailController,
                    prefix: Icons.phone_android,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    obsecure: LoginCubit.get(context).isPassword,
                    type: TextInputType.visiblePassword,
                    hintText: 'كلمة المرور',
                    controller: passwordController,
                    prefix: Icons.lock,
                    suffix: LoginCubit.get(context).suffix,
                    suffixPressed: () {
                      LoginCubit.get(context).changeSuffix();
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () {
                      if (emailController.text == "") {
                        showToast(
                            text: "يرجي ادخال رقم الهاتف اولا ",
                            state: ToastStates.ERROR);
                      } else if (emailController.text.length < 10) {
                        showToast(
                            text: "رقم الهاتف غير صحيح ",
                            state: ToastStates.ERROR);
                      } else {
                        print(emailController.text);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: OtpScreen(
                                      phone: emailController.text,
                                    ))));
                      }
                    },
                    child: const Text('هل نسيت كلمة المرور ؟',
                        style: TextStyle(
                            fontFamily: Kprimaryfont,
                            color: KPrimaryColor2,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ConditionalBuilder(
                    condition: state is! LoginLoadingState,
                    builder: (context) => CustomButton(
                      flag: true,
                      text: 'الدخول',
                      onTap: () {
                        if (form_key.currentState!.validate()) {
                          LoginCubit.get(context).userLogin(
                              phone: emailController.text,
                              password: passwordController.text);
                        }
                      },
                    ),
                    fallback: (context) => Center(
                        child: CircularProgressIndicator(
                      color: KPrimaryColor2,
                    )),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const CustomSignUpRow(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
