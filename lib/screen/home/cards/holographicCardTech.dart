import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_website/screen/Home/buttons/neonButton.dart';
import 'package:flutter_website/screen/Home/containers/glassContainer.dart';
import 'package:url_launcher/url_launcher.dart';

class HolographicCardTech extends StatefulWidget {
  final String image;
  final String title;
  final String date;
  final String price;
  final String coordinator;
  final String contact;
  final String registration;
  final IconData icon;
  final Color color;
  final String link;

  const HolographicCardTech({
    super.key,
    required this.image,
    required this.title,
    required this.date,
    required this.price,
    required this.coordinator,
    required this.contact,
    required this.registration,
    required this.icon,
    required this.color,
       required this.link,
  });

  @override
  State<HolographicCardTech> createState() => _HolographicCardTechState();
}

class _HolographicCardTechState extends State<HolographicCardTech>
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
          // Adjust the tilt offsets based on cursor position.
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
              // Generate a dynamic glow color by interpolating between two colors.
              final glowColor = Color.lerp(
                const Color(0xFF00F2FE),
                const Color(0xFFFE53BB),
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
                        // Background image
                        Image.asset(
                          widget.image,
                          fit: BoxFit.cover,
                          width: constraints.maxWidth,
                          height: constraints.maxHeight,
                        ),
                        // Gradient overlay for readability
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
                        // Glowing animated border
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
                        // Event details content
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // Event title
                              Text(
                                widget.title,
                                style: TextStyle(
                                  fontFamily: "Orbitron",
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
                              // Date with icon
                              Row(
                                children: [
                                  Icon(Icons.date_range,
                                      color: glowColor, size: 18),
                                  const SizedBox(width: 8),
                                  Text(
                                    widget.date,
                                    style: TextStyle(
                                      fontFamily: "Orbitron",
                                      color: glowColor,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                               Text(
                             "Reg : ${widget.registration}",
                                style: const TextStyle(
                                  fontFamily: "Orbitron",
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                                const SizedBox(height: 5),
                              Text(
                                "Price: ${widget.price}",
                                style: const TextStyle(
                                  fontFamily: "Orbitron",
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 5),
                              // Coordinator details
                              Text(
                                "Coordinator: ${widget.coordinator}",
                                style: const TextStyle(
                                  fontFamily: "Orbitron",
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 5),
                              // Contact information
                              Text(
                                "Contact: ${widget.contact}",
                                style: const TextStyle(
                                  fontFamily: "Orbitron",
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                           
                            
                              const SizedBox(height: 10),
                              // Register button aligned at the bottom right
                              
const SizedBox(height: 10),
// Contact and Register buttons at bottom edges
Container(
  width: double.infinity,
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      NeonButton(
        onPressed: () async {
          final Uri contactUri = Uri.parse('tel:${widget.contact}');
          if (await canLaunchUrl(contactUri)) {
            await launchUrl(contactUri);
          }
        },
        label: 'CONTACT',
        glowColor: glowColor,
      ),
      NeonButton(
        onPressed: () async {
          final Uri _registerUri = Uri.parse(widget.link);
          await launchUrl(_registerUri);
        },
        label: 'REGISTER NOW',
        glowColor: glowColor,
      ),
    ],
  ),
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
                Text(
                  "Holographic Registration",
                  style: TextStyle(
                    fontFamily: "Orbitron",
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 20),
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Enter Neural ID',
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(
                      fontFamily: "Orbitron",
                      color: Colors.white70,
                    ),
                  ),
                  style: TextStyle(
                    fontFamily: "Orbitron",
                    color: Colors.white,
                  ),
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
