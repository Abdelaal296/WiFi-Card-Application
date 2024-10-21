import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../constants.dart';

Container build_card_container(
    {required String serial, required int price, required DateTime time}) {
  return Container(
    margin: EdgeInsets.all(8),
    padding: EdgeInsets.all(8),
    width: double.infinity,
    height: 120,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 3,
          blurRadius: 7,
          offset: const Offset(0, 3),
        ),
      ],
      gradient: const LinearGradient(
        colors: [
          Colors.white,
          Color.fromARGB(255, 219, 180, 180)
        ], // Define your gradient colors here
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        stops: [0.3, 1],
        // Optional: define stops for the gradient
      ),
    ),
    child: Column(
      children: [
        Expanded(
          child: Text(
            "رقم الكارت:${serial} ",
            style: TextStyle(fontFamily: Kprimaryfont, fontSize: 18),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Expanded(
          child: Text("السعر : ${price} ريال ",
              style: TextStyle(fontFamily: Kprimaryfont, fontSize: 18)),
        ),
        SizedBox(
          height: 5,
        ),
        Expanded(
          child: Text(
              "الوقت:  ${DateFormat('yyyy-MM-dd | HH:mm').format(time)}",
              style: TextStyle(fontFamily: Kprimaryfont, fontSize: 18)),
        )
      ],
    ),
  );
}
