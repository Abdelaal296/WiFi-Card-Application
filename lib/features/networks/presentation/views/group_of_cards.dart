import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wifi_card/constants.dart';
import 'package:wifi_card/core/widgets/custom_flutter_toast.dart';
import 'package:wifi_card/core/widgets/custom_text_field.dart';
import 'package:wifi_card/features/adminAddNetwork/data/network/network.dart';
import 'package:wifi_card/features/networks/data/category_model.dart';
import 'package:wifi_card/features/networks/presentation/view_models/CategoriesCubit/categories_cubit.dart';
import 'package:wifi_card/features/networks/presentation/views/widgets/custom_networks_text_field.dart';
import 'package:wifi_card/features/networks/presentation/views/widgets/custom_top_tab.dart';

import '../../../wifiCard/presentation/views/widgets/custom_alert_dialog_button.dart';

class GruopOfCardsScreen extends StatelessWidget {
  GruopOfCardsScreen({super.key, required this.network});
  var form_key = GlobalKey<FormState>();

  TextEditingController categoryController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController hoursController = TextEditingController();
  TextEditingController validController = TextEditingController();
  TextEditingController linkController = TextEditingController();

  TextEditingController alertCategoryController = TextEditingController();
  TextEditingController alertPriceController = TextEditingController();
  TextEditingController alertPercentController = TextEditingController();

  var form_key2 = GlobalKey<FormState>();

  final Network network;

  CategoriesCubit categoriesCubit = CategoriesCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => categoriesCubit..getCategories(network.id!),
      child: BlocConsumer<CategoriesCubit, CategoriesState>(
        listener: (context, state) {
          if (state is AddCategorySuccessState) {
            showToast(text: state.message, state: ToastStates.SUCCESS);
            categoryController.clear();
            priceController.clear();
            hoursController.clear();
            validController.clear();
            linkController.clear();
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'معرض شبكاتى',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),
            body: Form(
              key: form_key,
              child: SingleChildScrollView(
                child: Column(children: [
                  CustomTopTab(
                    name: '${network.name}',
                    id: network.id!,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            CustomNetworksTextField(
                              controller: categoryController,
                              text: 'الفئة',
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            CustomNetworksTextField(
                              controller: priceController,
                              text: 'السعر',
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            CustomNetworksTextField(
                              controller: validController,
                              text: 'الصلاحيه - ايام',
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            CustomNetworksTextField(
                              controller: hoursController,
                              text: 'الساعات',
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            CustomNetworksTextField(
                              type: TextInputType.text,
                              controller: linkController,
                              text: 'الرابط',
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.black,
                          ),
                          child: MaterialButton(
                            onPressed: () {
                              if (form_key.currentState!.validate()) {
                                CategoriesCubit.get(context).addCategory(
                                    category: categoryController.text,
                                    price: priceController.text,
                                    hours: hoursController.text,
                                    validity: validController.text,
                                    network_id: network.id.toString(),
                                    link: linkController.text);
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
                      ],
                    ),
                  ),
                  ConditionalBuilder(
                    condition: state is! GetCategoriesLoadingState,
                    builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: DataTable(
                          columnSpacing: 45,
                          border: TableBorder.all(),
                          columns: [
                            const DataColumn(label: Text('الفئه')),
                            const DataColumn(label: Text('السعر')),
                            const DataColumn(label: Text('الصلاحيه')),
                            const DataColumn(label: Text('تعديل')),
                            const DataColumn(label: Text('حذف')),
                          ],
                          rows: _buildRows(context),
                        ),
                      );
                    },
                    fallback: (context) => const Center(
                        child: CircularProgressIndicator(
                      color: KPrimaryColor2,
                    )),
                  ),
                ]),
              ),
            ),
          );
        },
      ),
    );
  }

  List<DataRow> _buildRows(BuildContext context) {
    List<DataRow> rows = [];
    for (var i = 0; i < CategoriesCubit.get(context).categories.length; i++) {
      rows.add(
        DataRow(
          cells: <DataCell>[
            DataCell(
                Text('${CategoriesCubit.get(context).categories[i].category}')),
            DataCell(
                Text('${CategoriesCubit.get(context).categories[i].price}')),
            DataCell(
                Text('${CategoriesCubit.get(context).categories[i].validity}')),
            _buildDataCell(
                context, 'تعديل', CategoriesCubit.get(context).categories[i]),
            _buildDataCell(
                context, 'حذف', CategoriesCubit.get(context).categories[i]),
          ],
        ),
      );
    }
    return rows;
  }

  DataCell _buildDataCell(
      BuildContext context, String text, CategoryModel model) {
    return DataCell(
      InkWell(
        onTap: () {
          text == 'تعديل' ? onUpdate(context, model) : onDelete(context, model);
        },
        child: Text(
          text,
          style: const TextStyle(
              decoration: TextDecoration.underline, color: Colors.blue),
        ),
      ),
    );
  }

  void onUpdate(BuildContext context, CategoryModel model) {
    showDialog(
        context: context,
        builder: (context) => BlocProvider.value(
              value: categoriesCubit,
              child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: BlocConsumer<CategoriesCubit, CategoriesState>(
                    listener: (context, state) {
                      if (state is UpdateCategorySuccessState) {
                        showToast(
                            text: state.message, state: ToastStates.SUCCESS);
                        Navigator.pop(context);
                      }
                    },
                    builder: (context, state) {
                      alertCategoryController.text = model.category.toString();
                      alertPriceController.text = model.price.toString();
                      alertPercentController.text =
                          model.shopPriceRate.toString();

                      return AlertDialog(
                        insetPadding: const EdgeInsets.all(16.0),
                        title: Container(
                          width: double.infinity,
                          child: SingleChildScrollView(
                            child: Form(
                              key: form_key2,
                              child: Column(
                                children: [
                                  Text(
                                    'تحديث فئة ${model.category}',
                                    style: const TextStyle(
                                        fontFamily: Kprimaryfont,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  CustomTextField(
                                    type: TextInputType.name,
                                    hintText: 'الفئة',
                                    controller: alertCategoryController,
                                    prefix: Icons.wifi,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  CustomTextField(
                                    type: TextInputType.number,
                                    hintText: 'السعر',
                                    controller: alertPriceController,
                                    prefix: Icons.numbers,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  CustomTextField(
                                    type: TextInputType.number,
                                    hintText: 'النسبة',
                                    controller: alertPercentController,
                                    prefix: Icons.percent,
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: CustomAlertDialogButton(
                                        text: 'تحديث',
                                        color: Colors.green,
                                        onPressed: () {
                                          if (form_key2.currentState!
                                              .validate()) {
                                            CategoriesCubit.get(
                                                    context)
                                                .updateCategory(
                                                    cate_id: model.id!,
                                                    category:
                                                        alertCategoryController
                                                            .text,
                                                    price: alertPriceController
                                                        .text,
                                                    percent:
                                                        alertPercentController
                                                            .text,
                                                    network_id: network.id!);
                                          }
                                        },
                                      )),
                                      const SizedBox(
                                        width: 5,
                                      ),
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
                  )),
            ));
  }

  void onDelete(BuildContext context, CategoryModel model) {
    CategoriesCubit.get(context)
        .deleteCategory(network_id: network.id!, category_id: model.id!);
  }
}
