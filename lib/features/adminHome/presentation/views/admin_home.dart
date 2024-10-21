import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wifi_card/constants.dart';
import 'package:wifi_card/features/Users/presentation/view_models/cubit/users_cubit.dart';
import 'package:wifi_card/features/Users/presentation/views/Users.dart';
import 'package:wifi_card/features/adminAddNetwork/presentation/views/show_network.dart';
import 'package:wifi_card/features/adminChat/presentation/views/admin_chat_screen.dart';
import 'package:wifi_card/features/adminHome/presentation/views/about.dart';
import 'package:wifi_card/features/adminHome/presentation/views/widgets/custom_admin_grid_view_item.dart';
import 'package:wifi_card/features/adminNotification/presentation/views/show_notification.dart';
import 'package:wifi_card/features/admin_transaction/presentation/views/admin_transaction.dart';
import 'package:wifi_card/features/login/presentation/views/login.dart';

class AdminHomeScreen extends StatelessWidget {
  AdminHomeScreen({Key? key}) : super(key: key);
  UsersCubit usersCubit = UsersCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => usersCubit..init(),
      child: BlocConsumer<UsersCubit, UsersStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return RefreshIndicator(
            backgroundColor: KPrimaryColor2,
            color: KPrimaryColor1,
            onRefresh: () async {
              usersCubit.init();
            },
            child: Scaffold(
              body: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 220, 126, 126),
                      Color.fromARGB(255, 219, 152, 152)
                    ], // Define your gradient colors here
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    stops: [0.4, 0.7],
                    // Optional: define stops for the gradient
                  ),
                ),
                child: Column(children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.0)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {
                              token = "";
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: LoginScreen())));
                            },
                            icon: const Icon(Icons.logout)),
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: AboutScreen())));
                            },
                            icon: const Icon(
                              Icons.contact_mail,
                              size: 30,
                            )),
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: ShowNotificationsScreen())));
                            },
                            icon: Icon(
                              Icons.notification_add,
                              size: 30,
                              color: count != 0 ? Colors.yellow : Colors.black,
                            )),
                        const Spacer(),
                        const Text(
                          'WI-FI CARD',
                          style: TextStyle(
                              fontSize: 24,
                              fontFamily: Kprimaryfont,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 16.0,
                          crossAxisCount: 2,
                          mainAxisSpacing: 14.0,
                          childAspectRatio: MediaQuery.of(context).size.width *
                              1.43 /
                              MediaQuery.of(context).size.height *
                              2),
                      children: [
                        CustomAdminGridViewItem(
                          label: 'الأعضاء',
                          icon: Icons.groups_3,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: BlocProvider.value(
                                            value: usersCubit,
                                            child: UsersScreen()))));
                          },
                        ),
                        CustomAdminGridViewItem(
                          label: 'العمليات',
                          icon: Icons.attach_money_outlined,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: BlocProvider.value(
                                            value: usersCubit,
                                            child:
                                                const AdminTransactionScreen()))));
                          },
                        ),
                        CustomAdminGridViewItem(
                          label: 'إِضافة شبكة',
                          icon: Icons.add,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: ShowNetworkScreen())));
                          },
                        ),
                        CustomAdminGridViewItem(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: AdminChatScreen())));
                          },
                          label: 'التواصل',
                          icon: Icons.chat,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 350,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(32.0)),
                    child: Column(children: [
                      const Text(
                        'الاحصائيات',
                        style:
                            TextStyle(fontFamily: Kprimaryfont, fontSize: 22),
                      ),
                      const Divider(
                        color: Colors.black,
                        endIndent: 20,
                        indent: 20,
                      ),
                      CustomInformationListTile(
                        title: 'أصحاب الشبكة',
                        value: UsersCubit.get(context).networkPeople.length,
                        icon: Icons.assignment_turned_in,
                      ),
                      const Divider(
                        color: Colors.black,
                        endIndent: 40,
                        indent: 40,
                      ),
                      CustomInformationListTile(
                        title: 'أصحاب الدكانة',
                        value: UsersCubit.get(context).shopPeople.length,
                        icon: Icons.business,
                      ),
                      const Divider(
                        color: Colors.black,
                        endIndent: 40,
                        indent: 40,
                      ),
                      CustomInformationListTile(
                        title: 'العمليات',
                        value: UsersCubit.get(context).transactions.length,
                        icon: Icons.change_circle_rounded,
                      ),
                      const Divider(
                        color: Colors.black,
                        endIndent: 40,
                        indent: 40,
                      ),
                      CustomInformationListTile(
                        title: 'الارباح',
                        value: UsersCubit.get(context).fees.toInt(),
                        icon: Icons.change_circle_rounded,
                      ),
                    ]),
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ]),
              ),
            ),
          );
        },
      ),
    );
  }
}

class CustomInformationListTile extends StatelessWidget {
  const CustomInformationListTile({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });
  final IconData icon;
  final String title;
  final int value;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minLeadingWidth: 4.0,
      leading: Icon(
        icon,
        color: const Color.fromARGB(255, 220, 126, 126),
      ),
      trailing: Text(
        value.toString(),
        style: const TextStyle(
            fontFamily: Kprimaryfont,
            color: Color.fromARGB(255, 220, 126, 126),
            fontSize: 18,
            fontWeight: FontWeight.bold),
      ),
      title: Text(
        title,
        style: const TextStyle(fontFamily: Kprimaryfont, fontSize: 18),
      ),
    );
  }
}
