import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wifi_card/constants.dart';
import 'package:wifi_card/features/adminAddNetwork/presentation/view_models/cubit/add_network_cubit.dart';
import 'package:wifi_card/features/adminAddNetwork/presentation/views/admin_add_network.dart';
import 'package:wifi_card/features/adminAddNetwork/presentation/views/widgets/custom_admin_wifi_cabin_container.dart';

class ShowNetworkScreen extends StatelessWidget {
  ShowNetworkScreen({Key? key}) : super(key: key);
  AddNetworkCubit addNetworkCubit = AddNetworkCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => addNetworkCubit..getNetworks(),
      child: BlocConsumer<AddNetworkCubit, AddNetworkState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return RefreshIndicator(
            backgroundColor: KPrimaryColor2,
            color: KPrimaryColor1,
            onRefresh: () async {
              addNetworkCubit.getNetworks();
            },
            child: Scaffold(
              appBar: AppBar(
                title: const Text("اضافه شبكه"),
                actions: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: BlocProvider.value(
                                        value: addNetworkCubit
                                          ..getUsersBalanceTransfer(),
                                        child: AdminAddNetworkScreen()))));
                      },
                      icon: const Icon(
                        Icons.add,
                        color: Colors.white,
                      )),
                ],
              ),
              body: ConditionalBuilder(
                condition: state is! GetNetworksLoadingState,
                builder: (context) {
                  return ListView.builder(
                      itemCount: AddNetworkCubit.get(context).networks.length,
                      itemBuilder: (context, index) {
                        return BlocProvider.value(
                          value: addNetworkCubit,
                          child: CustomAdminWifiCabinContainer(
                            model: AddNetworkCubit.get(context).networks[index],
                          ),
                        );
                      });
                },
                fallback: (context) => const Center(
                    child: CircularProgressIndicator(
                  color: KPrimaryColor2,
                )),
              ),
            ),
          );
        },
      ),
    );
  }
}
