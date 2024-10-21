import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wifi_card/constants.dart';
import 'package:wifi_card/features/Users/presentation/view_models/cubit/users_cubit.dart';
import 'package:wifi_card/features/Users/presentation/views/users_not_verified.dart';

import '../../../../core/widgets/custom_button.dart';
import 'custom_user_container.dart';

class UsersScreen extends StatelessWidget {
  UsersScreen({Key? key}) : super(key: key);
  TextEditingController search = TextEditingController();
  late int length;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UsersCubit>();
    return BlocConsumer<UsersCubit, UsersStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        length = UsersCubit.get(context).usersNotVerified.length;
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 60,
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Directionality(
                                textDirection: TextDirection.rtl,
                                child: BlocProvider.value(
                                    value: cubit,
                                    child: const UsersNotVerifiedScreen()))));
                  },
                  child: Column(
                    children: [
                      const Icon(Icons.notifications),
                      Text(
                        '${length}',
                        style: const TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
              )
            ],
            title: const Text(
              "الاعضاء",
              style: TextStyle(fontFamily: Kprimaryfont),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              Row(
                children: [
                  Expanded(
                      child: CustomButton(
                    onTap: () {
                      UsersCubit.get(context).changeToNewtworkPeople();

                      if (UsersCubit.get(context).isSelected == false)
                        UsersCubit.get(context).changeButtonColor();
                    },
                    text: 'اصحاب الشبكة',
                    color: const Color.fromARGB(255, 58, 12, 9),
                    flag: UsersCubit.get(context).isSelected,
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: CustomButton(
                    onTap: () {
                      UsersCubit.get(context).changeToShopPeople();

                      if (UsersCubit.get(context).isSelected == true)
                        UsersCubit.get(context).changeButtonColor();
                    },
                    text: 'اصحاب الدكانه',
                    color: const Color.fromARGB(255, 58, 12, 9),
                    flag: !UsersCubit.get(context).isSelected,
                  )),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              ConditionalBuilder(
                condition: state is! GetUsersLoadingState,
                builder: (context) => Expanded(
                  child: ListView.builder(
                    itemCount: UsersCubit.get(context).currentPeople.length,
                    itemBuilder: (context, index) => BlocProvider.value(
                      value: cubit,
                      child: CustomUserContainer(
                          flag: UsersCubit.get(context).isSelected,
                          model: UsersCubit.get(context).currentPeople[index]),
                    ),
                  ),
                ),
                fallback: (context) => const Column(
                  children: [
                    SizedBox(
                      height: 250,
                    ),
                    CircularProgressIndicator(
                      color: KPrimaryColor2,
                    ),
                  ],
                ),
              ),
            ]),
          ),
        );
      },
    );
  }
}
