import 'package:flutter/material.dart';

class CustomAdminGridViewItem extends StatelessWidget {
  CustomAdminGridViewItem(
      {super.key, required this.icon, required this.label, this.onTap});

  final IconData icon;
  final String label;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32.0),
          color: Colors.white,
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 45,
              ),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 24,
                  fontFamily: 'Cairo',
                ),
              )
            ]),
      ),
    );
  }
}
