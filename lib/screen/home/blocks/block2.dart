import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_website/screen/Home/blocks/culturalcard.dart';

import 'package:flutter_website/screen/Home/culturalscreen.dart';
import 'package:google_fonts/google_fonts.dart';

class EventGrid extends StatelessWidget {
  const EventGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final List<Map<String, dynamic>> events = [
      {
        'name': 'Robo War',
        'coordinator': 'Kavya',
        'contact': '+91 98765 43210',
        'image': 'assets/images/diksha/robowar.webp',
        'description':
            'Epic robotic battles in neon-lit arenas. Last bot standing wins!',
        'icon': Icons.rocket_launch,
        'color': Colors.cyan,
      },
      {
        'name': 'Line Robot',
        'coordinator': 'Ardar',
        'contact': '+91 98765 43211',
        'image': 'assets/images/diksha/linefollower.webp',
        'description': 'Navigate the course with precision and speed!',
        'icon': Icons.directions_car,
        'color': Colors.orange,
      },
      {
        'name': 'Robo Tug of War',
        'coordinator': 'Heera',
        'contact': '+91 98765 43212',
        'image': 'assets/images/diksha/tugofwar.webp',
        'description': 'Team-based contest of strength and strategy.',
        'icon': Icons.handshake,
        'color': Colors.redAccent,
      },
      {
        'name': 'Tech Quiz',
        'coordinator': 'Navaneeth',
        'contact': '+91 98765 43213',
        'image': 'assets/images/diksha/quiz.webp',
        'description': 'Challenge your knowledge in tech and innovation!',
        'icon': Icons.question_mark,
        'color': Colors.blue,
      },
      {
        'name': 'GPT Prompt Competition',
        'coordinator': 'Aaesha',
        'contact': '+91 98765 43214',
        'image': 'assets/images/diksha/gpt.webp',
        'description': 'Craft the most creative AI prompts.',
        'icon': Icons.smart_toy,
        'color': Colors.green,
      },
      {
        'name': 'Colour Mixing',
        'coordinator': 'Nandkishor',
        'contact': '+91 98765 43215',
        'image': 'assets/images/diksha/color.webp',
        'description': 'Blend hues and create visual masterpieces.',
        'icon': Icons.color_lens,
        'color': Colors.pinkAccent,
      },
      {
        'name': 'Poster Making Competition',
        'coordinator': 'Nijin',
        'contact': '+91 98765 43216',
        'image': 'assets/images/diksha/poster.webp',
        'description': 'Design captivating posters with innovative ideas.',
        'icon': Icons.brush,
        'color': Colors.deepPurple,
      },
      {
        'name': 'Circuit Debugging',
        'coordinator': 'Abhinand ECE',
        'contact': '+91 98765 43217',
        'image': 'assets/images/diksha/debugging.webp',
        'description':
            'Troubleshoot and fix electronic circuits under pressure.',
        'icon': Icons.memory,
        'color': Colors.teal,
      },
      {
        'name': 'Project Presentation',
        'coordinator': 'Hiba',
        'contact': '+91 98765 43218',
        'image': 'assets/images/diksha/project.webp',
        'description': 'Showcase your project and impress the judges.',
        'icon': Icons.present_to_all,
        'color': Colors.indigo,
      },
      {
        'name': 'Meme Making Competition',
        'coordinator': 'Hiba',
        'contact': '+91 98765 43219',
        'image': 'assets/images/diksha/meme.webp',
        'description': 'Create viral memes and entertain the crowd.',
        'icon': Icons.emoji_emotions,
        'color': Colors.yellow,
      },
      {
        'name': 'Coding Competition',
        'coordinator': 'Raniya',
        'contact': '+91 98765 43220',
        'image': 'assets/images/diksha/coding.webp',
        'description': 'Solve problems and code under pressure.',
        'icon': Icons.code,
        'color': Colors.lightBlue,
      },
      {
        'name': 'CAD',
        'coordinator': 'Abhinand PR',
        'contact': '+91 98765 43221',
        'image': 'assets/images/diksha/autocad.webp',
        'description': 'Design and innovate using computer-aided design.',
        'icon': Icons.design_services,
        'color': Colors.lime,
      },
      {
        'name': 'Circuit Decoding',
        'coordinator': 'Dheeraj',
        'contact': '+91 98765 43222',
        'image': 'assets/images/diksha/decode.webp',
        'description': 'Decode and understand complex circuit diagrams.',
        'icon': Icons.electrical_services,
        'color': Colors.amber,
      },
      {
        'name': 'Ideathon',
        'coordinator': 'Amal',
        'contact': '+91 98765 43223',
        'image': 'assets/images/diksha/idea.webp',
        'description': 'Pitch your groundbreaking ideas in a dynamic forum.',
        'icon': Icons.lightbulb,
        'color': Colors.deepOrange,
      },
    ];

