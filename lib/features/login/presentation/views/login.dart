import 'package:flutter/material.dart';
import 'package:wifi_card/core/widgets/custom_painter.dart';
import 'package:wifi_card/features/login/presentation/views/widgets/custom_input_fields.dart';
import 'package:wifi_card/features/login/presentation/views/widgets/custom_login_header.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: CustomPaint(
          painter: MyCustomPainter(height: 810),
          child: Column(
            children: [
              const SizedBox(
                height: 150,
              ),
              const CustomLoginHeader(),
              const SizedBox(
                height: 100,
              ),
              CustomInputFields(
                  emailController: emailController,
                  passwordController: passwordController),
            ],
          ),
        ),
      ),
    );
  }
}
