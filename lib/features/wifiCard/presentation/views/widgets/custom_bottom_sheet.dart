import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wifi_card/constants.dart';
import 'package:wifi_card/features/wifiCard/data/card_model/card_model.dart';
import 'package:wifi_card/features/wifiCard/presentation/view_models/cubit/wifi_cabin_cubit.dart';
import 'package:wifi_card/features/wifiCard/presentation/views/widgets/custom_card.dart';

class CustomBottomSheet extends StatefulWidget {
  CustomBottomSheet({
    super.key,
    required this.cardModel,
  });
  final CardModel cardModel;

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  late TextEditingController phonecontroller;
  @override
  void initState() {
    super.initState();
    phonecontroller = TextEditingController();
  }

  @override
  void dispose() {
    phonecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<WifiCabinCubit>();
    return BlocBuilder<WifiCabinCubit, WifiCabinState>(
      builder: (context, state) {
        return Container(
          height: 400,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                children: [
                  Text(
                    'شبكة ${widget.cardModel.name}',
                    style:
                        const TextStyle(fontSize: 24, fontFamily: Kprimaryfont),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.phone_android,
                        color: KPrimaryColor2,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 40,
                          child: TextFormField(
                            controller: phonecontroller,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                                label: Text(
                                  'رقم الهاتف',
                                  style: TextStyle(
                                      color: KPrimaryColor2,
                                      fontFamily: Kprimaryfont),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.0)),
                                    borderSide: BorderSide(
                                      color: KPrimaryColor2,
                                    )),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.0)),
                                    borderSide: BorderSide(
                                      color: KPrimaryColor2,
                                    )),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.0)),
                                    borderSide: BorderSide(
                                      color: KPrimaryColor2,
                                    ))),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'الكمية',
                    style: TextStyle(fontSize: 20, fontFamily: Kprimaryfont),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                          backgroundColor: KPrimaryColor2,
                          radius: 18,
                          child: IconButton(
                            icon: const Icon(
                              Icons.remove,
                              size: 20,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              WifiCabinCubit.get(context).subtractOne();
                            },
                          )),
                      const SizedBox(
                        width: 5,
                      ),
                      Container(
                        height: 40,
                        width: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            color: Colors.white,
                            border: Border.all()),
                        child: Center(
                            child: Text(WifiCabinCubit.get(context)
                                .counter
                                .toString())),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      CircleAvatar(
                          backgroundColor: KPrimaryColor2,
                          radius: 18,
                          child: IconButton(
                            icon: const Icon(
                              Icons.add,
                              size: 20,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              WifiCabinCubit.get(context).addOne();
                            },
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 150,
                    child: ConditionalBuilder(
                      condition: state is! GetCategoriesNetworkLoadingState,
                      builder: (context) {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              WifiCabinCubit.get(context).categories.length,
                          itemBuilder: (context, index) => BlocProvider.value(
                              value: cubit,
                              child: CustomCard(
                                phone: phonecontroller.text,
                                cardModel: widget.cardModel,
                                categoryModel: WifiCabinCubit.get(context)
                                    .categories[index],
                              )),
                        );
                      },
                      fallback: (context) => const Center(
                          child: CircularProgressIndicator(
                        color: KPrimaryColor2,
                      )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
