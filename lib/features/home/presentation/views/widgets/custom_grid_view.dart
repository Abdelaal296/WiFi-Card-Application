import 'package:flutter/material.dart';
import 'package:wifi_card/constants.dart';
import 'package:wifi_card/features/balanceTransfer/presentation/views/balance_transfer.dart';
import 'package:wifi_card/features/home/presentation/views/widgets/custom_grid_item.dart';
import 'package:wifi_card/features/myTransations/presentation/views/my_transactions.dart';
import 'package:wifi_card/features/myTransations/presentation/views/transaction.dart';
import 'package:wifi_card/features/networks/presentation/views/my_network.dart';
import 'package:wifi_card/features/wifiCard/presentation/views/wifi_cabin.dart';

class CustomGridView extends StatelessWidget {
  const CustomGridView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 16.0,
          crossAxisCount: 2,
          mainAxisSpacing: 14.0,
          childAspectRatio: MediaQuery.of(context).size.width *
              1.43 /
              MediaQuery.of(context).size.height *
              2),
      children: [
        CustomGridItem(
          label: 'كبينة السداد',
          icon: Icons.phone_android,
          color: Colors.redAccent,
          onTap: () {
            CustomHomeAlertDialog(context, 'سوف تكون متاحة قريباً');
          },
        ),
        CustomGridItem(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Directionality(
                        textDirection: TextDirection.rtl,
                        child: WifiCabinScreen())));
          },
          label: 'كبينة WIFI',
          icon: Icons.wifi,
          color: Color.fromARGB(255, 66, 89, 103),
        ),
        CustomGridItem(
          label: 'معرض شبكاتى',
          icon: Icons.portable_wifi_off_outlined,
          color: Colors.brown,
          onTap: () {
            if (user_role == "shop_owner") {
              CustomHomeAlertDialog(context, 'ليس لديك صلاحية');
            } else {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Directionality(
                          textDirection: TextDirection.rtl,
                          child: MyNetworksScreen())));
            }
          },
        ),
        CustomGridItem(
          onTap: () {
            if (user_role == "shop_owner") {
              CustomHomeAlertDialog(context, 'ليس لديك صلاحية');
            } else {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Directionality(
                          textDirection: TextDirection.rtl,
                          child: BalanceTransferScreen())));
            }
          },
          label: 'تحويل الرصيد',
          icon: Icons.change_circle,
          color: Colors.blue[900]!,
        ),
        CustomGridItem(
          label: 'العمليات',
          icon: Icons.menu_open,
          color: Color.fromARGB(255, 226, 212, 50),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Directionality(
                        textDirection: TextDirection.rtl,
                        child: TransactionsScreen())));
          },
        ),
        CustomGridItem(
          label: 'غذى حسابك',
          icon: Icons.person_add_alt,
          color: Color.fromARGB(255, 48, 138, 83),
          onTap: () {
            CustomHomeAlertDialog(context, 'سوف تكون متاحة قريباً');
          },
        ),
      ],
    );
  }

  Future<dynamic> CustomHomeAlertDialog(BuildContext context, String text) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Column(
          children: [
            Icon(
              Icons.access_time,
              color: Colors.amberAccent,
              size: 45,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              text,
              style: TextStyle(fontSize: 24, fontFamily: Kprimaryfont),
            ),
          ],
        ),
        actions: <Widget>[
          Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: KPrimaryColor2,
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "حسنا",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: Kprimaryfont),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