    return Stack(
      children: [
        // Enhanced Cosmic Background with Tech Particles
        Positioned.fill(
          child: Stack(
            children: [
              CosmicBackground(),
              ParticleField(), // From previous example
            ],
          ),
        ),

        ResponsivePadding(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Column(
              children: [
                _buildTitle(isMobile),
                const SizedBox(height: 40),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isMobile ? 1 : 3,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    childAspectRatio: 0.9,
                  ),
                  itemCount: events.length + 1,
                  itemBuilder: (context, index) {
                    if (index == events.length) {
                      return CulturalEventCard();
                    }
                    return HolographicCard(
                      image: events[index]['image'] as String,
                      title: events[index]['name'] as String,
                      date: 'Oct ${24 + index}th',
                      price: '₹${1500 + index * 100}',
                      gradient: _getEventGradient(index),
                      details: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildInfoRow(
                              Icons.person, events[index]['coordinator']),
                          if ((events[index]['contact'] as String).isNotEmpty)
                            _buildInfoRow(
                                Icons.phone, events[index]['contact']),
                          const SizedBox(height: 10),
                          Text(events[index]['description'],
                              style: GoogleFonts.orbitron(
                                  color: Colors.white70, fontSize: 14)),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  LinearGradient _getEventGradient(int index) {
    final gradients = [
      const [Color(0xFFFE53BB), Color(0xFF09FBD3)],
      const [Color(0xFFFFE259), Color(0xFFFFA751)],
      const [Color(0xFF00F2FE), Color(0xFF4FACFE)],
      const [Color(0xFF6A11CB), Color(0xFF2575FC)],
    ];
    return LinearGradient(
      colors: gradients[index % gradients.length],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }

  Widget _buildTitle(bool isMobile) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Galactic Core Effect
         AnimatedGalaxyCore(),

        // Title Text
        ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xFF00F2FE), Color(0xFFFE53BB)],
            stops: [0.3, 0.7],
          ).createShader(bounds),
          child: Text(
            'EVENTRONIX',
            style: GoogleFonts.orbitron(
              fontSize: isMobile ? 42 : 62,
              fontWeight: FontWeight.w900,
              letterSpacing: 4,
              shadows: [
                Shadow(
                    color: Colors.cyanAccent.withOpacity(0.5),
                    blurRadius: 20,
                    offset: Offset(0, 0)),
                Shadow(
                    color: Colors.purpleAccent.withOpacity(0.5),
                    blurRadius: 40,
                    offset: Offset(0, 0)),
              ],
            ),
          ),
        ),

        // Particle Burst
        Positioned.fill(
          child: ParticleBurst(
            particleCount: 30,
            baseColor: const Color(0xFF09FBD3),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: Colors.white70, size: 18),
          const SizedBox(width: 10),
          Text(
            text,
            style: GoogleFonts.orbitron(
                color: Colors.white70, fontSize: 16),
          ),
        ],
      ),
    );
  }
}

