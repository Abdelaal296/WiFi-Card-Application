import 'package:flutter/material.dart';
import 'package:wifi_card/constants.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  CustomTextField(
      {super.key,
      required this.hintText,
      required this.controller,
      this.obsecure = false,
      this.suffix,
      this.suffixPressed,
      this.prefix,
      this.type,
      this.isNullable = false,
      this.onChanged,
      this.color = KPrimaryColor2});

  final String hintText;
  final TextEditingController? controller;
  bool? obsecure;
  IconData? suffix;
  IconData? prefix;
  Function()? suffixPressed;
  TextInputType? type;
  Color color;
  bool isNullable;
  Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      keyboardType: type,
      cursorColor: color,
      style: TextStyle(
        color: color,
      ),
      obscureText: obsecure!,
      validator: isNullable
          ? null
          : (value) {
              if (value!.isEmpty) {
                return 'يرجي ادخال هذا الحقل';
              }
              return null;
            },
      controller: controller,
      decoration: InputDecoration(
          errorStyle: TextStyle(
              fontFamily: Kprimaryfont,
              color: Colors.black,
              fontWeight: FontWeight.bold),
          hintStyle: TextStyle(fontFamily: Kprimaryfont),
          label: Text(
            hintText,
            style: TextStyle(color: color, fontFamily: Kprimaryfont),
          ),
          focusedBorder: textFormBorder(),
          prefixIcon: Icon(
            prefix,
            color: color,
          ),
          suffixIcon: suffix != null
              ? IconButton(
                  onPressed: suffixPressed,
                  icon: Icon(
                    suffix,
                    color: color,
                  ))
              : null,
          enabledBorder: textFormBorder(),
          border: textFormBorder()),
    );
  }

  OutlineInputBorder textFormBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
        borderSide: BorderSide(
          color: color,
        ));
  }
}
