import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GlowingRing extends StatefulWidget {
  final double size;

  const GlowingRing({super.key, this.size = 160});

  @override
  State<GlowingRing> createState() => _GlowingRingState();
}

class _GlowingRingState extends State<GlowingRing>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Transform.scale(
          scale: 1 + (_controller.value * 0.05),
          child: Container(
            width: widget.size,
            height: widget.size,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.yellow.withOpacity(
                  0.6 + (_controller.value * 0.4),
                ),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.yellow.withOpacity(0.3),
                  blurRadius: 70 + (_controller.value * 20),
                  spreadRadius: 1,
                ),
              ],
            ),
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 160.sp,
                  color: Colors.white,
                  wordSpacing: 1.2,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(text: 'R'),

                  TextSpan(
                    text: 'G',
                    style: TextStyle(color: Colors.yellow),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
