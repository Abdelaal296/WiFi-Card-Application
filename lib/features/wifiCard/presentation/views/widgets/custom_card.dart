import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wifi_card/constants.dart';
import 'package:wifi_card/core/widgets/custom_flutter_toast.dart';
import 'package:wifi_card/features/layout/presentation/view_models/cubit/home_service_cubit.dart';
import 'package:wifi_card/features/networks/data/category_model.dart';
import 'package:wifi_card/features/networks/presentation/views/widgets/custom_networks_text_field.dart';
import 'package:wifi_card/features/wifiCard/data/card_model/card_model.dart';
import 'package:wifi_card/features/wifiCard/presentation/view_models/cubit/wifi_cabin_cubit.dart';
import 'package:wifi_card/features/wifiCard/presentation/views/widgets/custom_alert_dialog_button.dart';
import 'package:wifi_card/features/wifiCard/presentation/views/widgets/custom_alert_dialog_item.dart';
import 'package:wifi_card/features/wifiCard/presentation/views/widgets/print.dart';

class CustomCard extends StatelessWidget {
  CustomCard({
    super.key,
    required this.cardModel,
    required this.categoryModel,
    required this.phone,
  });
  TextEditingController controller = TextEditingController();
  TextEditingController priceController = TextEditingController();
  var form_key = GlobalKey<FormState>();
  final String phone;
  final CardModel cardModel;
  final CategoryModel categoryModel;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<WifiCabinCubit>();
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => BlocProvider.value(
            value: cubit,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: SingleChildScrollView(
                child: AlertDialog(
                  insetPadding: const EdgeInsets.all(16.0),
                  title: BlocConsumer<WifiCabinCubit, WifiCabinState>(
                    listener: (context, state) {
                      if (state is PayCardfavSuccessState) {
                        showToast(text: 'sucess', state: ToastStates.SUCCESS);
                        HomeServiceCubit.get(context).getBalance();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BlocProvider.value(
                                      value: cubit,
                                      child: PrintPage(
                                          phone: phone,
                                          cardModel: cardModel,
                                          categoryModel: categoryModel,
                                          quantity: cubit.counter.toString(),
                                          card_number: state.card_number,
                                          price: priceController.text),
                                    )));
                      } else if (state is PayCardfavFailureState) {
                        showToast(text: state.error, state: ToastStates.ERROR);
                      }
                    },
                    builder: (context, state) {
                      return const Column(
                        children: [
                          Icon(
                            Icons.warning_amber,
                            color: Colors.amberAccent,
                            size: 50,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "تاكيد الطلب",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              fontFamily: Kprimaryfont,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  actions: <Widget>[
                    Form(
                      key: form_key,
                      child: Column(
                        children: [
                          const CustomAlertDialogItem(
                            name: 'الخدمة',
                            content: 'كروت شبكات wifi',
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          CustomAlertDialogItem(
                            name: 'الشبكة',
                            content: 'شبكة ${cardModel.name}',
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          CustomAlertDialogItem(
                            name: 'الصنف',
                            content: '${categoryModel.category}',
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          CustomAlertDialogItem(
                            name: 'المبلغ',
                            content: '${categoryModel.price}',
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          CustomAlertDialogItem(
                            name: 'الكمية',
                            content: '${cubit.counter}',
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          CustomAlertDialogItem(
                            name: 'التكلفة',
                            content: '${cubit.counter * categoryModel.price!}',
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                  ),
                                  child: const Text(
                                    'المبلغ المستلم',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: Kprimaryfont),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              CustomNetworksTextField(
                                controller: priceController,
                                text: 'المبلغ',
                                flex: 3,
                                color: Colors.black,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: CustomAlertDialogButton(
                          onPressed: () {
                            if (form_key.currentState!.validate()) {
                              cubit.payCard(
                                  card_id: cardModel.id!,
                                  cate_id: categoryModel.id!,
                                  quantity: cubit.counter);
                            }
                          },
                          text: 'شراء',
                          color: Colors.green,
                        )),
                        Expanded(
                            child: CustomAlertDialogButton(
                          text: 'الغاء',
                          color: Colors.red,
                          onPressed: () {
                            Navigator.pop(context);
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
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10.0),
        height: 145,
        width: 120,
        decoration: BoxDecoration(
          color: KPrimaryColor2,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 2,
              ),
              Container(
                height: 60,
                width: 120,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Colors.white,
                      Color.fromARGB(255, 219, 180, 180)
                    ], // Define your gradient colors here
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                    stops: [0.3, 1],
                    // Optional: define stops for the gradient
                  ),
                  color: KPrimaryColor1,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: [
                    const Text(
                      'كارت',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: Kprimaryfont),
                    ),
                    Text('${categoryModel.category}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            fontFamily: Kprimaryfont)),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                height: 60,
                width: 120,
                decoration: BoxDecoration(
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
                  color: KPrimaryColor1,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: [
                    const Text(
                      'السعر',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: Kprimaryfont),
                    ),
                    Text('${categoryModel.price} ريال ',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            fontFamily: Kprimaryfont)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
