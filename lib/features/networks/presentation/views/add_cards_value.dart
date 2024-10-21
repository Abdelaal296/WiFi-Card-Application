import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wifi_card/constants.dart';
import 'package:wifi_card/core/widgets/custom_flutter_toast.dart';
import 'package:wifi_card/features/adminAddNetwork/data/network/network.dart';
import 'package:wifi_card/features/networks/data/category_model.dart';
import 'package:wifi_card/features/networks/presentation/view_models/CardNumbersCubit/card_numbers_cubit.dart';
import 'package:wifi_card/features/networks/presentation/views/add_card.dart';
import 'package:wifi_card/features/networks/presentation/views/widgets/custom_top_tab.dart';

class AddCardsValue extends StatelessWidget {
  AddCardsValue({super.key, required this.model, required this.network});
  var form_key = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();

  final CategoryModel model;
  final Network network;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CardNumbersCubit(),
      child: BlocConsumer<CardNumbersCubit, CardNumbersState>(
        listener: (context, state) {
          if (state is AddCardNumbersSuccessState) {
            showToast(text: state.message, state: ToastStates.SUCCESS);
            controller.clear();
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => Directionality(
                        textDirection: TextDirection.rtl,
                        child: AddCardAndReport(
                          network: network,
                        ))));
          } else if (state is AddCardNumbersErrorState) {
            showToast(text: state.error, state: ToastStates.ERROR);
          }
        },
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Directionality(
                              textDirection: TextDirection.rtl,
                              child: AddCardAndReport(
                                network: network,
                              ))));
                },
                icon: const Icon(Icons.arrow_back),
              ),
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
                  value: int.parse(model.category!),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Form(
                      key: form_key,
                      child: Column(
                        children: [
                          TextFormField(
                            textDirection: TextDirection.ltr,
                            keyboardType: TextInputType.number,
                            controller: controller,
                            maxLines: 15,
                            decoration: const InputDecoration(
                                hintText: 'اكتب او الصق ارقام الكروت هنا.....',
                                hintStyle: TextStyle(
                                    fontFamily: Kprimaryfont,
                                    color: KPrimaryColor2),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16.0)),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    )),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16.0)),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    )),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16.0)),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ))),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(8.0)),
                                child: MaterialButton(
                                  onPressed: () {
                                    List<String> cards = controller.text
                                        .split(RegExp(r'\s+'))
                                        .toList();
                                    String jsonData = jsonEncode(cards);
                                    // print("hellllllllllllllllllllllll-----");
                                    // print(jsonData.toString());
                                    print(cards);
                                    if (form_key.currentState!.validate()) {
                                      CardNumbersCubit.get(context).addCard(
                                          category_id: model.id.toString(),
                                          network_id:
                                              model.networkId.toString(),
                                          cards: jsonData);
                                    }
                                  },
                                  child: const Text(
                                    'اضافة',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: Kprimaryfont),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(8.0)),
                                child: MaterialButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'اغلاق',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: Kprimaryfont),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
