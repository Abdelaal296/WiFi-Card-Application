import 'package:flutter/material.dart';
import 'package:wifi_card/constants.dart';
import 'package:wifi_card/features/home/presentation/views/widgets/custom_balance_section.dart';
import 'package:wifi_card/features/home/presentation/views/widgets/custom_grid_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.white,
      child: Column(
        children: [
          const CustomBalanceSection(),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xff710019),
                    Color.fromARGB(255, 227, 134, 134)
                  ], // Define your gradient colors here
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.5, 1],
                  // Optional: define stops for the gradient
                ),
                color: KPrimaryColor1,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: CustomGridView(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
