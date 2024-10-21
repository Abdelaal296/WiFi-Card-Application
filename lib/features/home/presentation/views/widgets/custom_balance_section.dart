import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wifi_card/constants.dart';
import 'package:wifi_card/features/layout/presentation/view_models/cubit/home_service_cubit.dart';

class CustomBalanceSection extends StatefulWidget {
  const CustomBalanceSection({
    super.key,
  });

  @override
  State<CustomBalanceSection> createState() => _CustomBalanceSectionState();
}

class _CustomBalanceSectionState extends State<CustomBalanceSection>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slidingAniimation1;
  late Animation<Offset> slidingAniimation2;

  @override
  void initState() {
    super.initState();
    initSlidingAnimation();
  }

  @override
  void dispose() {
    animationController.dispose(); // Dispose of the animation controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeServiceCubit, HomeServiceState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Container(
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/money.png',
                width: 90,
                color: Color.fromARGB(255, 37, 138, 44),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AnimatedBuilder(
                    animation: slidingAniimation1,
                    builder: (context, _) => SlideTransition(
                      position: slidingAniimation1,
                      child: Column(
                        children: [
                          Text(
                            'الرصيد',
                            style: TextStyle(
                                fontSize: 28,
                                color: Colors.black,
                                fontFamily: Kprimaryfont),
                          ),
                          Text(
                            '$balance',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontFamily: Kprimaryfont),
                          ),
                        ],
                      ),
                    ),
                  ),
                  AnimatedBuilder(
                    animation: slidingAniimation2,
                    builder: (context, _) => SlideTransition(
                      position: slidingAniimation2,
                      child: Column(
                        children: [
                          Text(
                            'رسوم التطبيق',
                            style: TextStyle(
                                fontSize: 26,
                                color: Colors.black,
                                fontFamily: Kprimaryfont),
                          ),
                          Text(
                            '$fees',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontFamily: Kprimaryfont),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  void initSlidingAnimation() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));
    slidingAniimation1 =
        Tween<Offset>(begin: const Offset(8, 0), end: Offset.zero)
            .animate(animationController);
    slidingAniimation2 =
        Tween<Offset>(begin: const Offset(-8, 0), end: Offset.zero)
            .animate(animationController);
    animationController.forward();
  }
}