// Modified HolographicCard from previous example
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
            child: CyberContainer(
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
                          style: GoogleFonts.orbitron(
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
                                style: TextStyle(color: glowColor)),
                            const Spacer(),
                            CyberButton(
                              onPressed: () => _showRegistrationDialog(context),
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
  }

  void _showRegistrationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: CyberContainer(
       
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Event Registration",
                  style: GoogleFonts.orbitron(
                      color: Colors.white, fontSize: 20)),
              const SizedBox(height: 20),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Enter Tech ID',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(color: Colors.white70),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20),
              CyberButton(
                onPressed: () => Navigator.pop(context),
                label: 'CONFIRM',
                glowColor: const Color(0xFF09FBD3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Retain all previous helper classes (ParticleField, GlassContainer, 
// NeonButton, AnimatedGalaxyCore, etc.) from original futuristic example
// Ensure all fonts are set to Orbitron/orbitron via GoogleFonts

// Cosmic Background Implementation
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

    // Initialize stars
    for (int i = 0; i < 200; i++) {
      _stars.add(Star(
        position: Offset(_random.nextDouble(), _random.nextDouble()),
        speed: _random.nextDouble() * 0.1,
        size: _random.nextDouble() * 2,
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
          painter: _CosmicPainter(
            stars: _stars,
            time: _controller.value * 2 * pi,
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
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.8)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 2);

    // Draw stars
    for (final star in stars) {
      final x = (star.position.dx + sin(time * star.speed)) * size.width;
      final y = (star.position.dy + cos(time * star.speed)) * size.height;
      canvas.drawCircle(Offset(x, y), star.size, paint);
    }

    // Draw nebula
    final nebulaPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.purple.withOpacity(0.1),
          Colors.blue.withOpacity(0.05),
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
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class Star {
  final Offset position;
  final double speed;
  final double size;

  Star({
    required this.position,
    required this.speed,
    required this.size,
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

class _EventCard extends StatefulWidget {
  final String eventName;
  final String coordinator;
  final String contact;
  final String image;
  final String description;
  final IconData icon;
  final Color color;

  const _EventCard({
    required this.eventName,
    required this.coordinator,
    required this.contact,
    required this.image,
    required this.description,
    required this.icon,
    required this.color,
  });

  @override
  State<_EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<_EventCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isHovered = false;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: Matrix4.identity()
          ..scale(_isHovered ? 1.02 : 1.0)
          ..rotateZ(_isHovered ? _random.nextDouble() * 0.05 - 0.025 : 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: widget.color.withOpacity(_isHovered ? 0.4 : 0.2),
              blurRadius: _isHovered ? 40 : 20,
              spreadRadius: _isHovered ? 2 : 1,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              // Background Image from Assets
              Positioned.fill(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  transform: Matrix4.identity()
                    ..translate(
                      _isHovered ? _random.nextDouble() * 10 - 5 : 0,
                      _isHovered ? _random.nextDouble() * 10 - 5 : 0,
                    ),
                  child: Image.asset(
                    widget.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Holographic Overlay
              Positioned.fill(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color.fromARGB(206, 0, 0, 0),
                        const Color.fromARGB(0, 0, 0, 0)
                      ],
                    ),
                  ),
                ),
              ),
              // Glassmorphic Effect
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                  child: Container(),
                ),
              ),
              // Content
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _AnimatedIcon(icon: widget.icon, color: widget.color),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Text(
                            widget.eventName,
                            style: TextStyle(
                              fontSize: 24,
                              fontFamily: 'Orbitron',
                              fontWeight: FontWeight.w700,
                              foreground: Paint()
                                ..shader = LinearGradient(
                                  colors: [
                                    widget.color,
                                    widget.color.withOpacity(0.7),
                                  ],
                                ).createShader(
                                    const Rect.fromLTWH(0, 0, 200, 50)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      widget.description,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 14,
                        height: 1.4,
                        fontFamily: 'orbitron',
                      ),
                    ),
                    const Spacer(),
                    _buildInfoRow(Icons.person, widget.coordinator),
                    if (widget.contact.isNotEmpty)
                      _buildInfoRow(Icons.phone, widget.contact),
                    const SizedBox(height: 15),
                    _buildAnimatedDivider(),
                  ],
                ),
              ),
              // Neon Border
              Positioned.fill(
                child: IgnorePointer(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: widget.color.withOpacity(_isHovered ? 0.6 : 0.3),
                        width: _isHovered ? 3 : 1.5,
                      ),
                    ),
                  ),
                ),
              ),
              // Floating Particles
              if (_isHovered)
                Positioned.fill(
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return CustomPaint(
                        painter: _ParticlePainter(
                          color: widget.color,
                          progress: _controller.value,
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: widget.color, size: 18),
          const SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 16,
              fontFamily: 'orbitron',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedDivider() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          height: 2,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                widget.color.withOpacity(0.8),
                widget.color.withOpacity(0.2),
              ],
              stops: [_controller.value, _controller.value + 0.2],
            ),
          ),
        );
      },
    );
  }
}

class _AnimatedIcon extends StatefulWidget {
  final IconData icon;
  final Color color;

  const _AnimatedIcon({required this.icon, required this.color});

  @override
  State<_AnimatedIcon> createState() => _AnimatedIconState();
}

class _AnimatedIconState extends State<_AnimatedIcon>
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
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 4 * _controller.value),
          child: Icon(
            widget.icon,
            color: widget.color.withOpacity(0.8 + 0.2 * _controller.value),
            size: 32,
          ),
        );
      },
    );
  }
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
