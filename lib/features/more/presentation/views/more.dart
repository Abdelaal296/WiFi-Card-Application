import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wifi_card/constants.dart';
import 'package:wifi_card/features/layout/presentation/view_models/cubit/home_service_cubit.dart';
import 'package:wifi_card/features/more/presentation/views/widgets/custom_about_user_container.dart';
import 'package:wifi_card/features/more/presentation/views/widgets/view.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeServiceCubit()..getAbouts(),
      child: BlocConsumer<HomeServiceCubit, HomeServiceState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Column(
            children: [
              InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PDFViewerFromAsset(
                                  name: "الشروط",
                                  pdfAssetPath: "assets/ziad.pdf",
                                )));
                  },
                  child: Container(
                    margin: const EdgeInsets.all(16.0),
                    padding: const EdgeInsets.all(8.0),
                    width: double.infinity,
                    height: 80,
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
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: const Center(
                        child: Text(
                      "الشروط",
                      style: TextStyle(
                        fontFamily: Kprimaryfont,
                        fontSize: 25,
                      ),
                    )),
                  )),
              InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PDFViewerFromAsset(
                                  name: "التعليمات",
                                  pdfAssetPath: "assets/ziad.pdf",
                                )));
                  },
                  child: Container(
                    margin: const EdgeInsets.all(16.0),
                    padding: const EdgeInsets.all(8.0),
                    width: double.infinity,
                    height: 80,
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
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: const Center(
                        child: Text(
                      "التعليمات",
                      style: TextStyle(
                        fontFamily: Kprimaryfont,
                        fontSize: 25,
                      ),
                    )),
                  )),
              ConditionalBuilder(
                condition: state is! GetAboutsUserLoadingState,
                builder: (context) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: HomeServiceCubit.get(context).abouts.length,
                      itemBuilder: (context, index) => CustomAboutUserContainer(
                          model: HomeServiceCubit.get(context).abouts[index]),
                    ),
                  );
                },
                fallback: (context) => const Center(
                    child: CircularProgressIndicator(
                  color: KPrimaryColor2,
                )),
              ),
            ],
          );
        },
      ),
    );
  }
}
