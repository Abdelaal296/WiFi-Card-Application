import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wifi_card/constants.dart';
import 'package:wifi_card/core/utils/cache_helper.dart';
import 'package:wifi_card/features/adminNotification/presentation/views/show_notification.dart';
import 'package:wifi_card/features/chat/presentation/views/chat.dart';
import 'package:wifi_card/features/layout/presentation/view_models/cubit/home_service_cubit.dart';
import 'package:wifi_card/features/login/presentation/views/login.dart';
import 'package:wifi_card/features/myTransations/presentation/views/transaction.dart';
import 'package:wifi_card/features/networks/presentation/views/my_network.dart';
import 'package:wifi_card/features/profile/presentation/views/profile.dart';

import '../../../../../new_printer.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeServiceCubit, HomeServiceState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Column(
          children: [
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/background.png',
                    width: 200,
                  ),
                ],
              ),
              height: 200,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Directionality(
                            textDirection: TextDirection.rtl,
                            child: ChatScreen())));
              },
              child: ListTile(
                leading: Icon(
                  Icons.chat_bubble,
                  color: KPrimaryColor2,
                ),
                titleTextStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontFamily: Kprimaryfont),
                title: Text(
                  'التواصل',
                  style: TextStyle(fontFamily: Kprimaryfont),
                ),
              ),
            ),
            const Divider(color: Colors.black, endIndent: 25, indent: 25),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Directionality(
                            textDirection: TextDirection.rtl,
                            child: TransactionsScreen())));
              },
              child: ListTile(
                leading: Icon(
                  Icons.menu_open_sharp,
                  color: KPrimaryColor2,
                ),
                titleTextStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontFamily: Kprimaryfont),
                title: Text(
                  'عملياتى',
                  style: TextStyle(fontFamily: Kprimaryfont),
                ),
              ),
            ),
            const Divider(color: Colors.black, endIndent: 25, indent: 25),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Directionality(
                            textDirection: TextDirection.rtl,
                            child: PrinterPage())));
              },
              child: ListTile(
                leading: Icon(
                  Icons.print_rounded,
                  color: KPrimaryColor2,
                ),
                titleTextStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontFamily: Kprimaryfont),
                title: Text('اعدادات الطباعة '),
              ),
            ),
            const Divider(color: Colors.black, endIndent: 25, indent: 25),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Directionality(
                            textDirection: TextDirection.rtl,
                            child: ProfileScreen())));
              },
              child: ListTile(
                leading: Icon(
                  Icons.person,
                  color: KPrimaryColor2,
                ),
                titleTextStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontFamily: Kprimaryfont),
                title: Text('الملف الشخصى'),
              ),
            ),
            const Divider(color: Colors.black, endIndent: 25, indent: 25),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Directionality(
                            textDirection: TextDirection.rtl,
                            child: ShowNotificationsScreen())));
              },
              child: ListTile(
                trailing: CircleAvatar(
                  radius: 20,
                  backgroundColor: KPrimaryColor2,
                  child: Text(
                    '${HomeServiceCubit.get(context).count}',
                    style: TextStyle(color: KPrimaryColor1),
                  ),
                ),
                leading: Icon(
                  Icons.notification_add,
                  color: KPrimaryColor2,
                ),
                titleTextStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontFamily: Kprimaryfont),
                title: Text('الاشعارات'),
              ),
            ),
            const Divider(color: Colors.black, endIndent: 25, indent: 25),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Directionality(
                            textDirection: TextDirection.rtl,
                            child: MyNetworksScreen())));
              },
              child: ListTile(
                leading: Icon(
                  Icons.wifi,
                  color: KPrimaryColor2,
                ),
                titleTextStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontFamily: Kprimaryfont),
                title: Text('معرض شبكاتى'),
              ),
            ),
            const Divider(color: Colors.black, endIndent: 25, indent: 25),
            InkWell(
              onTap: () async {
                await CacheHelper.removeData(key: 'token');
                await CacheHelper.removeData(key: 'user_role');
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Directionality(
                            textDirection: TextDirection.rtl,
                            child: LoginScreen())));
              },
              child: ListTile(
                leading: Icon(
                  Icons.logout,
                  color: KPrimaryColor2,
                ),
                titleTextStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontFamily: Kprimaryfont),
                title: Text('خروج'),
              ),
            ),
          ],
        );
      },
    );
  }
}
