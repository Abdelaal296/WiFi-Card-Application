import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wifi_card/core/widgets/custom_flutter_toast.dart';
import 'package:wifi_card/features/adminAddNetwork/data/network/network.dart';
import 'package:wifi_card/features/adminAddNetwork/presentation/view_models/cubit/add_network_cubit.dart';
import 'package:wifi_card/features/profile/presentation/views/profile.dart';

import '../../../../constants.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../wifiCard/presentation/views/widgets/custom_alert_dialog_button.dart';

class NetworkDetailsScreen extends StatelessWidget {
  NetworkDetailsScreen({Key? key, required this.model}) : super(key: key);
  TextEditingController _controller = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController feesRatecontroller = TextEditingController();
  var form_key = GlobalKey<FormState>();
  var form_key2 = GlobalKey<FormState>();
  final Network model;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddNetworkCubit>();
    return BlocConsumer<AddNetworkCubit, AddNetworkState>(
      listener: (context, state) {
        if (state is DeleteNetworkSuccessState) {
          showToast(text: state.message, state: ToastStates.SUCCESS);
          cubit.getNetworks();
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  AddNetworkCubit.get(context)
                      .deleteNetwork(network_id: model.id.toString());
                },
                icon: const Icon(
                  Icons.delete,
                  color: KPrimaryColor2,
                  size: 30,
                ),
              ),
              elevation: 0.0,
              backgroundColor: Colors.white,
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => BlocProvider.value(
                                  value: cubit,
                                  child: Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: BlocConsumer<AddNetworkCubit,
                                          AddNetworkState>(
                                        listener: (context, state) {
                                          if (state
                                              is UpdateNetworkSuccessState) {
                                            showToast(
                                                text: state.message,
                                                state: ToastStates.SUCCESS);
                                            Navigator.pop(context);
                                          }
                                        },
                                        builder: (context, state) {
                                          nameController.text = model.name!;
                                          idController.text = model
                                              .networkOwner!.id!
                                              .toString();
                                          feesRatecontroller.text =
                                              model.feeRate.toString();
                                          return AlertDialog(
                                            insetPadding:
                                                const EdgeInsets.all(16.0),
                                            title: Container(
                                              width: double.infinity,
                                              child: SingleChildScrollView(
                                                child: Form(
                                                  key: form_key2,
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        'تحديث شبكة ${model.name}',
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                Kprimaryfont,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      CustomTextField(
                                                        type:
                                                            TextInputType.name,
                                                        hintText: 'اسم الشبكه',
                                                        controller:
                                                            nameController,
                                                        prefix: Icons.wifi,
                                                      ),
                                                      const SizedBox(
                                                        height: 15,
                                                      ),
                                                      CustomTextField(
                                                        type: TextInputType
                                                            .number,
                                                        hintText:
                                                            'رقم حساب صاحب الشبكة',
                                                        controller:
                                                            idController,
                                                        prefix: Icons.numbers,
                                                      ),
                                                      const SizedBox(
                                                        height: 15,
                                                      ),
                                                      CustomTextField(
                                                        type: TextInputType
                                                            .number,
                                                        hintText: 'النسبة',
                                                        controller:
                                                            feesRatecontroller,
                                                        prefix: Icons.percent,
                                                      ),
                                                      const SizedBox(
                                                        height: 30,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                              child:
                                                                  CustomAlertDialogButton(
                                                            text: 'تحديث',
                                                            color: Colors.green,
                                                            onPressed: () {
                                                              if (form_key2
                                                                  .currentState!
                                                                  .validate()) {
                                                                AddNetworkCubit.get(context).updateNetwork(
                                                                    networkModel:
                                                                        model,
                                                                    network_id:
                                                                        model.id
                                                                            .toString(),
                                                                    user_id:
                                                                        idController
                                                                            .text,
                                                                    name: nameController
                                                                        .text,
                                                                    fee_rate:
                                                                        feesRatecontroller
                                                                            .text,
                                                                    fees: model
                                                                        .fees
                                                                        .toString());
                                                              }
                                                            },
                                                          )),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          Expanded(
                                                              child:
                                                                  CustomAlertDialogButton(
                                                            text: 'الغاء',
                                                            color: Colors.red,
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                          )),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      )),
                                ));
                      },
                      icon: const Icon(
                        Icons.edit_rounded,
                        color: Colors.green,
                        size: 30,
                      )),
                )
              ]),
          body: Column(
            children: [
              Container(
                width: double.infinity,
                height: 250,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.wifi,
                      size: 150,
                    ),
                    Text(
                      'شبكه ${model.name}',
                      style: const TextStyle(
                        color: KPrimaryColor2,
                        fontSize: 24,
                        fontFamily: Kprimaryfont,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${model.id}',
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xff710019),
                          Color.fromARGB(255, 227, 134, 134)
                        ], // Define your gradient colors here
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [0.3, 1],
                        // Optional: define stops for the gradient
                      ),
                      color: KPrimaryColor2,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.0),
                          topRight: Radius.circular(16.0))),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        CustomProfileExpandedContainer(
                          icon: Icons.person,
                          text: 'صاحب الشبكه',
                          content: '${model.networkOwner!.fullName}',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomProfileItem(
                          subtitle: '',
                          icon: Icons.phone,
                          name: 'رقم الهاتف',
                          content: '${model.networkOwner!.phoneNumber}',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomProfileItem(
                          subtitle: '',
                          icon: Icons.percent,
                          name: 'نسبة الاقتطاع',
                          content: '${model.feeRate}%',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomProfileExpandedContainer(
                          icon: Icons.money,
                          text: 'المبلغ المطلوب',
                          content: '${model.fees}',
                          onTap: () {
                            cubit.rem = 0;

                            showDialog(
                                context: context,
                                builder: (context) => BlocProvider.value(
                                      value: cubit,
                                      child: BlocConsumer<AddNetworkCubit,
                                          AddNetworkState>(
                                        listener: (context, state) {
                                          if (state
                                              is UpdateNetworkSuccessState) {
                                            showToast(
                                                text: state.message,
                                                state: ToastStates.SUCCESS);
                                            Navigator.pop(context);
                                          }
                                        },
                                        builder: (context, state) {
                                          return Directionality(
                                              textDirection: TextDirection.rtl,
                                              child: AlertDialog(
                                                  title: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Text(
                                                        'المبلغ المطلوب  : ',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                Kprimaryfont,
                                                            color:
                                                                KPrimaryColor2,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                            '${model.fees}'),
                                                      ),
                                                    ],
                                                  ),
                                                  content: Form(
                                                    key: form_key,
                                                    child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          CustomTextField(
                                                            onChanged: (value) {
                                                              _controller.text =
                                                                  value;
                                                              cubit.fess(
                                                                  double.parse(
                                                                      value),
                                                                  model.fees!
                                                                      .toDouble()!);
                                                            },
                                                            hintText:
                                                                'المبلغ المدفوع',
                                                            controller:
                                                                _controller,
                                                            prefix: Icons
                                                                .attach_money,
                                                            type: TextInputType
                                                                .number,
                                                          ),
                                                          const SizedBox(
                                                            height: 15,
                                                          ),
                                                          const Divider(
                                                            color: Colors.black,
                                                            thickness: 2,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              const Text(
                                                                'الباقى : ',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        Kprimaryfont,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color:
                                                                        KPrimaryColor2,
                                                                    fontSize:
                                                                        22),
                                                              ),
                                                              Expanded(
                                                                child: Text(
                                                                  '${cubit.rem}',
                                                                  style: const TextStyle(
                                                                      fontFamily:
                                                                          Kprimaryfont,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          20),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                            height: 20,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                  child:
                                                                      CustomAlertDialogButton(
                                                                text: 'تاكيد',
                                                                color: Colors
                                                                    .green,
                                                                onPressed: () {
                                                                  if (form_key
                                                                      .currentState!
                                                                      .validate()) {
                                                                    AddNetworkCubit.get(context).updateNetwork(
                                                                        networkModel:
                                                                            model,
                                                                        network_id: model
                                                                            .id
                                                                            .toString(),
                                                                        user_id: model
                                                                            .userId
                                                                            .toString(),
                                                                        name: model
                                                                            .name
                                                                            .toString(),
                                                                        fee_rate: model
                                                                            .feeRate
                                                                            .toString(),
                                                                        fees: cubit
                                                                            .rem
                                                                            .toString());
                                                                  }
                                                                },
                                                              )),
                                                              const SizedBox(
                                                                width: 5,
                                                              ),
                                                              Expanded(
                                                                child:
                                                                    CustomAlertDialogButton(
                                                                  text: 'الغاء',
                                                                  color: Colors
                                                                      .red,
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ]),
                                                  )));
                                        },
                                      ),
                                    ));
                          },
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
    );
  }
}

class CustomProfileExpandedContainer extends StatelessWidget {
  CustomProfileExpandedContainer({
    super.key,
    required this.content,
    this.onTap,
    required this.text,
    required this.icon,
  });

  final String content;
  final IconData icon;
  final String text;
  Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: const BoxDecoration(
          color: KPrimaryColor1,
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 15,
            ),
            Icon(
              icon,
              color: KPrimaryColor2,
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              text,
              style: const TextStyle(
                  fontFamily: Kprimaryfont,
                  fontSize: 20,
                  color: KPrimaryColor2),
            ),
            const Spacer(),
            Expanded(
                flex: 2,
                child: Text(
                  content,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontFamily: Kprimaryfont,
                      fontSize: 20,
                      color: KPrimaryColor2),
                )),
          ],
        ),
      ),
    );
  }
}
