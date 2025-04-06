import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_website/screen/Home/cards/holographicCardTech.dart';

import 'package:flutter_website/screen/Home/particles/cosmic.dart';
import 'package:flutter_website/screen/Home/particles/culturalParticles.dart';
import 'package:flutter_website/screen/culturalscreen.dart';
import 'package:google_fonts/google_fonts.dart';

class TechnicalEventsScreen extends StatelessWidget {
  const TechnicalEventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1200;

    return Scaffold(
      body: Stack(
        children: [
          // Cosmic Background with Particles
          Positioned.fill(
            child: Stack(
              children: [
                 Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color.fromARGB(255, 0, 0, 0), Color.fromARGB(255, 17, 0, 35)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const ParticleField(),
          ),
                 CosmicBackground(),
                const ParticleField(),
              ],
            ),
          ),

          CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: isMobile ? 200 : 300,
                collapsedHeight: isMobile ? 80 : 100,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    children: [
                      const _TechnicalAnimatedBackground(),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: 'DIKSHA 25'.split('').map((char) => 
                                _AnimatedTechLetter(character: char)
                              ).toList(),
                            ),
                            const SizedBox(height: 15),
                            _AnimatedTechSubtitle(),
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
                    title: "TECHNICAL EVENTS",
                    gradient: const [Color.fromARGB(255, 238, 119, 0), Color.fromARGB(255, 238, 119, 0)],
                  ),
                ),
              ),

              SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isMobile ? 1 : isTablet ? 2 : 3,
                  mainAxisExtent: isMobile ? 400 : 450,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 30,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) => _buildTechEventCard(index),
                  childCount: 13, // Number of events
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTechEventCard(int index) {
    // Your event data here
   final events = [
  {
    'name': 'Techtonic Trivia',
    'coordinator': 'Navaneeth V ',
    'contact': '+91 70345 72136',
    'image': 'assets/images/diksha/quiz.jpg',
    'date': '08-04-25',
    'registration': '50 Rs /-',
    'price': '500 Rs /-',
    'icon': Icons.question_mark,
    'color': Colors.blue,
    'link': 'https://tiqr.events/e/TECHTONIC-TRIVIA-1154',
  },
  {
    'name': 'GPT Web Crusader',
    'coordinator': 'Aaesha VV',
    'contact': '+91 92075 52662',
    'image': 'assets/images/diksha/gpt.jpg',
    'date': '09-04-25',
    'registration': '50 Rs /-',
    'price': '500 Rs /-',
    'icon': Icons.smart_toy,
    'color': Colors.green,
    'link': 'https://tiqr.events/e/GPT-WEB-CRUSADER-1146',
  },
  {
    'name': 'Poster Making Competition',
    'coordinator': 'Nijin Raj',
    'contact': '+91 94965 59841',
    'image': 'assets/images/diksha/postermaking.jpg',
    'date': '09-04-25',
    'registration': '100 Rs /-',
    'price': '1000 Rs /-',
    'icon': Icons.brush,
    'color': Colors.deepPurple,
    'link': 'https://tiqr.events/e/POSTER-MAKING-1140',
  },
  {
    'name': 'Code War',
    'coordinator': 'Nashwan bin Niyaz',
    'contact': '+91 70125 70023',
    'image': 'assets/images/diksha/codewar.jpg',
    'date': '09-04-25',
    'registration': '50 Rs /-',
    'price': '500 Rs /-',
    'icon': Icons.code,
    'color': Colors.lightBlue,
    'link': 'https://tiqr.events/e/CODE-WAR-1145',
  },
  {
    'name': 'CAD War',
    'coordinator': 'ABHINAV . P',
    'contact': '+91 90619 61650',
    'image': 'assets/images/diksha/cadwar.jpg',
    'date': '09-04-25',
    'registration': '50 Rs /-',
    'price': '500 Rs /-',
    'icon': Icons.design_services,
    'color': Colors.lime,
    'link': 'https://tiqr.events/e/CAD-WAR-1157',
  },
  {
    'name': 'Colour Mixing',
    'coordinator': 'Vishnu',
    'contact': '+91  97781 21196',
    'image': 'assets/images/diksha/colormixing.jpg',
    'date': '11-04-25',
    'registration': '150 Rs /-',
    'price': '1000 Rs /-',
    'icon': Icons.color_lens,
    'color': Colors.pinkAccent,
    'link': 'https://tiqr.events/e/COLOR-MIXING-1139',
  },
  {
    'name': 'Circuit Debugging',
    'coordinator': 'Abhinand',
    'contact': '+91 88482 39646',
    'image': 'assets/images/diksha/circuitdebugging.jpg',
    'date': '11-04-25',
    'registration': '50 Rs /-',
    'price': '500 Rs /-',
    'icon': Icons.memory,
    'color': Colors.teal,
    'link': 'https://tiqr.events/e/CODE-DEBUGGING-1156',
  },
  {
    'name': 'Project Presentation',
    'coordinator': 'Navas ',
    'contact': '+91 97449 33891',
    'image': 'assets/images/diksha/project.jpg',
    'date': '11-04-25',
    'registration': 'Free',
    'price': 'TBA ',
    'icon': Icons.present_to_all,
    'color': Colors.indigo,
    'link': 'https://tiqr.events/e/PROJECT-PRESENTATION-1155',
  },
  {
    'name': 'Circuit Decoding',
    'coordinator': 'Mohd Nishmal',
    'contact': '+91 95629 21958',
    'image': 'assets/images/diksha/circuitdecoding.jpg',
    'date': '11-04-25',
    'registration': '50 Rs /-',
    'price': '500 Rs /-',
    'icon': Icons.electrical_services,
    'color': Colors.amber,
    'link': 'https://tiqr.events/e/CIRCUITa-DECODING-1153',
  },
  {
    'name': 'Ideathon',
    'coordinator': 'Amal',
    'contact': '+91 90371 64629',
    'image': 'assets/images/diksha/ideathon.jpg',
    'date': '11-04-25',
    'registration': 'Free',
    'price': '3000 Rs /-',
    'icon': Icons.lightbulb,
    'color': Colors.deepOrange,
    'link': 'https://www.instagram.com/diksha_iet?igsh=MWR5cWJieXFvdTBiMQ==',
  },
  {
    'name': 'Robo War',
    'coordinator': 'Kavya',
    'contact': '+91 81290 07588',
    'image': 'assets/images/diksha/robowar.jpg',
    'date': '12-04-25',
    'registration': '250Rs /-',
    'price': '5000 Rs /-',
    'icon': Icons.rocket_launch,
    'color': Colors.cyan,
    'link': 'https://tiqr.events/e/ROBO-WAR-1144',
  },
  {
    'name': 'Line Follower',
    'coordinator': 'Nivedhya',
    'contact': '+91 97471 66096',
    'image': 'assets/images/diksha/linefollower.jpg',
    'date': '12-04-25',
    'registration': '150 Rs /-',
    'price': '2000 Rs /-',
    'icon': Icons.directions_car,
    'color': Colors.orange,
    'link': 'https://tiqr.events/e/LINE-FOLLOWER-1142',
  },
  {
    'name': 'Robo Tug of War',
    'coordinator': 'Heera Suresh M',
    'contact': '+91 90481 87462',
    'image': 'assets/images/diksha/tugofwar.jpg',
    'date': '12-04-25',
    'registration': '150 Rs /-',
    'price': '2000 Rs /-',
    'icon': Icons.handshake,
    'color': Colors.redAccent,
    'link': 'https://tiqr.events/e/ROBO-TUG-OF-WAR-1137',
  },
];


  return HolographicCardTech(
  image: events[index % events.length]['image'] as String? ?? '',
  title: events[index % events.length]['name'] as String? ?? '',
  date: events[index % events.length]['date'] as String? ?? '', // fallback
  price: events[index % events.length]['price'] as String? ?? '',
  coordinator: events[index % events.length]['coordinator'] as String? ?? '',
  contact: events[index % events.length]['contact'] as String? ?? '',
  registration: events[index % events.length]['registration'] as String? ?? '',
  icon: events[index % events.length]['icon'] as IconData? ?? Icons.info,
  color: events[index % events.length]['color'] as Color? ?? Colors.grey,
   link: events[index % events.length]['link'] as String? ?? '',
);

  }

  LinearGradient _getTechGradient(int index) {
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
}

