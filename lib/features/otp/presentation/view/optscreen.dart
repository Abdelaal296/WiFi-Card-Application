import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wifi_card/constants.dart';
import 'package:wifi_card/core/widgets/custom_button.dart';
import 'package:wifi_card/core/widgets/custom_flutter_toast.dart';
import 'package:wifi_card/core/widgets/custom_text_field.dart';
import 'package:wifi_card/features/login/presentation/view_models/cubit/login_cubit.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({Key? key, required this.phone}) : super(key: key);
  final String phone;
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  TextEditingController verifyCodeController = TextEditingController();
  var form_key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit()..forgetPassword(phone: phone),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is ResetPasswordSuccessState) {
            showToast(
                text: 'تم تغيير كلمة المرور بنجاح', state: ToastStates.SUCCESS);
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("استرجاع كلمه المرور"),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                width: double.infinity,
                child: Form(
                  key: form_key,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "رمز التحقق",
                          style: TextStyle(
                              fontFamily: Kprimaryfont,
                              fontWeight: FontWeight.bold,
                              fontSize: 28),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          "لقد أرسلنا رمز التحقق إلى",
                          style:
                              TextStyle(fontFamily: Kprimaryfont, fontSize: 20),
                        ),
                        Text(
                          "${phone}",
                          style: const TextStyle(
                              fontFamily: Kprimaryfont,
                              fontSize: 20,
                              color: Colors.black),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Form(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(child: buildSizedBox(context)),
                              Expanded(child: buildSizedBox(context)),
                              Expanded(child: buildSizedBox(context)),
                              Expanded(child: buildSizedBox(context)),
                            ],
                          )),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        CustomTextField(
                          controller: passwordController,
                          hintText: 'كلمة المرور',
                          prefix: Icons.lock,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          controller: passwordConfirmController,
                          hintText: 'تاكيد كلمة المرور',
                          prefix: Icons.lock,
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: CustomButton(
                              text: "تاكيد",
                              flag: false,
                              color: Colors.green,
                              onTap: () {
                                print(verifyCodeController.text);
                                if (form_key.currentState!.validate()) {
                                  LoginCubit.get(context).resetPassword(
                                      phone: phone,
                                      password: passwordController.text,
                                      passwordConfirm:
                                          passwordConfirmController.text,
                                      verifyCode: verifyCodeController.text);
                                }
                              },
                            )),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                                child: CustomButton(
                                    text: "الغاء",
                                    flag: true,
                                    color: KPrimaryColor2,
                                    onTap: () {
                                      Navigator.pop(context);
                                    })),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildSizedBox(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: SizedBox(
        height: 68,
        width: 64,
        child: TextFormField(
          textDirection: TextDirection.ltr,
          onChanged: (value) {
            if (value.length == 1) FocusScope.of(context).nextFocus();
            verifyCodeController.text += value;
          },
          decoration: InputDecoration(
              hintText: "0",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
            FilteringTextInputFormatter.digitsOnly,
          ],
        ),
      ),
    );
  }
}
