import 'package:flutter/material.dart';
import 'package:wifi_card/constants.dart';
import 'package:wifi_card/features/signUp/presentation/views/sign_up.dart';

class CustomSignUpRow extends StatelessWidget {
  const CustomSignUpRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('ليس لديك حساب ؟',
            style: TextStyle(
                fontFamily: Kprimaryfont,
                color: KPrimaryColor2,
                fontSize: 16,
                fontWeight: FontWeight.bold)),
        const SizedBox(
          width: 5,
        ),
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Directionality(
                        textDirection: TextDirection.rtl,
                        child: SignUpScreen())));
          },
          child: const Text('انشاء حساب',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: Kprimaryfont,
                  fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
