import 'package:flutter/material.dart';
import 'package:wifi_card/core/widgets/custom_painter.dart';
import 'package:wifi_card/features/signUp/presentation/views/widgets/custom_register_header.dart';
import 'package:wifi_card/features/signUp/presentation/views/widgets/register_input_fields.dart';

// ignore: must_be_immutable
class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController accountController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController activeBussinessController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: CustomPaint(
          painter: MyCustomPainter(height: 810),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              const CustomRegisterHeader(),
              const SizedBox(
                height: 10,
              ),
              CustomRegisterInputFields(
                  usernameController: usernameController,
                  activeBussinessController: activeBussinessController,
                  phoneController: phoneController,
                  addressController: addressController,
                  accountController: accountController,
                  passwordController: passwordController,
                  confirmPasswordController: confirmPasswordController),
            ],
          ),
        ),
      ),
    );
  }
}

// class _CustomeClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     double height = size.height;
//     double width = size.width;

//     var path = Path();
//     path.lineTo(0, height - 80);
//     path.quadraticBezierTo(width / 2, height, width, height - 80);
//     path.lineTo(width, 0);
//     path.close();

//     return path;
//   }

//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
//     return true;
//   }
// }
