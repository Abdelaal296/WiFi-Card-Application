import 'package:flutter/material.dart';
import 'package:wifi_card/constants.dart';

class CustomLoginHeader extends StatelessWidget {
  const CustomLoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'م​َر​ْح​َب​ًا',
          style: TextStyle(
              fontFamily: Kprimaryfont,
              fontSize: 55,
              color: Colors.white,
              fontWeight: FontWeight.w500),
        ),
        Text(
          'تسجيل الدخول',
          style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: Kprimaryfont,
              fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
