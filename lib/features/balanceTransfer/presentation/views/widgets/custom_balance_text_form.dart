import 'package:flutter/material.dart';
import 'package:wifi_card/constants.dart';

// ignore: must_be_immutable
class CustomBalanceTextField extends StatelessWidget {
  CustomBalanceTextField(
      {super.key,
      required this.hintText,
      required this.controller,
      this.obsecure = false,
      this.suffix,
      this.suffixPressed,
      this.prefix,
      this.type});

  final String hintText;
  final TextEditingController? controller;
  bool? obsecure;
  IconData? suffix;
  IconData? prefix;
  Function()? suffixPressed;
  TextInputType? type;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: type,
      cursorColor: KPrimaryColor2,
      style: const TextStyle(
        color: KPrimaryColor2,
      ),
      obscureText: obsecure!,
      validator: (value) {
        if (value!.isEmpty) {
          return 'يرجى ادخال هذا الحقل';
        }
        return null;
      },
      controller: controller,
      decoration: InputDecoration(
          errorStyle: TextStyle(
              fontFamily: Kprimaryfont,
              color: Colors.black,
              fontWeight: FontWeight.bold),
          label: Text(
            hintText,
            style: TextStyle(color: KPrimaryColor2, fontFamily: Kprimaryfont),
          ),
          focusedBorder: textFormBorder(),
          prefixIcon: Icon(
            prefix,
            color: KPrimaryColor2,
          ),
          suffixIcon: suffix != null
              ? IconButton(
                  onPressed: suffixPressed,
                  icon: Icon(
                    suffix,
                    color: KPrimaryColor2,
                  ))
              : null,
          enabledBorder: textFormBorder(),
          border: textFormBorder()),
    );
  }
}

OutlineInputBorder textFormBorder() {
  return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(16.0)),
      borderSide: BorderSide(
        color: KPrimaryColor2,
      ));
}
