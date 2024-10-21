import 'package:flutter/material.dart';
import 'package:wifi_card/constants.dart';

class CustomCardButton extends StatelessWidget {
  CustomCardButton({
    super.key,
    required this.text,
    required this.color,
    required this.icon,
    this.onTap,
    this.flex = 1,
  });
  final String text;
  final Color color;
  final IconData icon;
  final Function()? onTap;
  final int flex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: onTap,
            child: Row(
              children: [
                Text(
                  text,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontFamily: Kprimaryfont),
                ),
                Spacer(),
                Icon(icon)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
