import 'package:flutter/material.dart';
import 'package:wifi_card/constants.dart';

class CustomTopTab extends StatelessWidget {
  const CustomTopTab(
      {super.key, required this.name, required this.id, this.value});
  final String name;
  final int id;
  final int? value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      color: KPrimaryColor2,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.wifi,
            color: Colors.white,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            value == null ? '$name | $id' : '$name | $value | $id',
            style: TextStyle(color: Colors.white, fontFamily: Kprimaryfont),
          ),
        ],
      ),
    );
  }
}
