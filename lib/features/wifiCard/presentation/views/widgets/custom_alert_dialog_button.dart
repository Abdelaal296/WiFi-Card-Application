import 'package:flutter/material.dart';
import 'package:wifi_card/constants.dart';

class CustomAlertDialogButton extends StatelessWidget {
  const CustomAlertDialogButton({
    super.key,
    required this.text,
    required this.color,
    this.onPressed,
  });
  final String text;
  final Color color;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(16.0)),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: Kprimaryfont),
          ),
        ),
      ),
    );
  }
}
