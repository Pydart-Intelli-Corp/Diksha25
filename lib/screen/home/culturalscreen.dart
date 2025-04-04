import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';

class CulturalEventsScreen extends StatelessWidget {
  const CulturalEventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0A001F), Color(0xFF1A0B47)],
          ),
        ),
        child: Stack(
          children: [
            const CyberGridBackground(),
            const ParticleField(),
            const NeonDripEffect(),
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 350,
                  collapsedHeight: 120,
                  backgroundColor: Colors.transparent,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      children: [
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ShaderMask(
                                shaderCallback: (bounds) => const LinearGradient(
                                  colors: [Color(0xFFFFD700), Color(0xFFFF8C00)],
                                ).createShader(bounds),
                                child: Text("CYBERFEST 3087",
                                    style: GoogleFonts.orbitron(
                                      fontSize: 52,
                                      letterSpacing: 8,
                                      fontWeight: FontWeight.w900,
                                    )),
                              ),
                              const SizedBox(height: 15),
                              Text("NEURAL LINK ACTIVATED",
                                  style: GoogleFonts.rajdhani(
                                    fontSize: 20,
                                    color: const Color(0xFF00F2FE),
                                    letterSpacing: 4,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                SliverToBoxAdapter(
                  child: ResponsivePadding(
                    child: SectionHeader(
                      title: "PROSHOWS",
                      gradient: const [Color(0xFFFFD700), Color(0xFFFF8C00)],
                    ),
                  ),
                ),
                
                SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: screenWidth > 1400 ? 3 : 1,
                    childAspectRatio: 1.2,
                    mainAxisSpacing: 30,
                    crossAxisSpacing: 30,
                  ),
                  delegate: SliverChildListDelegate([
                    const HolographicCard(
                      image: 'assets/images/cyberpunk1.jpg',
                      title: "NEON EMPIRE",
                      date: "NOV 15th",
                      price: "Δ 3087",
                      glowColor: Color(0xFFFF00FF),
                    ),
                    const HolographicCard(
                      image: 'assets/images/cyberpunk2.jpg',
                      title: "SYNTHWAVE LIVE",
                      date: "NOV 16th",
                      price: "Δ 3587",
                      glowColor: Color(0xFF00FFFF),
                    ),
                    const HolographicCard(
                      image: 'assets/images/cyberpunk3.jpg',
                      title: "CYBER DJ BATTLE",
                      date: "NOV 17th",
                      price: "Δ 2787",
                      glowColor: Color(0xFFFFFF00),
                    ),
                  ]),
                ),

                SliverToBoxAdapter(
                  child: ResponsivePadding(
                    child: SectionHeader(
                      title: "WORKSHOPS",
                      gradient: const [Color(0xFF00F2FE), Color(0xFF4FACFE)],
                    ),
                  ),
                ),
                
                SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: screenWidth > 1200 ? 3 : 1,
                    childAspectRatio: 1.4,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                  ),
                  delegate: SliverChildListDelegate([
                    WorkshopCard(
                      image: 'assets/neural_interface.jpg',
                      title: "NEURAL LINK SETUP",
                      subtitle: "Direct Brain Interface",
                      gradient: const [Color(0xFFFF00FF), Color(0xFF00FFFF)],
                    ),
                    WorkshopCard(
                      image: 'assets/cyber_implants.jpg',
                      title: "CYBER IMPLANTS",
                      subtitle: "Augmentation Tech",
                      gradient: const [Color(0xFFFFFF00), Color(0xFFFF8C00)],
                    ),
                    WorkshopCard(
                      image: 'assets/holo_engineering.jpg',
                      title: "HOLO ENGINEERING",
                      subtitle: "Projection Systems",
                      gradient: const [Color(0xFF00FF00), Color(0xFF00F2FE)],
                    ),
                  ]),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 100)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class HolographicCard extends StatefulWidget {
  final String image;
  final String title;
  final String date;
  final String price;
  final Color glowColor;

  const HolographicCard({
    super.key,
    required this.image,
    required this.title,
    required this.date,
    required this.price,
    required this.glowColor,
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
      duration: const Duration(seconds: 5),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) {
        setState(() {
          _xOffset = (event.localPosition.dx - 200) / 40;
          _yOffset = (event.localPosition.dy - 250) / 40;
        });
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateX(_yOffset * 0.0174533)
              ..rotateY(_xOffset * 0.0174533),
            alignment: FractionalOffset.center,
            child: Container(
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: widget.glowColor.withOpacity(0.4),
                    blurRadius: 50,
                    spreadRadius: 10,
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
                            Colors.black.withOpacity(0.9),
                          ],
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: widget.glowColor.withOpacity(0.8),
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            widget.title,
                            style: GoogleFonts.orbitron(
                              fontSize: 32,
                              color: Colors.white,
                              letterSpacing: 3,
                              shadows: [
                                Shadow(
                                  color: widget.glowColor,
                                  blurRadius: 30,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              Icon(Icons.bolt, color: widget.glowColor, size: 24),
                              const SizedBox(width: 10),
                              Text(widget.date,
                                  style: GoogleFonts.rajdhani(
                                    color: widget.glowColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  )),
                              const Spacer(),
                              CyberButton(
                                onPressed: () => _showCyberDialog(context),
                                label: 'NEURO-REGISTER',
                                glowColor: widget.glowColor,
                              ),
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
      ),
    );
  }

  void _showCyberDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: CyberContainer(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("NEURAL REGISTRATION",
                    style: GoogleFonts.orbitron(
                        color: widget.glowColor,
                        fontSize: 24,
                        letterSpacing: 2)),
                const SizedBox(height: 25),
                CyberTextField(
                  hint: "ENTER CYBER ID",
                  glowColor: widget.glowColor,
                ),
                const SizedBox(height: 25),
                CyberButton(
                  onPressed: () => Navigator.pop(context),
                  label: 'CONFIRM TRANSACTION',
                  glowColor: widget.glowColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CyberGridBackground extends StatelessWidget {
  const CyberGridBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CyberGridPainter(),
      size: Size.infinite,
    );
  }
}

class _CyberGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF2A0F5C)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    // Vertical lines
    for (double x = 0; x < size.width; x += 60) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    // Horizontal lines
    for (double y = 0; y < size.height; y += 60) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }

    // Diagonal pattern
    final diagonalPaint = Paint()
      ..color = const Color(0x152A0F5C)
      ..strokeWidth = 1;
    for (double i = -size.height; i < size.width; i += 30) {
      canvas.drawLine(Offset(i, 0), Offset(i + size.height, size.height), diagonalPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class NeonDripEffect extends StatelessWidget {
  const NeonDripEffect({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _NeonDripPainter(),
      size: Size.infinite,
    );
  }
}

class _NeonDripPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF00F2FE).withOpacity(0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final path = Path()
      ..moveTo(0, size.height * 0.2)
      ..quadraticBezierTo(size.width * 0.3, size.height * 0.1, size.width * 0.5, size.height * 0.3)
      ..quadraticBezierTo(size.width * 0.7, size.height * 0.5, size.width, size.height * 0.4);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class CyberButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String label;
  final Color glowColor;

  const CyberButton({
    super.key,
    required this.onPressed,
    required this.label,
    required this.glowColor,
  });

  @override
  State<CyberButton> createState() => _CyberButtonState();
}

class _CyberButtonState extends State<CyberButton> 
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: widget.glowColor.withOpacity(_controller.value * 0.6),
                blurRadius: 20,
                spreadRadius: 3,
              ),
            ],
          ),
          child: TextButton(
            onPressed: widget.onPressed,
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
              backgroundColor: Colors.black.withOpacity(0.4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: BorderSide(
                  color: widget.glowColor,
                  width: 2,
                ),
              ),
            ),
            child: Text(widget.label,
                style: GoogleFonts.orbitron(
                  fontSize: 16,
                  color: widget.glowColor,
                  letterSpacing: 1.5,
                )),
          ),
        );
      },
    );
  }
}

