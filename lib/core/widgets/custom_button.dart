import 'package:flutter/material.dart';
import 'package:wifi_card/constants.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  CustomButton(
      {super.key,
      this.onTap,
      this.isLoading = false,
      required this.text,
      this.pheight = 50,
      this.color = Colors.black,
      required this.flag});

  final Function()? onTap;
  final bool isLoading;
  final String text;
  double pheight;
  Color color;
  final bool flag;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: pheight,
        decoration: BoxDecoration(
          gradient: flag
              ? LinearGradient(
                  colors: [
                    Color(0xff710019),
                    Color.fromARGB(255, 227, 134, 134)
                  ], // Define your gradient colors here
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.4, 1],
                  // Optional: define stops for the gradient
                )
              : null,
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
            child: isLoading
                ? const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ))
                : Text(
                    text,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: Kprimaryfont,
                      fontSize: 20,
                    ),
                  )),
      ),
    );
  }
}
