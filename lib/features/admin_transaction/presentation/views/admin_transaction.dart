import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wifi_card/constants.dart';
import 'package:wifi_card/features/Users/presentation/view_models/cubit/users_cubit.dart';
import 'package:wifi_card/features/admin_transaction/presentation/views/widgets/custom_transaction.dart';

class AdminTransactionScreen extends StatelessWidget {
  const AdminTransactionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UsersCubit>();
    return BlocConsumer<UsersCubit, UsersStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return RefreshIndicator(
          backgroundColor: KPrimaryColor2,
          color: KPrimaryColor1,
          onRefresh: () async {
            cubit.getTransactions();
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Text("العمليات"),
            ),
            body: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
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
                      SizedBox(
                        height: 20,
                      ),
                      Divider(
                        color: Colors.grey,
                        thickness: 3,
                        indent: 25,
                        endIndent: 25,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ConditionalBuilder(
                  condition: state is! GetTransactionsLoadingState,
                  builder: (context) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: UsersCubit.get(context).transactions.length,
                        itemBuilder: (context, index) =>
                            CustomTransactionContainer(
                                transaction: cubit.transactions[index]),
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
          ),
        );
      },
    );
  }
}
