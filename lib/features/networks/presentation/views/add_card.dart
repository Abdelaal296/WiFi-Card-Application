import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wifi_card/constants.dart';
import 'package:wifi_card/features/adminAddNetwork/data/network/network.dart';
import 'package:wifi_card/features/networks/presentation/view_models/ReportAndCardCubit/report_and_card_cubit.dart';
import 'package:wifi_card/features/networks/presentation/views/widgets/custom_list_item.dart';
import 'package:wifi_card/features/networks/presentation/views/widgets/custom_top_tab.dart';

class AddCardAndReport extends StatelessWidget {
  const AddCardAndReport({super.key, required this.network});
  final Network network;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReportAndCardCubit()..getCardNumbers(network.id!),
      child: BlocConsumer<ReportAndCardCubit, ReportAndCardState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'معرض شبكاتى',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),
            body: Column(
              children: [
                CustomTopTab(
                  name: 'شبكة ${network.name}',
                  id: network.id!,
                ),
                ConditionalBuilder(
                  condition: state is! GetCardNumbersLoadingState,
                  builder: (context) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount:
                            ReportAndCardCubit.get(context).cardNumbers.length,
                        itemBuilder: (context, index) => CustomListItem(
                            network: network,
                            model: ReportAndCardCubit.get(context)
                                .cardNumbers[index]),
                      ),
                    );
                  },
                  fallback: (context) => const Expanded(
                      child: Center(
                          child: CircularProgressIndicator(
                    color: KPrimaryColor2,
                  ))),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
