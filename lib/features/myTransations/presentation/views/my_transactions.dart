import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wifi_card/constants.dart';
import 'package:wifi_card/features/admin_transaction/presentation/views/widgets/custom_transaction.dart';
import 'package:wifi_card/features/myTransations/presentation/view_models/cubit/my_transaction_cubit.dart';

class MyTransactionsScreen extends StatelessWidget {
  const MyTransactionsScreen({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyTransactionCubit()..getMyTransaction(id),
      child: BlocConsumer<MyTransactionCubit, MyTransactionState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('عملياتى'),
            ),
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
                  condition: state is! GetMyTransactionLoadingState,
                  builder: (context) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: MyTransactionCubit.get(context)
                            .myTransations
                            .length,
                        itemBuilder: (context, index) =>
                            CustomTransactionContainer(
                                transaction: MyTransactionCubit.get(context)
                                    .myTransations[index]),
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
