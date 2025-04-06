
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_website/screen/Home/buttons/neonButton.dart';
import 'package:flutter_website/screen/Home/containers/glassContainer.dart';
import 'package:flutter_website/screen/culturalscreen.dart';
import 'package:flutter_website/screen/Home/particles/culturalParticles.dart';
import 'package:google_fonts/google_fonts.dart';

class HolographicCardNoButton extends StatefulWidget {
  final String image;
  final String title;
  final String date;
  final String price;

  const HolographicCardNoButton({
    super.key,
    required this.image,
    required this.title,
    required this.date,
    required this.price,
  });

  @override
  State<HolographicCardNoButton> createState() => _HolographicCardNoButtonState();
}

class _HolographicCardNoButtonState extends State<HolographicCardNoButton> 
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
    final isMobile = MediaQuery.of(context).size.width < 600;

    return MouseRegion(
      onHover: (event) {
        setState(() {
          _xOffset = (event.localPosition.dx - 150) / 30;
          _yOffset = (event.localPosition.dy - 200) / 30;
        });
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          return AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final time = DateTime.now().millisecondsSinceEpoch / 1000;
              final glowColor = Color.lerp(
                const Color.fromARGB(255, 89, 46, 169),
                const Color.fromARGB(255, 205, 235, 12),
                (sin(time * 2) + 1) / 2,
              )!;
              
              return Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateX(_yOffset * 0.0174533)
                  ..rotateY(_xOffset * 0.0174533),
                alignment: FractionalOffset.center,
                child: Container(
                  margin: EdgeInsets.all(isMobile ? 8 : 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: glowColor.withOpacity(0.5),
                        blurRadius: 30,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Stack(
                      children: [
                        Image.asset(
                          widget.image,
                          fit: BoxFit.cover,
                          width: constraints.maxWidth,
                          height: constraints.maxHeight,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.8),
                              ],
                            ),
                          ),
                        ),
                        Positioned.fill(
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: glowColor,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(30),
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
                                  fontSize: isMobile ? 20 : 24,
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
                              Row(
                                children: [
                                  Icon(Icons.date_range, color: glowColor, size: 18),
                                  const SizedBox(width: 8),
                                  Text(widget.date,
                                      style: TextStyle(color: glowColor)),
                                  const Spacer(),
                              
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
   void _showHolographicDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: GlassContainer(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Holographic Registration",
                    style: TextStyle(
                        color: Colors.white, fontSize: 20)),
                const SizedBox(height: 20),
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Enter Neural ID',
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.white70),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 20),
                NeonButton(
                  onPressed: () => Navigator.pop(context),
                  label: 'CONFIRM',
                  glowColor: const Color(0xFF09FBD3),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}