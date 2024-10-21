import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wifi_card/constants.dart';
import 'package:wifi_card/core/widgets/custom_button.dart';
import 'package:wifi_card/features/wifiCard/presentation/view_models/cubit/wifi_cabin_cubit.dart';
import 'package:wifi_card/features/wifiCard/presentation/views/widgets/custom_wifi-cabin_container.dart';

class WifiCabinScreen extends StatelessWidget {
  WifiCabinScreen({super.key});
  TextEditingController searchController = TextEditingController();

  WifiCabinCubit wifiCabinCubit = WifiCabinCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => wifiCabinCubit..init(),
      child: BlocConsumer<WifiCabinCubit, WifiCabinState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                'كبينة Wifi',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontFamily: Kprimaryfont),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                Row(
                  children: [
                    Expanded(
                        child: CustomButton(
                      text: 'كل الشبكات',
                      flag: WifiCabinCubit.get(context).isSelected,
                      onTap: () {
                        WifiCabinCubit.get(context).changeToAllNewtworks();
                        if (WifiCabinCubit.get(context).isSelected == false)
                          WifiCabinCubit.get(context).changeButtonColor();
                      },
                      color: const Color.fromARGB(255, 58, 12, 9),
                    )),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: CustomButton(
                      text: 'المفضلة',
                      flag: !WifiCabinCubit.get(context).isSelected,
                      onTap: () {
                        WifiCabinCubit.get(context).changeToShopPeople();
                        if (WifiCabinCubit.get(context).isSelected == true)
                          WifiCabinCubit.get(context).changeButtonColor();
                      },
                      color: const Color.fromARGB(255, 58, 12, 9),
                    )),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                ConditionalBuilder(
                  condition: state is! GetNetworksCabinLoadingState,
                  builder: (context) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount:
                            WifiCabinCubit.get(context).currentNetworks.length,
                        itemBuilder: (context, index) => BlocProvider.value(
                          value: wifiCabinCubit,
                          child: CustomWifiCabinContainer(
                            cardModel: WifiCabinCubit.get(context)
                                .currentNetworks[index],
                          ),
                        ),
                      ),
                    );
                  },
                  fallback: (context) => const Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                            child: CircularProgressIndicator(
                          color: KPrimaryColor2,
                        )),
                      ],
                    ),
                  ),
                )
              ]),
            ),
          );
        },
      ),
    );
  }
}
