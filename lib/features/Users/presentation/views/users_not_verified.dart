import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wifi_card/constants.dart';
import 'package:wifi_card/features/Users/presentation/view_models/cubit/users_cubit.dart';
import 'package:wifi_card/features/Users/presentation/views/custom_user_container.dart';

class UsersNotVerifiedScreen extends StatelessWidget {
  const UsersNotVerifiedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UsersCubit>();
    return BlocConsumer<UsersCubit, UsersStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return RefreshIndicator(
          backgroundColor: KPrimaryColor2,
          color: KPrimaryColor1,
          onRefresh: () async {
            cubit.getUsersNotVerified();
          },
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: const Text('الاعضاء غير المصرح ليهم'),
            ),
            body: ConditionalBuilder(
              condition: state is! GetUsersNotVerifiedLoadingState,
              builder: (context) => ListView.builder(
                itemCount: UsersCubit.get(context).usersNotVerified.length,
                itemBuilder: (context, index) => BlocProvider.value(
                  value: cubit,
                  child: CustomUserContainer(
                      isVerified: false,
                      flag: UsersCubit.get(context).isSelected,
                      model: UsersCubit.get(context).usersNotVerified[index]),
                ),
              ),
              fallback: (context) => const Center(
                  child: CircularProgressIndicator(
                color: KPrimaryColor2,
              )),
            ),
          ),
        );
      },
    );
  }
}
