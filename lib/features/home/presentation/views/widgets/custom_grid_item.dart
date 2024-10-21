import 'package:flutter/material.dart';
import 'package:wifi_card/constants.dart';

class CustomGridItem extends StatefulWidget {
  const CustomGridItem({
    super.key,
    required this.label,
    required this.icon,
    required this.color,
    this.onTap,
  });
  final String label;
  final IconData icon;
  final Color color;
  final Function()? onTap;

  @override
  State<CustomGridItem> createState() => _CustomGridItemState();
}

class _CustomGridItemState extends State<CustomGridItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<Color?> _colorAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _colorAnimation =
        ColorTween(begin: Colors.white, end: widget.color).animate(_controller);
    _rotationAnimation =
        Tween<double>(begin: 0, end: 2 * 3.14).animate(_controller);
    // Start the animation
    _controller.forward(); // You can customize the animation here
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32.0),
          color: Colors.white,
          gradient: LinearGradient(
            colors: [
              Colors.white,
              const Color.fromARGB(255, 219, 180, 180)
            ], // Define your gradient colors here
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.4, 1],
            // Optional: define stops for the gradient
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              offset: Offset(3, 3),
            ),
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              offset: Offset(-2, -2),
            ),
          ],
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Transform.rotate(
                angle: _rotationAnimation.value,
                child: Icon(
                  widget.icon,
                  size: 50 * _animation.value,
                  color: _colorAnimation.value,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              FadeTransition(
                opacity: _controller,
                child: Text(
                  widget.label,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: Kprimaryfont,
                  ),
                ),
              )
            ]),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose of the animation controller
    super.dispose();
  }
}
