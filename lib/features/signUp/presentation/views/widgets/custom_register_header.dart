import 'package:flutter/material.dart';

import '../../../../../constants.dart';

class CustomRegisterHeader extends StatelessWidget {
  const CustomRegisterHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'تسجيل',
          style: TextStyle(
              fontFamily: Kprimaryfont,
              fontSize: 38,
              color: Colors.white,
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
