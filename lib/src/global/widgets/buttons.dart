import 'package:flutter/material.dart';
import 'package:hits_and_blows_game/src/constants/button_styles.dart';

class AnimatedButton extends StatefulWidget {
  const AnimatedButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.style,
  });

  final VoidCallback onPressed;
  final String text;
  final AllowedButtonStyles style;

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
      lowerBound: 0.9,
      upperBound: 1.0,
    )..repeat(reverse: true);

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: ElevatedButton(
        style: widget.style.style,
        onPressed: widget.onPressed,
        child: Text(widget.text, style: TextStyle(fontSize: 40)),
      ),
    );
  }
}