class _AnimatedTechLetter extends StatefulWidget {
  final String character;

  const _AnimatedTechLetter({required this.character});

  @override
  __AnimatedTechLetterState createState() => __AnimatedTechLetterState();
}

class __AnimatedTechLetterState extends State<_AnimatedTechLetter> 
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _colorAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.4).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut)
    );
    
    _colorAnimation = ColorTween(
      begin: const Color(0xFF00F2FE),
      end: const Color(0xFFFE53BB),
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleHover(bool hovering) {
    setState(() => _isHovered = hovering);
    hovering ? _controller.forward() : _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _handleHover(true),
      onExit: (_) => _handleHover(false),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform(
            transform: Matrix4.identity()
              ..scale(_scaleAnimation.value)
              ..rotateZ(_isHovered ? 0.1 : 0),
            child: Text(
              widget.character,
            style: TextStyle(
                  fontFamily: 'Orbitron',
                fontSize: 42,
                shadows: [
                  Shadow(
                    color: _colorAnimation.value!.withOpacity(0.8),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
                foreground: Paint()
                  ..shader = LinearGradient(
                    colors: [
                      _colorAnimation.value!,
                      const Color.fromARGB(255, 238, 119, 0),
                    ],
                    stops: const [0.3, 0.7],
                  ).createShader(const Rect.fromLTWH(0, 0, 100, 100)),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _AnimatedTechSubtitle extends StatefulWidget {
  @override
  __AnimatedTechSubtitleState createState() => __AnimatedTechSubtitleState();
}

class __AnimatedTechSubtitleState extends State<_AnimatedTechSubtitle>
    with SingleTickerProviderStateMixin {
  late AnimationController _glitchController;
  final Random _random = Random();
  double _offsetX = 0;
  double _offsetY = 0;
  double _cyanOpacity = 0;
  double _pinkOpacity = 0;

  @override
  void initState() {
    super.initState();
    _glitchController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 80),
    )..addListener(() {
        setState(() {
          _offsetX = (_random.nextDouble() - 0.5) * 4;
          _offsetY = (_random.nextDouble() - 0.5) * 2;
          _cyanOpacity = _random.nextDouble() > 0.9 ? 1.0 : 0.0;
          _pinkOpacity = _random.nextDouble() > 0.9 ? 1.0 : 0.0;
        });
      })..repeat();
  }

  @override
  void dispose() {
    _glitchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Transform.translate(
          offset: Offset(_offsetX, _offsetY),
          child: Text(
            "Technical Showcase",
            style: TextStyle(
              fontFamily: "Orbitron",
              fontSize: 18,
              color: Colors.white,
              letterSpacing: 4,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Transform.translate(
          offset: Offset(_offsetX + 2, _offsetY - 1),
          child: Opacity(
            opacity: _cyanOpacity,
            child: Text(
              "Technical Showcase",
              style: TextStyle(
                fontFamily: "Orbitron",
                fontSize: 18,
                color: Color(0xFF09FBD3),
                letterSpacing: 4,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Transform.translate(
          offset: Offset(_offsetX - 2, _offsetY + 1),
          child: Opacity(
            opacity: _pinkOpacity,
            child: Text(
              "Technical Showcase",
              style: TextStyle(
                fontFamily: "Orbitron",
                fontSize: 18,
                color: Color(0xFFFE53BB),
                letterSpacing: 4,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _TechnicalAnimatedBackground extends StatefulWidget {
  const _TechnicalAnimatedBackground();

  @override
  __TechnicalAnimatedBackgroundState createState() =>
      __TechnicalAnimatedBackgroundState();
}

class __TechnicalAnimatedBackgroundState extends State<_TechnicalAnimatedBackground>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late AnimationController _imageController;
  late Animation<double> _imageOpacityAnimation;
  late Animation<Alignment> _imageAlignmentAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat(reverse: true);
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _imageController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..forward();
    _imageOpacityAnimation = Tween<double>(begin: 0.0, end: 0.7).animate(
      CurvedAnimation(
        parent: _imageController,
        curve: Curves.easeIn,
      ),
    );
    _imageAlignmentAnimation = Tween<Alignment>(
      begin: const Alignment(0.5, 0.6),
      end: Alignment.center,
    ).animate(
      CurvedAnimation(
        parent: _imageController,
        curve: Curves.easeOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return AnimatedBuilder(
          animation: _imageController,
          builder: (context, child) {
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage('assets/images/diksha/tech.png'),
                  fit: BoxFit.cover,
                  opacity: _imageOpacityAnimation.value,
                  alignment: _imageAlignmentAnimation.value,
                ),
                gradient: RadialGradient(
                  colors: const [
                    Color(0xFF1A1A2E),
                    Color(0xFF16213E),
                  ].map((color) => color.withOpacity(0.8)).toList(),
                  radius: _animation.value * 2 + 0.5,
                  center: Alignment(0.5, _animation.value - 0.5),
                  stops: const [0.3, 0.9],
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.6),
                      Colors.transparent,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
