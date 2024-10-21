import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screenshot/screenshot.dart';
import 'package:url_launcher/url_launcher.dart' as lunch;
import 'package:wifi_card/constants.dart';
import 'package:wifi_card/core/widgets/custom_flutter_toast.dart';
import 'package:wifi_card/features/networks/data/category_model.dart';
import 'package:wifi_card/features/wifiCard/data/card_model/card_model.dart';
import 'package:wifi_card/new_printer.dart';

import '../../../../card_transaction/data/card_trans_model.dart';
import '../../../data/print_info.dart';
import '../../view_models/cubit/wifi_cabin_cubit.dart';

class PrintPage extends StatefulWidget {
  PrintPage({
    super.key,
    required this.cardModel,
    required this.categoryModel,
    required this.quantity,
    required this.card_number,
    required this.price,
    required this.phone,
  });

  final CardModel cardModel;
  final String phone;
  final CategoryModel categoryModel;
  final String quantity;
  final List<CardTransactionModel> card_number;
  final String price;

  @override
  State<PrintPage> createState() => _PrintPageState();
}

class _PrintPageState extends State<PrintPage> {
  ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    screenshotController = ScreenshotController();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<WifiCabinCubit>();
    return BlocConsumer<WifiCabinCubit, WifiCabinState>(
      listener: (context, state) {
        if (state is SendCardfavSuccessState) {
          showToast(text: state.message, state: ToastStates.SUCCESS);
        } else if (state is SendCardfavFailureState) {
          showToast(text: state.error, state: ToastStates.ERROR);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('الطباعة'),
          ),
          body: Center(
            child: Column(
              children: [
                Image.asset("assets/images/background.png"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: KPrimaryColor2,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: MaterialButton(
                        onPressed: () async {
                          String card_num = "";
                          for (int i = 0; i < widget.card_number.length; i++) {
                            card_num += widget.card_number[i].cardNumber!;
                            if (i != widget.card_number.length - 1) {
                              card_num += " , ";
                            }
                          }
                          print(card_num);
                          print(device);
                          if (device == null) {
                            showToast(
                                text: "رجاء اختيار طابعه",
                                state: ToastStates.ERROR);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: PrinterPage())));
                          } else {
                            
                          await cubit.startPrint(
                              device,
                              PrintInfo(
                                  widget.cardModel.name!,
                                  card_num,
                                  widget.categoryModel.category!,
                                  widget.categoryModel.price!,
                                  widget.quantity,
                                  (int.parse(widget.quantity) *
                                      widget.categoryModel.price!),widget.categoryModel.link),
                              context);
                          // _printDocument(context, cardModel, categoryModel,
                          //     quantity, card_num, price);
                        }
                        },
                        child: const Text(
                          'طباعة الكارت',
                          style: TextStyle(
                              color: KPrimaryColor1, fontFamily: Kprimaryfont),
                        ),
                      ),
                    ),
                    widget.phone.isNotEmpty
                        ? Container(
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: MaterialButton(
                              onPressed: () {
                                List<String> card_num = [];
                                for (int i = 0;
                                    i < widget.card_number.length;
                                    i++) {
                                  card_num
                                      .add(widget.card_number[i].cardNumber!);
                                }
                                String jsonData = jsonEncode(card_num);
                                //cubit.sendcard(card_id: jsonData, Phone: phone);
                                lunch.launchUrl(Uri.parse(
                                    "sms:${widget.phone}${Platform.isAndroid ? '?' : '&'}body=شكرا لاستخدامك تطبيق واي فاي كارد رقم الكارت ${jsonData}"));
                              },
                              child: const Text(
                                'sms ارسال',
                                style: TextStyle(
                                    color: KPrimaryColor1,
                                    fontFamily: Kprimaryfont),
                              ),
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            width: 110,
                            height: 50,
                            child: Center(
                              child: const Text(
                                'sms ارسال',
                                style: TextStyle(
                                    color: KPrimaryColor1,
                                    fontFamily: Kprimaryfont),
                              ),
                            ),
                          ),
                  ],
                ),
                // Screenshot(
                //   controller: screenshotController,
                //   child: Container(
                //       width: 40,
                //       child: Column(
                //         children: [
                //           Row(
                //             children: const [
                //               Text(
                //                 "محمد",
                //                 style: TextStyle(
                //                     fontSize: 10, fontWeight: FontWeight.bold),
                //               ),
                //             ],
                //             mainAxisAlignment: MainAxisAlignment.center,
                //           ),
                //         ],
                //       )),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}
