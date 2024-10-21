import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:wifi_card/constants.dart';
import 'package:wifi_card/core/widgets/custom_flutter_toast.dart';
import 'package:wifi_card/features/adminAddNetwork/presentation/view_models/cubit/add_network_cubit.dart';
import 'package:wifi_card/features/balanceTransfer/presentation/views/widgets/custom_balance_text_form.dart';

class AdminAddNetworkScreen extends StatelessWidget {
  AdminAddNetworkScreen({super.key});
  TextEditingController nameController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController feesRateController = TextEditingController();
  var form_key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddNetworkCubit>();
    return BlocConsumer<AddNetworkCubit, AddNetworkState>(
      listener: (context, state) {
        if (state is AddNetworkSuccessState) {
          showToast(text: state.message, state: ToastStates.SUCCESS);
          nameController.clear();
          idController.clear();
          feesRateController.clear();
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
            ),
            title: const Text(
              'إِضافة شبكة',
              style: TextStyle(fontFamily: Kprimaryfont),
            ),
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
                        height: 200,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      CustomBalanceTextField(
                        type: TextInputType.text,
                        hintText: 'اسم الشبكة',
                        controller: nameController,
                        prefix: Icons.wifi,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      DropdownButtonFormField(
                        items: AddNetworkCubit.get(context).users.map((item) {
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
                          idController.text = value.toString();
                        },
                        decoration: const InputDecoration(
                            errorStyle: TextStyle(
                                fontFamily: Kprimaryfont,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            label: Text(
                              'اسم صاحب الشبكه',
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
                        hintText: 'النسبة',
                        controller: feesRateController,
                        prefix: Icons.percent,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ConditionalBuilder(
                          fallback: (context) =>
                              const CircularProgressIndicator(
                                color: KPrimaryColor2,
                              ),
                          condition: state is! AddNetworkLoadingState,
                          builder: (context) {
                            return MaterialButton(
                              onPressed: () {
                                if (form_key.currentState!.validate()) {
                                  AddNetworkCubit.get(context).addNetwork(
                                      id: idController.text,
                                      name: nameController.text,
                                      fee_rate: feesRateController.text);
                                }
                              },
                              child: const Text(
                                'اضافة',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: Kprimaryfont),
                              ),
                              color: Colors.green,
                            );
                          }),
                    ]),
              ),
            ),
          ),
        );
      },
    );
  }
}
