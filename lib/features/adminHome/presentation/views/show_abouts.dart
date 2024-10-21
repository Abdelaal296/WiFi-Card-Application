import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wifi_card/constants.dart';
import 'package:wifi_card/features/adminHome/presentation/view_models/cubit/about_cubit.dart';
import 'package:wifi_card/features/adminHome/presentation/views/widgets/custom_about_container.dart';

class ShowAboutsScreen extends StatelessWidget {
  const ShowAboutsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AboutCubit>();
    return BlocConsumer<AboutCubit, AboutState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('المعلومات'),
          ),
          body: ConditionalBuilder(
            condition: state is! GetAboutsLoadingState,
            builder: (context) {
              return ListView.builder(
                itemCount: cubit.abouts.length,
                itemBuilder: (context, index) => BlocProvider.value(
                  value: cubit,
                  child: CustomAboutContainer(model: cubit.abouts[index]),
                ),
              );
            },
            fallback: (context) => const Center(
                child: CircularProgressIndicator(
              color: KPrimaryColor2,
            )),
          ),
        );
      },
    );
  }
}
