import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

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
        'image': 'assets/images/robo-war.webp',
        'description': 'Epic robotic battles in neon-lit arenas. Last bot standing wins!',
        'icon': Icons.rocket_launch,
        'color': Colors.cyan,
      },
      {
        'name': 'Line Robot',
        'coordinator': 'Ardar',
        'contact': '+91 98765 43211',
        'image': 'assets/images/line-robot.webp',
        'description': 'Navigate the course with precision and speed!',
        'icon': Icons.directions_car,
        'color': Colors.orange,
      },
      {
        'name': 'Robo Tug of War',
        'coordinator': 'Heera',
        'contact': '+91 98765 43212',
        'image': 'assets/images/robo-tug.webp',
        'description': 'Team-based contest of strength and strategy.',
        'icon': Icons.handshake,
        'color': Colors.redAccent,
      },
      {
        'name': 'Tech Quiz',
        'coordinator': 'Navaneeth',
        'contact': '+91 98765 43213',
        'image': 'assets/images/tech-quiz.webp',
        'description': 'Challenge your knowledge in tech and innovation!',
        'icon': Icons.question_mark,
        'color': Colors.blue,
      },
      {
        'name': 'GPT Prompt Competition',
        'coordinator': 'Aaesha',
        'contact': '+91 98765 43214',
        'image': 'assets/images/gpt-prompt.webp',
        'description': 'Craft the most creative AI prompts.',
        'icon': Icons.smart_toy,
        'color': Colors.green,
      },
      {
        'name': 'Colour Mixing',
        'coordinator': 'Nandkishor',
        'contact': '+91 98765 43215',
        'image': 'assets/images/colour-mixing.webp',
        'description': 'Blend hues and create visual masterpieces.',
        'icon': Icons.color_lens,
        'color': Colors.pinkAccent,
      },
      {
        'name': 'Poster Making Competition',
        'coordinator': 'Nijin',
        'contact': '+91 98765 43216',
        'image': 'assets/images/poster-making.webp',
        'description': 'Design captivating posters with innovative ideas.',
        'icon': Icons.brush,
        'color': Colors.deepPurple,
      },
      {
        'name': 'Circuit Debugging',
        'coordinator': 'Abhinand ECE',
        'contact': '+91 98765 43217',
        'image': 'assets/images/circuit-debugging.webp',
        'description': 'Troubleshoot and fix electronic circuits under pressure.',
        'icon': Icons.memory,
        'color': Colors.teal,
      },
      {
        'name': 'Project Presentation',
        'coordinator': 'Hiba',
        'contact': '+91 98765 43218',
        'image': 'assets/images/project-presentation.webp',
        'description': 'Showcase your project and impress the judges.',
        'icon': Icons.present_to_all,
        'color': Colors.indigo,
      },
      {
        'name': 'Meme Making Competition',
        'coordinator': 'Hiba',
        'contact': '+91 98765 43219',
        'image': 'assets/images/meme-making.webp',
        'description': 'Create viral memes and entertain the crowd.',
        'icon': Icons.emoji_emotions,
        'color': Colors.yellow,
      },
      {
        'name': 'Coding Competition',
        'coordinator': 'Raniya',
        'contact': '+91 98765 43220',
        'image': 'assets/images/coding-competition.webp',
        'description': 'Solve problems and code under pressure.',
        'icon': Icons.code,
        'color': Colors.lightBlue,
      },
      {
        'name': 'CAD',
        'coordinator': 'Abhinand PR',
        'contact': '+91 98765 43221',
        'image': 'assets/images/cad.webp',
        'description': 'Design and innovate using computer-aided design.',
        'icon': Icons.design_services,
        'color': Colors.lime,
      },
      {
        'name': 'Circuit Decoding',
        'coordinator': 'Dheeraj',
        'contact': '+91 98765 43222',
        'image': 'assets/images/circuit-decoding.webp',
        'description': 'Decode and understand complex circuit diagrams.',
        'icon': Icons.electrical_services,
        'color': Colors.amber,
      },
      {
        'name': 'Ideathony',
        'coordinator': 'Amal',
        'contact': '+91 98765 43223',
        'image': 'assets/images/ideathony.webp',
        'description': 'Pitch your groundbreaking ideas in a dynamic forum.',
        'icon': Icons.lightbulb,
        'color': Colors.deepOrange,
      },
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF00081D),
            Color(0xFF0A0025),
            Color(0xFF1A0030),
          ],
        ),
      ),
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
            itemCount: events.length,
            itemBuilder: (context, index) => _EventCard(
              eventName: events[index]['name'] as String,
              coordinator: events[index]['coordinator'] as String,
              contact: events[index]['contact'] as String,
              image: events[index]['image'] as String,
              description: events[index]['description'] as String,
              icon: events[index]['icon'] as IconData,
              color: events[index]['color'] as Color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(bool isMobile) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedContainer(
          duration: const Duration(seconds: 2),
          curve: Curves.easeInOut,
          width: 320,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: Colors.blueAccent.withOpacity(0.3),
                blurRadius: 40,
                spreadRadius: 20,
              ),
            ],
          ),
        ),
        Text(
          'EVENTRONIX',
          style: TextStyle(
            fontSize: isMobile ? 42 : 62,
            fontFamily: 'Orbitron',
            fontWeight: FontWeight.w900,
            foreground: Paint()
              ..shader = const LinearGradient(
                colors: [Colors.cyanAccent, Colors.purpleAccent],
                stops: [0.3, 0.7],
              ).createShader(const Rect.fromLTWH(0, 0, 300, 70)),
          ),
        ),
        Positioned(
          bottom: -10,
          child: _AnimatedUnderline(),
        ),
      ],
    );
  }
}

class _AnimatedUnderline extends StatefulWidget {
  @override
  State<_AnimatedUnderline> createState() => _AnimatedUnderlineState();
}

class _AnimatedUnderlineState extends State<_AnimatedUnderline>
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
        return Container(
          width: 200 + 100 * _controller.value,
          height: 4,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.cyanAccent.withOpacity(_controller.value),
                Colors.purpleAccent.withOpacity(1 - _controller.value),
              ],
            ),
            borderRadius: BorderRadius.circular(2),
          ),
        );
      },
    );
  }
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
                        Colors.black.withOpacity(0.7),
                        Colors.black.withOpacity(0.9),
                      ],
                    ),
                  ),
                ),
              ),
              // Glassmorphic Effect
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
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
                                ).createShader(const Rect.fromLTWH(0, 0, 200, 50)),
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
                        fontFamily: 'Exo2',
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
              fontFamily: 'Exo2',
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
