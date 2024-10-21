import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wifi_card/constants.dart';
import 'package:wifi_card/core/widgets/custom_flutter_toast.dart';
import 'package:wifi_card/features/adminAddNetwork/data/network/network.dart';
import 'package:wifi_card/features/networks/presentation/view_models/CardNumbersCubit/card_numbers_cubit.dart';
import 'package:wifi_card/features/networks/presentation/views/widgets/custom_card_numbers_container.dart';
import 'package:wifi_card/features/networks/presentation/views/widgets/custom_top_tab.dart';

class ShowCardNumbersScreen extends StatelessWidget {
  const ShowCardNumbersScreen({super.key, required this.network});
  final Network network;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CardNumbersCubit()..getCardNumbers(network.id!),
      child: BlocConsumer<CardNumbersCubit, CardNumbersState>(
        listener: (context, state) {
          if (state is DeleteCardSuccessState) {
            showToast(text: state.message, state: ToastStates.SUCCESS);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('الكروت'),
            ),
            body: Column(children: [
              CustomTopTab(name: '${network.name}', id: network.id!),
              const SizedBox(
                height: 20,
              ),
              ConditionalBuilder(
                condition: state is! GetCardNumbersLoadingState,
                builder: (context) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount:
                          CardNumbersCubit.get(context).cardNumbers.length,
                      itemBuilder: (context, index) =>
                          CustomCardNumbersContainer(
                        model: CardNumbersCubit.get(context).cardNumbers[index],
                        onPressed: () {
                          CardNumbersCubit.get(context).deleteCard(
                              category_id: CardNumbersCubit.get(context)
                                  .cardNumbers[index]
                                  .id!,
                              network_id: network.id!);
                        },
                      ),
                    ),
                  );
                },
                fallback: (context) => const Expanded(
                    child: Center(
                        child: CircularProgressIndicator(
                  color: KPrimaryColor2,
                ))),
              ),
            ]),
          );
        },
      ),
    );
  }
}
