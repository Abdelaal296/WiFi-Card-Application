import 'package:flutter/material.dart';
import 'package:wifi_card/constants.dart';

class CustomNetworksTextField extends StatelessWidget {
  CustomNetworksTextField(
      {super.key,
      required this.text,
      this.flex = 1,
      this.color = KPrimaryColor2,
      this.type = TextInputType.number,
      required this.controller});
  final String text;
  final int flex;
  Color color;
  final TextEditingController controller;
  TextInputType? type;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        validator: (value) {
          if (value!.isEmpty) {
            return 'يرجي ادخال الحقل';
          }
          return null;
        },
        decoration: InputDecoration(
            errorStyle: TextStyle(
                fontFamily: Kprimaryfont,
                color: Colors.black,
                fontWeight: FontWeight.bold),
            label: Text(
              text,
              style: TextStyle(color: color, fontFamily: Kprimaryfont),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
                borderSide: BorderSide(
                  color: color,
                )),
            prefixIcon: Icon(
              Icons.edit,
              color: color,
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
                borderSide: BorderSide(
                  color: color,
                )),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
                borderSide: BorderSide(
                  color: color,
                ))),
      ),
    );
  }
}
