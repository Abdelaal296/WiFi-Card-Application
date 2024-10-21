import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wifi_card/constants.dart';
import 'package:wifi_card/features/admin_transaction/presentation/views/widgets/custom_transaction.dart';
import 'package:wifi_card/features/layout/presentation/view_models/cubit/home_service_cubit.dart';

class MyTransactionsHomeScreen extends StatelessWidget {
  const MyTransactionsHomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeServiceCubit()..getMyHomeTransaction(),
      child: BlocConsumer<HomeServiceCubit, HomeServiceState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            body: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "صاحب الشبكه ",
                      style: TextStyle(
                        fontFamily: Kprimaryfont,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.red,
                    ),
                    Text(
                      "قيمه التحويل ",
                      style: TextStyle(fontFamily: Kprimaryfont),
                      maxLines: 1,
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.green,
                    ),
                    Text("صاحب الدكانه ",
                        style: TextStyle(fontFamily: Kprimaryfont),
                        overflow: TextOverflow.ellipsis),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Divider(
                  color: Colors.grey,
                  thickness: 3,
                  indent: 25,
                  endIndent: 25,
                ),
                const SizedBox(
                  height: 20,
                ),
                ConditionalBuilder(
                  condition: state is! GetMyTransactionHomeLoadingState,
                  builder: (context) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount:
                            HomeServiceCubit.get(context).transations.length,
                        itemBuilder: (context, index) =>
                            CustomTransactionContainer(
                                transaction: HomeServiceCubit.get(context)
                                    .transations[index]),
                      ),
                    );
                  },
                  fallback: (context) => const Center(
                      child: CircularProgressIndicator(
                    color: KPrimaryColor2,
                  )),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
