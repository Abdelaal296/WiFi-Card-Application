import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wifi_card/constants.dart';
import 'package:wifi_card/features/networks/data/card_number_model.dart';

class CustomCardNumbersContainer extends StatelessWidget {
  const CustomCardNumbersContainer(
      {super.key, required this.model, this.onPressed});
  final CardNumberModel model;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.0),
      width: double.infinity,
      height: 95,
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              model.isSold == 1
                  ? Colors.grey
                  : const Color.fromARGB(255, 219, 180, 180)
            ], // Define your gradient colors here
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            stops: [0.3, 1],
            // Optional: define stops for the gradient
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.circular(16.0)),
      child: Column(
        children: [
          Text(
            'رقم الكارت',
            style: TextStyle(
                fontFamily: Kprimaryfont,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                child: Text(
                  '${model.id}',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: Kprimaryfont,
                      fontSize: model.id.toString().length > 3 ? 12 : 16),
                ),
                backgroundColor: Colors.white,
                radius: model.id.toString().length <= 3
                    ? 15
                    : model.id.toString().length * 4,
              ),
              Text(
                '${model.cardNumber}',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontFamily: Kprimaryfont, fontSize: 16),
              ),
              IconButton(
                  onPressed: onPressed,
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 25,
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
