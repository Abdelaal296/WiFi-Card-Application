import 'package:flutter/material.dart';
import 'package:wifi_card/constants.dart';
import 'package:wifi_card/features/adminAddNetwork/data/network/network.dart';
import 'package:wifi_card/features/networks/data/category_model.dart';
import 'package:wifi_card/features/networks/presentation/views/add_cards_value.dart';

class CustomListItem extends StatelessWidget {
  const CustomListItem({
    super.key,
    required this.model,
    required this.network,
  });

  final CategoryModel model;
  final Network network;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: double.infinity,
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              const Color.fromARGB(255, 219, 180, 180)
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
          borderRadius: BorderRadius.circular(8.0)),
      child: Row(
        children: [
          CircleAvatar(
            child: Text(
              '${model.cardNumbersNotSaleCount}',
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: Kprimaryfont,
                  fontSize: model.cardNumbersNotSaleCount.toString().length > 3
                      ? 12
                      : 16),
            ),
            backgroundColor: Colors.white,
            radius: model.cardNumbersNotSaleCount.toString().length <= 3
                ? 15
                : model.cardNumbersNotSaleCount.toString().length * 4,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            'الباقى فى',
            style: TextStyle(
                color: Colors.black, fontFamily: Kprimaryfont, fontSize: 14),
          ),
          Spacer(),
          Text(
            'فئة ${model.category}',
            style: TextStyle(
                color: Colors.black,
                fontFamily: Kprimaryfont,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          Spacer(),
          Text(
            'تم بيع',
            style: TextStyle(
                color: Colors.black, fontFamily: Kprimaryfont, fontSize: 14),
          ),
          SizedBox(
            width: 5,
          ),
          CircleAvatar(
            backgroundColor: Colors.amberAccent,
            child: Text('${model.cardNumbersSaleCount}',
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: Kprimaryfont,
                    fontSize: model.cardNumbersSaleCount.toString().length > 3
                        ? 12
                        : 16)),
            radius: model.cardNumbersSaleCount.toString().length <= 3
                ? 15
                : model.cardNumbersSaleCount.toString().length * 4,
          ),
          Spacer(),
          InkWell(
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Directionality(
                          textDirection: TextDirection.rtl,
                          child: AddCardsValue(
                            model: model,
                            network: network,
                          ))));
            },
            child: Container(
              height: 45,
              width: 100,
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.black,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'اضافة',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: Kprimaryfont,
                        fontSize: 16),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
