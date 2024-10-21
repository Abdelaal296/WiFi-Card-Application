import 'package:flutter/material.dart';
import 'package:wifi_card/constants.dart';
import 'package:wifi_card/features/myTransations/data/transaction/transaction.dart';

class CustomTransactionContainer extends StatelessWidget {
  const CustomTransactionContainer({
    super.key,
    required this.transaction,
  });
  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(8),
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
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
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            "${transaction.id}",
            style: const TextStyle(
                fontFamily: "Cairo", fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Expanded(
                  child: Column(
                children: [
                  Text(
                    "${transaction.networkOwner == null ? transaction.shopOwner!.fullName : transaction.networkOwner!.fullName}",
                    style: const TextStyle(
                      fontFamily: "Cairo",
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              )),
              const Icon(
                Icons.arrow_forward,
                color: Colors.red,
              ),
              Expanded(
                  child: Center(
                      child: Text(
                "${transaction.vlaueTransaction} ريال",
                style: const TextStyle(fontFamily: Kprimaryfont),
                maxLines: 1,
              ))),
              const Icon(
                Icons.arrow_forward,
                color: Colors.green,
              ),
              Expanded(
                  child: Text(
                      "${transaction.networkOwner == null ? 'بيع كارت' : transaction.shopOwner!.fullName}",
                      style: const TextStyle(fontFamily: "Cairo"),
                      overflow: TextOverflow.ellipsis)),
            ],
          ),
        ],
      ),
    );
  }
}
