

import 'dart:math';

import 'package:flutter/material.dart';

class CosmicBackground extends StatefulWidget {
  @override
  State<CosmicBackground> createState() => _CosmicBackgroundState();
}

class _CosmicBackgroundState extends State<CosmicBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Star> _stars = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 30),
    )..repeat();

    // Initialize stars with neon colors
    for (int i = 0; i < 200; i++) {
      _stars.add(Star(
        position: Offset(_random.nextDouble(), _random.nextDouble()),
        speed: _random.nextDouble() * 0.1,
        size: _random.nextDouble() * 2,
        color: [
          Color(0xFF00F2FE).withOpacity(0.6),
          Color(0xFFFE53BB).withOpacity(0.6),
          Color(0xFF09FBD3).withOpacity(0.6),
        ][i % 3],
      ));
    }
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
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [
                Color(0xFF0A0A1A),
                Color(0xFF000000),
              ],
              stops: [0.1, 1.0],
              center: Alignment.center,
              radius: 1.5,
            ),
          ),
          child: CustomPaint(
            painter: _CosmicPainter(
              stars: _stars,
              time: _controller.value * 2 * pi,
            ),
          ),
        );
      },
    );
  }
}

class _CosmicPainter extends CustomPainter {
  final List<Star> stars;
  final double time;

  _CosmicPainter({required this.stars, required this.time});

  @override
  void paint(Canvas canvas, Size size) {
    // Draw dark background
    final backgroundPaint = Paint()..color = Color(0xFF0A0A1A);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), backgroundPaint);

    // Draw stars
    for (final star in stars) {
      final paint = Paint()
        ..color = star.color
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, 2);

      final x = (star.position.dx + sin(time * star.speed)) * size.width;
      final y = (star.position.dy + cos(time * star.speed)) * size.height;
      canvas.drawCircle(Offset(x, y), star.size, paint);
    }

    // Draw dark nebula
    final nebulaPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          Color(0xFF1A1A2E).withOpacity(0.3),
          Color(0xFF16213E).withOpacity(0.2),
        ],
      ).createShader(Rect.fromCircle(
        center: Offset(size.width * 0.7, size.height * 0.3),
        radius: size.width * 0.4,
      ));
    canvas.drawCircle(
      Offset(size.width * 0.7, size.height * 0.3),
      size.width * 0.4,
      nebulaPaint,
    );

    // Draw cyber grid
    final gridPaint = Paint()
      ..color = Color(0xFF2D2D44).withOpacity(0.3)
      ..strokeWidth = 0.8
      ..style = PaintingStyle.stroke;

    // Vertical lines
    for (double x = 0; x < size.width; x += 40) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    // Horizontal lines
    for (double y = 0; y < size.height; y += 40) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
class Star {
  final Offset position;
  final double speed;
  final double size;
  final Color color;

  Star({
    required this.position,
    required this.speed,
    required this.size,
    required this.color,
  });
}

// Animated Galaxy Core
class AnimatedGalaxyCore extends StatefulWidget {
  @override
  State<AnimatedGalaxyCore> createState() => _AnimatedGalaxyCoreState();
}

class _AnimatedGalaxyCoreState extends State<AnimatedGalaxyCore>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 20),
    )..repeat();
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
      builder: (context, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * pi,
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  Colors.cyanAccent.withOpacity(0.1),
                  Colors.purpleAccent.withOpacity(0.05),
                ],
                stops: [0.2, 1.0],
              ),
            ),
          ),
        );
      },
    );
  }
}

// Particle Burst Effect
class ParticleBurst extends StatefulWidget {
  final int particleCount;
  final Color baseColor;

  const ParticleBurst({
    super.key,
    required this.particleCount,
    required this.baseColor,
  });

  @override
  State<ParticleBurst> createState() => _ParticleBurstState();
}

class _ParticleBurstState extends State<ParticleBurst>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Particle> _particles = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat();

    // Initialize particles
    for (int i = 0; i < widget.particleCount; i++) {
      _particles.add(Particle(
        angle: _random.nextDouble() * 2 * pi,
        speed: _random.nextDouble() * 2 + 1,
        size: _random.nextDouble() * 3 + 1,
        color: widget.baseColor.withOpacity(_random.nextDouble() * 0.5 + 0.3),
      ));
    }
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
      builder: (context, child) {
        return CustomPaint(
          painter: _ParticleBurstPainter(
            particles: _particles,
            progress: _controller.value,
          ),
        );
      },
    );
  }
}

class _ParticleBurstPainter extends CustomPainter {
  final List<Particle> particles;
  final double progress;

  _ParticleBurstPainter({required this.particles, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    for (final particle in particles) {
      final distance = progress * particle.speed * 50;
      final x = center.dx + cos(particle.angle) * distance;
      final y = center.dy + sin(particle.angle) * distance;

      final paint = Paint()
        ..color = particle.color
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, particle.size * 2);

      canvas.drawCircle(Offset(x, y), particle.size, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class Particle {
  final double angle;
  final double speed;
  final double size;
  final Color color;

  Particle({
    required this.angle,
    required this.speed,
    required this.size,
    required this.color,
  });
}

class _ParticlePainter extends CustomPainter {
  final Color color;
  final double progress;

  _ParticlePainter({required this.color, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final rng = Random(progress.hashCode);
    final paint = Paint()
      ..color = color.withOpacity(0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

    for (int i = 0; i < 20; i++) {
      final x = rng.nextDouble() * size.width;
      final y = rng.nextDouble() * size.height;
      canvas.drawCircle(Offset(x, y), rng.nextDouble() * 2, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
