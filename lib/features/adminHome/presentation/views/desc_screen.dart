import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wifi_card/constants.dart';
import 'package:wifi_card/core/widgets/custom_flutter_toast.dart';
import 'package:wifi_card/core/widgets/custom_text_field.dart';
import 'package:wifi_card/features/adminHome/data/about.dart';
import 'package:wifi_card/features/adminHome/presentation/view_models/cubit/about_cubit.dart';
import 'package:wifi_card/features/wifiCard/presentation/views/widgets/custom_alert_dialog_button.dart';

class DescripationScreen extends StatelessWidget {
  DescripationScreen({super.key, required this.model});
  final About model;
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  var form_key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AboutCubit>();
    return BlocConsumer<AboutCubit, AboutState>(
      listener: (context, state) {
        if (state is DeleteAboutSuccessState) {
          showToast(text: state.message, state: ToastStates.SUCCESS);
          cubit.getAbouts();
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 30,
            elevation: 0.0,
            backgroundColor: Colors.white,
            actions: [
              user_role == "admin"
                  ? Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              AboutCubit.get(context)
                                  .deleteAbout(id: model.id.toString());
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                              size: 25,
                            )),
                        IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => BlocProvider.value(
                                        value: cubit,
                                        child: Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: BlocConsumer<AboutCubit,
                                                    AboutState>(
                                                listener: (context, state) {
                                              if (state
                                                  is UpdateAboutSuccessState) {
                                                showToast(
                                                    text: state.message,
                                                    state: ToastStates.SUCCESS);
                                                cubit.getAbouts();
                                                Navigator.pop(context);
                                              }
                                            }, builder: (context, state) {
                                              titleController.text =
                                                  model.title!;
                                              descController.text =
                                                  model.desc.toString();

                                              return AlertDialog(
                                                insetPadding:
                                                    const EdgeInsets.all(16.0),
                                                title: Container(
                                                  width: double.infinity,
                                                  child: SingleChildScrollView(
                                                    child: Form(
                                                      key: form_key,
                                                      child: Column(
                                                        children: [
                                                          const Text(
                                                            'تحديث',
                                                            style: TextStyle(
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
                                                            type: TextInputType
                                                                .name,
                                                            hintText:
                                                                'عنوان الفقرة',
                                                            controller:
                                                                titleController,
                                                          ),
                                                          const SizedBox(
                                                            height: 15,
                                                          ),
                                                          CustomTextField(
                                                            type: TextInputType
                                                                .text,
                                                            hintText: 'الوصف',
                                                            controller:
                                                                descController,
                                                            prefix:
                                                                Icons.numbers,
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
                                                                color: Colors
                                                                    .green,
                                                                onPressed: () {
                                                                  if (form_key
                                                                      .currentState!
                                                                      .validate()) {
                                                                    AboutCubit.get(context).updateAbout(
                                                                        model:
                                                                            model,
                                                                        id: model
                                                                            .id
                                                                            .toString(),
                                                                        title: titleController
                                                                            .text,
                                                                        desc: descController
                                                                            .text);
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
                                                                color:
                                                                    Colors.red,
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
                                            })),
                                      ));
                            },
                            icon: Icon(
                              Icons.update,
                              size: 25,
                              color: Colors.blue[600],
                            )),
                      ],
                    )
                  : Container(),
            ],
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        child: Text(
                      '${model.title}',
                      style: const TextStyle(
                          fontFamily: Kprimaryfont,
                          fontSize: 32,
                          color: KPrimaryColor2),
                    )),
                    Text(
                      '${model.desc}',
                      style: const TextStyle(
                          fontSize: 20, fontFamily: Kprimaryfont),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
