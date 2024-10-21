import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:wifi_card/constants.dart';

import '../views_model/cardtransaction_cubit.dart';

class AllCardTransaction extends StatelessWidget {
  const AllCardTransaction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CardtransactionCubit()..getAllTransaction(),
      child: BlocConsumer<CardtransactionCubit, CardtransactionState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text("جميع عمليات بيع الكروت"),
            ),
            body: Column(
              children: [
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
                      " اجمالي المبيعات : ${CardtransactionCubit.get(context).total_price} ريال ",
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
                            .alltransations
                            .length,
                        itemBuilder: (context, index) => build_card_container(
                          serial: CardtransactionCubit.get(context)
                              .alltransations[index]
                              .cardNumber!,
                          price: CardtransactionCubit.get(context)
                              .alltransations[index]
                              .cardCategory!
                              .price!,
                          time: DateTime.parse(CardtransactionCubit.get(context)
                              .alltransations[index]
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

  Container build_card_container(
      {required String serial, required int price, required DateTime time}) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      width: double.infinity,
      height: 120,
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
      child: Column(
        children: [
          Expanded(
            child: Text(
              "رقم الكارت:${serial} ",
              style: TextStyle(fontFamily: Kprimaryfont, fontSize: 18),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: Text("السعر : ${price} ريال ",
                style: TextStyle(fontFamily: Kprimaryfont, fontSize: 18)),
          ),
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: Text(
                "الوقت:  ${DateFormat('yyyy-MM-dd | HH:mm').format(time)}",
                style: TextStyle(fontFamily: Kprimaryfont, fontSize: 18)),
          )
        ],
      ),
    );
  }
}
