import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wifi_card/constants.dart';

import '../views_model/cardtransaction_cubit.dart';
import 'all_card_transaction.dart';
import 'card_container.dart';

class CardTransaction extends StatelessWidget {
  const CardTransaction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CardtransactionCubit()..getTransaction(),
      child: BlocConsumer<CardtransactionCubit, CardtransactionState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Directionality(
                                textDirection: TextDirection.rtl,
                                child: AllCardTransaction())));
                  },
                  child: Container(
                    margin: EdgeInsets.all(16),
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                      gradient: const LinearGradient(
                        colors: [
                          Colors.white,
                          Color.fromARGB(255, 219, 180, 180)
                        ], // Define your gradient colors here
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        stops: [0.3, 1],
                        // Optional: define stops for the gradient
                      ),
                    ),
                    child: Center(
                      child: Text(
                        " جميع عمليات بيع الكروت",
                        style: TextStyle(
                          fontFamily: Kprimaryfont,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(16),
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                    gradient: const LinearGradient(
                      colors: [
                        Colors.white,
                        Color.fromARGB(255, 219, 180, 180)
                      ], // Define your gradient colors here
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      stops: [0.3, 1],
                      // Optional: define stops for the gradient
                    ),
                  ),
                  child: Center(
                    child: Text(
                      " اجمالي المبيعات خلال 24 ساعه : ${CardtransactionCubit.get(context).last_total_price} ريال ",
                      style: TextStyle(
                        fontFamily: Kprimaryfont,
                      ),
                    ),
                  ),
                ),
                ConditionalBuilder(
                  condition: state is! GetCardTransactionLoadingState,
                  builder: (context) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: CardtransactionCubit.get(context)
                            .transations
                            .length,
                        itemBuilder: (context, index) => build_card_container(
                          serial: CardtransactionCubit.get(context)
                              .transations[index]
                              .cardNumber!,
                          price: CardtransactionCubit.get(context)
                              .transations[index]
                              .cardCategory!
                              .price!,
                          time: DateTime.parse(CardtransactionCubit.get(context)
                              .transations[index]
                              .updatedAt!
                              .substring(0, 19)),
                        ),
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
