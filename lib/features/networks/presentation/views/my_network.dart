import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wifi_card/constants.dart';
import 'package:wifi_card/features/networks/presentation/view_models/MyNetworkCubit/my_networks_cubit.dart';
import 'package:wifi_card/features/networks/presentation/views/widgets/custom_my_networks.dart';

class MyNetworksScreen extends StatelessWidget {
  const MyNetworksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyNetworksCubit()..getMyNetworks(),
      child: BlocConsumer<MyNetworksCubit, MyNetworksState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'معرض شبكاتى',
              ),
              centerTitle: true,
            ),
            body: ConditionalBuilder(
              condition: state is! GetMyNetworksLoadingState,
              builder: (context) {
                return ListView.builder(
                  itemCount: MyNetworksCubit.get(context).myNetworks.length,
                  itemBuilder: (context, index) => CustomMyNetwork(
                    network: MyNetworksCubit.get(context).myNetworks[index],
                  ),
                );
              },
              fallback: (context) => const Center(
                  child: CircularProgressIndicator(
                color: KPrimaryColor2,
              )),
            ),
          );
        },
      ),
    );
  }
}
