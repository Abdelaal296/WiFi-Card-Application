import 'package:flutter/material.dart';
import 'package:wifi_card/constants.dart';
import 'package:wifi_card/features/adminAddNetwork/data/network/network.dart';
import 'package:wifi_card/features/networks/presentation/views/add_card.dart';
import 'package:wifi_card/features/networks/presentation/views/group_of_cards.dart';
import 'package:wifi_card/features/networks/presentation/views/show_card_numbers.dart';
import 'package:wifi_card/features/networks/presentation/views/widgets/custom_card_button.dart';

class CustomMyNetwork extends StatelessWidget {
  const CustomMyNetwork({
    super.key,
    required this.network,
  });

  final Network network;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      width: double.infinity,
      height: 150,
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
          borderRadius: BorderRadius.circular(16.0)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                'شبكه ${network.name}',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontFamily: Kprimaryfont),
              ),
            ),
            Text(
              'رقم الشبكة: ${network.id}',
              style: TextStyle(fontSize: 16, fontFamily: Kprimaryfont),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                CustomCardButton(
                  text: 'الكروت',
                  color: Color.fromARGB(255, 8, 151, 183),
                  icon: Icons.card_giftcard,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Directionality(
                                textDirection: TextDirection.rtl,
                                child: ShowCardNumbersScreen(
                                  network: network,
                                ))));
                  },
                ),
                SizedBox(
                  width: 5,
                ),
                CustomCardButton(
                  text: 'الفئات',
                  color: Colors.cyanAccent,
                  icon: Icons.six_k_outlined,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Directionality(
                                textDirection: TextDirection.rtl,
                                child: GruopOfCardsScreen(
                                  network: network,
                                ))));
                  },
                ),
                SizedBox(
                  width: 5,
                ),
                CustomCardButton(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Directionality(
                                textDirection: TextDirection.rtl,
                                child: AddCardAndReport(
                                  network: network,
                                ))));
                  },
                  text: 'التقرير',
                  color: Color.fromARGB(255, 221, 227, 27),
                  icon: Icons.add,

                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
