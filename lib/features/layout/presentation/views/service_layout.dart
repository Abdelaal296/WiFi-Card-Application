import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wifi_card/constants.dart';
import 'package:wifi_card/features/layout/presentation/view_models/cubit/home_service_cubit.dart';
import 'package:wifi_card/features/layout/presentation/views/widgets/custom_drawer.dart';

class ServiceLayout extends StatelessWidget {
  ServiceLayout({super.key});

  var drawerkey = GlobalKey();
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeServiceCubit()
        ..showUser()
        ..getBalance()
        ..getNotifications(),
      child: BlocConsumer<HomeServiceCubit, HomeServiceState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return RefreshIndicator(
            backgroundColor: KPrimaryColor2,
            color: KPrimaryColor1,
            onRefresh: () async {
              HomeServiceCubit.get(context).getBalance();
              HomeServiceCubit.get(context).getNotifications();
            },
            child: Scaffold(
              backgroundColor: Colors.white,
              key: _key,
              floatingActionButton: Container(
                alignment: Alignment.bottomRight,
                margin: const EdgeInsets.only(right: 20.0, bottom: 10.0),
                child: FloatingActionButton(
                  onPressed: () {
                    _key.currentState!.openEndDrawer();
                  },
                  backgroundColor: KPrimaryColor2,
                  child: const Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                ),
              ),
              endDrawer: const Drawer(
                width: 250,
                backgroundColor: Colors.white,
                child: CustomDrawer(),
              ),
              appBar: AppBar(
                backgroundColor: KPrimaryColor2,
                title: const Text(
                  'WI-FI CARD',
                  style: TextStyle(fontFamily: Kprimaryfont),
                ),
                centerTitle: true,
                iconTheme: const IconThemeData(color: Colors.white),
              ),
              body: HomeServiceCubit.get(context)
                  .screens[HomeServiceCubit.get(context).selectedindex],
              bottomNavigationBar: BottomNavigationBar(
                backgroundColor: KPrimaryColor2,
                unselectedIconTheme: const IconThemeData(color: Colors.white),
                selectedIconTheme: const IconThemeData(color: Colors.black),
                currentIndex: HomeServiceCubit.get(context).selectedindex,
                onTap: (index) {
                  HomeServiceCubit.get(context).changeBottomBar(index);
                },
                items: [
                  BottomNavigationBarItem(
                    icon: _buildIcon(Icons.home, 'الرئيسية', 0, context),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon:
                        _buildIcon(Icons.description, 'بيع الكروت', 1, context),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: _buildIcon(Icons.more, 'المزيد', 2, context),
                    label: '',
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildIcon(
          IconData iconData, String text, int index, BuildContext context) =>
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: HomeServiceCubit.get(context).selectedindex == index
              ? Colors.white
              : KPrimaryColor2,
        ),
        width: double.infinity,
        height: kBottomNavigationBarHeight,
        child: InkWell(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(iconData),
              Text(text,
                  style: TextStyle(
                      fontSize: 12,
                      fontFamily: Kprimaryfont,
                      color:
                          HomeServiceCubit.get(context).selectedindex == index
                              ? KPrimaryColor2
                              : Colors.white,
                      fontWeight: FontWeight.bold)),
            ],
          ),
          // onTap: () => _onItemTapped(index),
        ),
      );
}