class WorkshopCard extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final List<Color> gradient;

  const WorkshopCard({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsivePadding(
      child: CyberContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: gradient,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Image.asset(image, fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: GoogleFonts.orbitron(
                          fontSize: 20,
                          color: Colors.white,
                          letterSpacing: 1.5)),
                  const SizedBox(height: 10),
                  Text(subtitle,
                      style: GoogleFonts.rajdhani(
                          color: Colors.white70,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 15),
                  CyberButton(
                    onPressed: () {},
                    label: 'ACCESS TRAINING',
                    glowColor: gradient.first,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CyberContainer extends StatelessWidget {
  final Widget child;

  const CyberContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.black.withOpacity(0.3),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 30,
            spreadRadius: 5,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: child,
        ),
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  final List<Color> gradient;

  const SectionHeader({
    super.key,
    required this.title,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: ShaderMask(
        shaderCallback: (bounds) => LinearGradient(
          colors: gradient,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ).createShader(bounds),
        child: Text(title,
            style: GoogleFonts.orbitron(
              fontSize: 38,
              letterSpacing: 6,
              fontWeight: FontWeight.w900,
            )),
      ),
    );
  }
}

class CyberTextField extends StatelessWidget {
  final String hint;
  final Color glowColor;

  const CyberTextField({
    super.key,
    required this.hint,
    required this.glowColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: glowColor.withOpacity(0.5), width: 2),
        boxShadow: [
          BoxShadow(
            color: glowColor.withOpacity(0.2),
            blurRadius: 15,
            spreadRadius: 3,
          ),
        ],
      ),
      child: TextField(
        style: GoogleFonts.rajdhani(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: glowColor.withOpacity(0.7)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(20),
        ),
      ),
    );
  }
}

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
  final emojis = ['✦', '❖', '◆', '◈', '◎', '⌘', '⏣', '⌬'];

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
                        fontSize: 24,
                        color: const Color(0xFF00F2FE).withOpacity(0.7),
                      ),
                ),
              ),
            ));
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
}

class ResponsivePadding extends StatelessWidget {
  final Widget child;

  const ResponsivePadding({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth > 1200 ? 100 : 20,
        vertical: 20,
      ),
      child: child,
    );
  }
}