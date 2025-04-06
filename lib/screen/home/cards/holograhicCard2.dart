
// Modified HolographicCard from previous example
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_website/screen/Home/buttons/neonButton.dart';
import 'package:flutter_website/screen/Home/containers/glassContainer.dart';
import 'package:flutter_website/screen/Home/particles/culturalParticles.dart';
import 'package:google_fonts/google_fonts.dart';

class HolographicCard extends StatefulWidget {
  final String image;
  final String title;
  final String date;
  final String price;
  final LinearGradient gradient;
  final Widget details;

  const HolographicCard({
    super.key,
    required this.image,
    required this.title,
    required this.date,
    required this.price,
    required this.gradient,
    required this.details,
  });

  @override
  State<HolographicCard> createState() => _HolographicCardState();
}

class _HolographicCardState extends State<HolographicCard> 
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final _random = Random();
  double _xOffset = 0;
  double _yOffset = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) {
        setState(() {
          _xOffset = (event.localPosition.dx - 150) / 30;
          _yOffset = (event.localPosition.dy - 200) / 30;
        });
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final time = DateTime.now().millisecondsSinceEpoch / 1000;
          final glowColor = Color.lerp(
            widget.gradient.colors[0],
            widget.gradient.colors[1],
            (sin(time * 2) + 1) / 2,
          )!;
          
          return Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateX(_yOffset * 0.0174533)
              ..rotateY(_xOffset * 0.0174533),
            alignment: FractionalOffset.center,
            child: GlassContainer(
              child: Stack(
                children: [
                  Image.asset(
                    widget.image,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          widget.title,
                          style: TextStyle(
                fontFamily: "Orbitron",
                            fontSize: 24,
                            color: Colors.white,
                            letterSpacing: 2,
                            shadows: [
                              Shadow(
                                color: glowColor,
                                blurRadius: 20,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        widget.details,
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Icon(Icons.calendar_today, 
                              color: glowColor, size: 16),
                            const SizedBox(width: 8),
                            Text(widget.date,
                                style: TextStyle(
                fontFamily: "Orbitron",color: glowColor)),
                            const Spacer(),
                            NeonButton(
                              onPressed: (){},
                              label: 'REGISTER NOW',
                              glowColor: glowColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }}