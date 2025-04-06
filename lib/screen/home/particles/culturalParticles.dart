
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ParticleField extends StatefulWidget {
  const ParticleField({super.key});

  @override
  State<ParticleField> createState() => _ParticleFieldState();
}

class _ParticleFieldState extends State<ParticleField> 
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Particle> particles = [];
  final _random = Random();
  final emojis = ['🌑', '🌌', '🕳️', '⚫', '🌀', '💫', '🔳', '◼️'];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
    
    for (int i = 0; i < 50; i++) {
      particles.add(Particle.generate(_random, emojis));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        for (var particle in particles) {
          particle.update(_random);
        }
        
        return Stack(
          children: particles.map((particle) {
            return Positioned(
              left: particle.x,
              top: particle.y,
              child: Opacity(
                opacity: particle.opacity,
                child: Transform.scale(
                  scale: particle.size,
                  child: Text(particle.emoji,
                      style: TextStyle(
                fontFamily: "Orbitron",fontSize: 24)),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}


class Particle {
  double x;
  double y;
  double speed;
  double size;
  double opacity;
  double angle;
  String emoji;
  double time;

  Particle({
    required this.x,
    required this.y,
    required this.speed,
    required this.size,
    required this.opacity,
    required this.angle,
    required this.emoji,
    required this.time,
  });

  factory Particle.generate(Random random, List<String> emojis) {
    return Particle(
      x: random.nextDouble() * 1000,
      y: random.nextDouble() * 2000,
      speed: random.nextDouble() * 2 + 1,
      size: random.nextDouble() * 0.5 + 0.5,
      opacity: random.nextDouble() * 0.5 + 0.3,
      angle: random.nextDouble() * 2 * pi,
      emoji: emojis[random.nextInt(emojis.length)],
      time: random.nextDouble() * 2 * pi,
    );
  }

  void update(Random random) {
    time += 0.01;
    x += cos(angle) * speed;
    y += sin(angle) * speed + sin(time) * 2;
    opacity = (sin(time) + 1) / 4 + 0.5;
    
    if (x > 1000) x = 0;
    if (y > 2000) y = 0;
    if (x < 0) x = 1000;
    if (y < 0) y = 2000;
  }

  static random(double width, double height) {}
}
