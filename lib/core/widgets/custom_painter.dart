import 'package:flutter/material.dart';
import 'package:wifi_card/constants.dart';

class MyCustomPainter extends CustomPainter {
  final double height;

  MyCustomPainter({required this.height});
  @override
  void paint(Canvas canvas, Size size) {
    double width = size.width;

    var path = Path();
    path.lineTo(0, height - 550);
    path.quadraticBezierTo(width / 2, height - 350, width, height - 650);
    path.lineTo(width, 0);
    path.close();
    Paint paint = Paint()
      ..shader = LinearGradient(
        colors: [
          Color(0xff710019),
          Color.fromARGB(255, 234, 173, 173)
        ], // Define your gradient colors here
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [0.0, 1.0], // Optional: define stops for the gradient
      ).createShader(Rect.fromPoints(Offset(0, 0), Offset(0, height)));
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
