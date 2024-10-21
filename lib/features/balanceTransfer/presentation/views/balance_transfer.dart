import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:wifi_card/constants.dart';
import 'package:wifi_card/core/widgets/custom_flutter_toast.dart';
import 'package:wifi_card/features/balanceTransfer/presentation/view_models/cubit/balance_tranfer_cubit.dart';
import 'package:wifi_card/features/balanceTransfer/presentation/views/widgets/custom_balance_text_form.dart';
import 'package:wifi_card/features/layout/presentation/view_models/cubit/home_service_cubit.dart';

class BalanceTransferScreen extends StatelessWidget {
  BalanceTransferScreen({super.key});
  TextEditingController emailController = TextEditingController();
  TextEditingController networkController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  var form_key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BalanceTranferCubit()
        ..getUsersBalanceTransfer()
        ..getNetworksBalanceTransfer(),
      child: BlocConsumer<BalanceTranferCubit, BalanceTranferState>(
        listener: (context, state) {
          if (state is AddTransactionSuccessState) {
            showToast(text: state.message, state: ToastStates.SUCCESS);
            HomeServiceCubit.get(context).getBalance();
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'تحويل الرصيد',
              ),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Form(
                  key: form_key,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset(
                          'assets/images/transfer.json',
                          height: 250,
                        ),
                        DropdownButtonFormField(
                          items: BalanceTranferCubit.get(context)
                              .users
                              .map((item) {
                            return DropdownMenuItem(
                              value: item.id,
                              child: Text('${item.id}-${item.fullName!}'),
                            );
                          }).toList(),
                          validator: (value) {
                            if (value == null) {
                              return 'يرجى ادخال هذا الحقل';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            emailController.text = value.toString();
                          },
                          decoration: const InputDecoration(
                              errorStyle: TextStyle(
                                  fontFamily: Kprimaryfont,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              label: Text(
                                'صاحب الدكان',
                                style: TextStyle(
                                    color: KPrimaryColor2,
                                    fontFamily: Kprimaryfont),
                              ),
                              prefixIcon: Icon(
                                Icons.person,
                                color: KPrimaryColor2,
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16.0)),
                                  borderSide: BorderSide(
                                    color: KPrimaryColor2,
                                  )),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16.0)),
                                  borderSide: BorderSide(
                                    color: KPrimaryColor2,
                                  )),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16.0)),
                                  borderSide: BorderSide(
                                    color: KPrimaryColor2,
                                  ))),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        DropdownButtonFormField(
                          items: BalanceTranferCubit.get(context)
                              .networks
                              .map((item) {
                            return DropdownMenuItem(
                              value: item.id,
                              child: Text(item.name!),
                            );
                          }).toList(),
                          validator: (value) {
                            if (value == null) {
                              return 'يرجى ادخال هذا الحقل';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            networkController.text = value.toString();
                          },
                          decoration: const InputDecoration(
                              errorStyle: TextStyle(
                                  fontFamily: Kprimaryfont,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              label: Text(
                                'اسم الشبكه',
                                style: TextStyle(
                                    color: KPrimaryColor2,
                                    fontFamily: Kprimaryfont),
                              ),
                              prefixIcon: Icon(
                                Icons.person,
                                color: KPrimaryColor2,
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16.0)),
                                  borderSide: BorderSide(
                                    color: KPrimaryColor2,
                                  )),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16.0)),
                                  borderSide: BorderSide(
                                    color: KPrimaryColor2,
                                  )),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16.0)),
                                  borderSide: BorderSide(
                                    color: KPrimaryColor2,
                                  ))),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomBalanceTextField(
                          type: TextInputType.number,
                          hintText: 'المبلغ المراد تحويله',
                          controller: priceController,
                          prefix: Icons.attach_money_outlined,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(8.0)),
                          child: MaterialButton(
                            onPressed: () {
                              if (form_key.currentState!.validate()) {
                                print(emailController.text);

                                BalanceTranferCubit.get(context).addTransaction(
                                    shop_owner_id: emailController.text,
                                    network_id: networkController.text,
                                    balance: priceController.text);
                              }
                            },
                            child: const Text(
                              'ارسال',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: Kprimaryfont),
                            ),
                          ),
                        )
                      ]),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
