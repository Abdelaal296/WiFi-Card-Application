import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wifi_card/features/Users/data/models/user_model/user_model.dart';
import 'package:wifi_card/features/Users/presentation/view_models/cubit/users_cubit.dart';
import 'package:wifi_card/features/Users/presentation/views/user_profile.dart';
import 'package:wifi_card/features/Users/presentation/views/widgets/user_not_verified_profile.dart';

class CustomUserContainer extends StatelessWidget {
  CustomUserContainer({
    super.key,
    this.onTap,
    required this.flag,
    this.isVerified = true,
    required this.model,
  });

  void Function()? onTap;
  final bool flag;
  bool isVerified;
  final AllUserModel model;
  // final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UsersCubit>();
    return InkWell(
      onTap: () {
        isVerified
            ? Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Directionality(
                        textDirection: TextDirection.rtl,
                        child: BlocProvider.value(
                          value: cubit..displayBan(model),
                          child: UserProfileScreen(
                            model: model,
                            iSNetwork: flag,
                          ),
                        ))))
            : Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Directionality(
                        textDirection: TextDirection.rtl,
                        child: BlocProvider.value(
                          value: cubit..displayBan(model),
                          child: UserNotVerifiedProfileScreen(
                            model: model,
                          ),
                        ))));
      },
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
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
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              "assets/images/test.png",
              width: 50,
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Text(
                model.fullName!,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
