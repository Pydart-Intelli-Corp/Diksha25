import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_website/screen/Home/buttons/neonButton.dart';
import 'package:flutter_website/screen/culturalscreen.dart';
import 'package:flutter_website/screen/Home/particles/culturalParticles.dart';
import 'package:google_fonts/google_fonts.dart';

class CulturalEventCard extends StatelessWidget {
  const CulturalEventCard({super.key});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, '/cultural-events'),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              colors: [Color(0xFF1A0B47), Color(0xFF2D0B5E)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFE53BB).withOpacity(0.4),
                blurRadius: 30,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Stack(
            children: [
              // Neon Grid Background
              const Positioned.fill(child: NeonGridOverlay()),
              
              // Holographic Particles
              const Positioned.fill(child: CyberParticleField()),
              
              // Content
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    // Holographic Icon
                    HolographicIconContainer(
                      child: const Icon(
                        Icons.celebration,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Neon Title
                    ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [Color(0xFF00F2FE), Color(0xFF4FACFE)],
                      ).createShader(bounds),
                      child: Text(
                        'CULTURAL NEXUS',
                        style: TextStyle(
                fontFamily: "Orbitron",
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 255, 255, 255),
                          letterSpacing: 4,
                          shadows: [
                            Shadow(
                              color: const Color(0xFF09FBD3).withOpacity(0.5),
                              blurRadius: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    // Cyberpunk Description
                    Text(
                      'IMMERSE IN DIGITAL TRADITIONS\nNEON-FUELED PERFORMANCES',
                      textAlign: TextAlign.center,
                    style: TextStyle(
                  fontFamily: 'Orbitron',
                        color: Colors.white70,
                        fontSize: 18,
                        letterSpacing: 2,
                        height: 1.4,
                        shadows: [
                          Shadow(
                            color: const Color(0xFFFE53BB).withOpacity(0.3),
                            blurRadius: 15,
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    // Cyber Button
                    NeonButton(
                      onPressed: () => Navigator.pushNamed(context, '/cultural-events'),
                      label: 'ACCESS MATRIX',
                      glowColor: const Color(0xFFFE53BB),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HolographicIconContainer extends StatefulWidget {
  final Widget child;

  const HolographicIconContainer({super.key, required this.child});

  @override
  State<HolographicIconContainer> createState() => _HolographicIconContainerState();
}

class _HolographicIconContainerState extends State<HolographicIconContainer> 
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: SweepGradient(
              colors: const [
                Color(0xFF09FBD3),
                Color(0xFFFE53BB),
                Color(0xFF09FBD3),
              ],
              stops: const [0.0, 0.5, 1.0],
              startAngle: _controller.value * 2 * pi,
              endAngle: _controller.value * 2 * pi + pi/2,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF00F2FE).withOpacity(0.3),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black.withOpacity(0.3),
            ),
            child: widget.child,
          ),
        );
      },
    );
  }
}

class CyberParticleField extends StatefulWidget {
  const CyberParticleField({super.key});

  @override
  State<CyberParticleField> createState() => _CyberParticleFieldState();
}

class _CyberParticleFieldState extends State<CyberParticleField> 
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<CyberParticle> _particles = [];
  final Random _random = Random();
  final colors = [const Color(0xFF09FBD3), const Color(0xFFFE53BB), const Color(0xFF4FACFE)];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
    
    for (int i = 0; i < 100; i++) {
      _particles.add(CyberParticle.generate(_random, colors));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: _CyberParticlePainter(
            particles: _particles,
            time: DateTime.now().millisecondsSinceEpoch / 1000,
          ),
        );
      },
    );
  }
}

class _CyberParticlePainter extends CustomPainter {
  final List<CyberParticle> particles;
  final double time;

  _CyberParticlePainter({required this.particles, required this.time});

  @override
  void paint(Canvas canvas, Size size) {
    for (final particle in particles) {
      final paint = Paint()
        ..color = particle.color.withOpacity(particle.opacity)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, particle.size);
      
      final x = (particle.x + cos(time * particle.speed)) % 1.0 * size.width;
      final y = (particle.y + sin(time * particle.speed)) % 1.0 * size.height;
      
      canvas.drawCircle(Offset(x, y), particle.size, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class CyberParticle {
  final double x;
  final double y;
  final double speed;
  final double size;
  final Color color;
  final double opacity;

  CyberParticle({
    required this.x,
    required this.y,
    required this.speed,
    required this.size,
    required this.color,
    required this.opacity,
  });

  factory CyberParticle.generate(Random random, List<Color> colors) {
    return CyberParticle(
      x: random.nextDouble(),
      y: random.nextDouble(),
      speed: random.nextDouble() * 0.5 + 0.2,
      size: random.nextDouble() * 4 + 2,
      color: colors[random.nextInt(colors.length)],
      opacity: random.nextDouble() * 0.3 + 0.2,
    );
  }
}

class NeonGridOverlay extends StatelessWidget {
  const NeonGridOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _NeonGridPainter(),
    );
  }
}

class _NeonGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF00F2FE).withOpacity(0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    for (double i = 0; i < size.width; i += 50) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
    for (double i = 0; i < size.height; i += 50) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}