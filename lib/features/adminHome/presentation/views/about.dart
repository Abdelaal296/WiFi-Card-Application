import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wifi_card/constants.dart';
import 'package:wifi_card/core/widgets/custom_flutter_toast.dart';
import 'package:wifi_card/core/widgets/custom_text_field.dart';
import 'package:wifi_card/features/adminHome/presentation/view_models/cubit/about_cubit.dart';
import 'package:wifi_card/features/adminHome/presentation/views/show_abouts.dart';

class AboutScreen extends StatelessWidget {
  AboutScreen({super.key});
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  AboutCubit aboutCubit = AboutCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => aboutCubit,
      child: BlocConsumer<AboutCubit, AboutState>(
        listener: (context, state) {
          if (state is AboutSuccessState) {
            showToast(text: state.message, state: ToastStates.SUCCESS);
            titleController.clear();
            descController.clear();
          }
        },
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: BlocProvider.value(
                                      value: aboutCubit..getAbouts(),
                                      child: const ShowAboutsScreen()))));
                    },
                    icon: const Icon(Icons.menu))
              ],
              title: const Text('معلومات التطبيق'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(children: [
                    CustomTextField(
                        hintText: 'عنوان الفقرة', controller: titleController),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: descController,
                      maxLines: 15,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'يرجي ادخال هذا الحقل';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          errorStyle: TextStyle(
                              fontFamily: Kprimaryfont,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          hintText: 'الوصف........................',
                          hintStyle: TextStyle(
                              fontFamily: Kprimaryfont, color: KPrimaryColor2),
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
                      height: 30,
                    ),
                    ConditionalBuilder(
                      condition: state is! AboutLoadingState,
                      builder: (context) {
                        return Container(
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(8.0)),
                          child: MaterialButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                AboutCubit.get(context).addAbout(
                                    title: titleController.text,
                                    desc: descController.text);
                              }
                            },
                            child: const Text(
                              'اضافة',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: Kprimaryfont),
                            ),
                          ),
                        );
                      },
                      fallback: (context) => const CircularProgressIndicator(
                        color: KPrimaryColor2,
                      ),
                    ),
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
