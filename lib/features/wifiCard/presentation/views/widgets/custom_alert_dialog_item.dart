import 'package:flutter/material.dart';

import '../../../../../constants.dart';

class CustomAlertDialogItem extends StatelessWidget {
  const CustomAlertDialogItem({
    super.key,
    required this.name,
    required this.content,
  });
  final String name;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[300],
      ),
      child: Row(
        children: [
          Text(
            '$name :',
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: Kprimaryfont),
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            content,
            style: const TextStyle(fontSize: 16, fontFamily: Kprimaryfont),
          )
        ],
      ),
    );
  }
}
