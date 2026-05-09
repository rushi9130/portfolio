import 'dart:math';

import 'package:flutter/material.dart';

class ParticleBackground extends StatefulWidget {
  const ParticleBackground({super.key, this.particleColor});
  final Color? particleColor;

  @override
  State<ParticleBackground> createState() => _ParticleBackgroundState();
}

class _ParticleBackgroundState extends State<ParticleBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Random random = Random();
  static const int _baseParticleCount = 260;
  late List<Particle> particles;
  Size _lastSize = Size.zero;

  @override
  void initState() {
    super.initState();
    particles = <Particle>[];

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(_updateParticles);

    _controller.repeat();
  }

  void _updateParticles() {
    if (_lastSize == Size.zero) {
      return;
    }
    for (final p in particles) {
      p.position = Offset(p.position.dx, p.position.dy - p.speed);

      // reset when dot goes up
      if (p.position.dy < 0) {
        p.position = Offset(random.nextDouble() * _lastSize.width, _lastSize.height);
      }
    }
  }

  void _initializeParticles(Size size) {
    final densityFactor = (size.width / 1440).clamp(0.65, 1.25);
    final count = (_baseParticleCount * densityFactor).toInt();
    particles = List.generate(count, (_) {
      return Particle(
        position: Offset(random.nextDouble() * size.width, random.nextDouble() * size.height),
        speed: 0.01 + random.nextDouble(),
        radius: 0.1 + random.nextDouble() * 2,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final pageSize = Size(constraints.maxWidth, constraints.maxHeight);
        final deltaWidth = (_lastSize.width - pageSize.width).abs();
        final deltaHeight = (_lastSize.height - pageSize.height).abs();
        if (deltaWidth > 40 || deltaHeight > 40 || particles.isEmpty) {
          _lastSize = pageSize;
          _initializeParticles(pageSize);
        }

        return RepaintBoundary(
          child: ClipRect(
            child: CustomPaint(
              size: pageSize,
              painter: ParticlePainter(
                particles,
                color: widget.particleColor ?? Colors.orange,
                repaint: _controller,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class Particle {
  Offset position;
  double speed;
  double radius;

  Particle({required this.position, required this.speed, required this.radius});
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;
  final Color color;

  ParticlePainter(this.particles, {required this.color, Listenable? repaint}) : super(repaint: repaint);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withValues(alpha: 0.45)
      ..style = PaintingStyle.fill;

    for (final p in particles) {
      canvas.drawCircle(p.position, p.radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant ParticlePainter oldDelegate) =>
      oldDelegate.particles != particles || oldDelegate.color != color;
}
