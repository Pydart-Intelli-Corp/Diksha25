import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_website/screen/Home/cards/holographicCard.dart';
import 'package:flutter_website/screen/Home/particles/culturalParticles.dart';
import 'dart:math';

import 'package:flutter_website/ui/blocks/common/footer.dart';


class CulturalEventsScreen extends StatelessWidget {
  const CulturalEventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1200;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 0, 0, 0),
                  Color.fromARGB(255, 17, 0, 35)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const ParticleField(),
          ),
          CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: isMobile ? 200 : 300,
                collapsedHeight: isMobile ? 80 : 100,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    children: [
                      const _AnimatedGradientBackground(),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: 'DIKSHA\'25'
                                  .split('')
                                  .map((char) =>
                                      _AnimatedLetter(character: char))
                                  .toList(),
                            ),
                            const SizedBox(height: 15),
                            _AnimatedSubtitle(),
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
                    gradient: const [
                      Color.fromARGB(255, 229, 255, 0),
                      Color.fromARGB(255, 3, 67, 56)
                    ],
                  ),
                ),
              ),
              SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isMobile
                      ? 1
                      : isTablet
                          ? 2
                          : 3,
                  mainAxisExtent: isMobile ? 400 : 450,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 30,
                ),
                delegate: SliverChildListDelegate([
                  const HolographicCard(
                    image: 'assets/images/diksha/fejo.webp',
                    title: "FEJO LIVE",
                    date: "April 12th",
                    price: "₹2999",
                    link: 'https://tiqr.events/e/PROSHOW-TICKETS-1119',
                  ),
                  const HolographicCard(
                    image: 'assets/images/diksha/gabri.webp',
                    title: "GABRI LIVE",
                    date: "April 12th",
                    price: "₹3499",
                    link: 'https://tiqr.events/e/PROSHOW-TICKETS-1119',
                  ),
                  const HolographicCard(
                    image: 'assets/images/diksha/zeropause.webp',
                    title: "ZEROPAUSE LIVE",
                    date: "April 11th",
                    price: "₹2499",
                    link: 'https://tiqr.events/e/PROSHOW-TICKETS-1119',
                  ),
                ]),
              ),
              SliverToBoxAdapter(
                child: ResponsivePadding(
                  child: SectionHeader(
                    title: "Other events will be update soon..",
                    gradient: const [
                      Color.fromARGB(255, 229, 255, 0),
                      Color.fromARGB(255, 3, 67, 56)
                    ],
                  ),
                ),
              ),
              SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isMobile
                      ? 1
                      : isTablet
                          ? 2
                          : 3,
                  mainAxisExtent: isMobile ? 400 : 450,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 30,
                ),
                delegate: SliverChildListDelegate([
                  // Uncomment and add cards when available
                  // const HolographicCardNoButton(
                  //   image: 'assets/images/diksha/fejo.webp',
                  //   title: "FEJO LIVE",
                  //   date: "April 12th",
                  //   price: "₹2999",
                  // ),
                  // const HolographicCardNoButton(
                  //   image: 'assets/images/diksha/gabri.webp',
                  //   title: "GABRI LIVE",
                  //   date: "April 12th",
                  //   price: "₹3499",
                  // ),
                  // const HolographicCardNoButton(
                  //   image: 'assets/images/diksha/zeropause.webp',
                  //   title: "ZEROPAUSE LIVE",
                  //   date: "April 11th",
                  //   price: "₹2499",
                  // ),
                ]),
              ),
              // Optional spacing before footer
              const SliverToBoxAdapter(child: SizedBox(height: 50)),
              // Add the footer at the bottom
              const SliverToBoxAdapter(child: FooterBlock()),
            ],
          ),
        ],
      ),
    );
  }
}

// The rest of your animated widgets and other classes follow...

class _AnimatedLetter extends StatefulWidget {
  final String character;

  const _AnimatedLetter({required this.character});

  @override
  __AnimatedLetterState createState() => __AnimatedLetterState();
}

class __AnimatedLetterState extends State<_AnimatedLetter>
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
        CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    _colorAnimation = ColorTween(
      begin: const Color(0xFF6A48D7),
      end: const Color(0xFFE94560),
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
                      const Color.fromARGB(255, 225, 245, 0),
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

class _AnimatedSubtitle extends StatefulWidget {
  @override
  __AnimatedSubtitleState createState() => __AnimatedSubtitleState();
}

class __AnimatedSubtitleState extends State<_AnimatedSubtitle>
    with SingleTickerProviderStateMixin {
  late AnimationController _glitchController;
  final Random _random = Random();
  double _offsetX = 0;
  double _offsetY = 0;
  double _redOpacity = 0;
  double _blueOpacity = 0;

  @override
  void initState() {
    super.initState();
    _glitchController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 80),
    )
      ..addListener(() {
        setState(() {
          _offsetX = (_random.nextDouble() - 0.5) * 4;
          _offsetY = (_random.nextDouble() - 0.5) * 2;
          _redOpacity = _random.nextDouble() > 0.9 ? 1.0 : 0.0;
          _blueOpacity = _random.nextDouble() > 0.9 ? 1.0 : 0.0;
        });
      })
      ..repeat();
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
            "Cultural Events",
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
            opacity: _redOpacity,
            child: Text(
              "Cultural Events",
              style: TextStyle(
                fontFamily: "Orbitron",
                fontSize: 18,
                color: Colors.red,
                letterSpacing: 4,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Transform.translate(
          offset: Offset(_offsetX - 2, _offsetY + 1),
          child: Opacity(
            opacity: _blueOpacity,
            child: Text(
              "Cultural Events",
              style: TextStyle(
                fontFamily: "Orbitron",
                fontSize: 18,
                color: Colors.blue,
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

class _AnimatedGradientBackground extends StatefulWidget {
  const _AnimatedGradientBackground();

  @override
  __AnimatedGradientBackgroundState createState() =>
      __AnimatedGradientBackgroundState();
}

class __AnimatedGradientBackgroundState
    extends State<_AnimatedGradientBackground> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  // New controllers for image animation
  late AnimationController _imageController;
  late Animation<double> _imageOpacityAnimation;
  late Animation<Alignment> _imageAlignmentAnimation;

  @override
  void initState() {
    super.initState();
    // Existing gradient animation setup
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat(reverse: true);
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    // New image animation setup
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
      begin: const Alignment(0.5, 0.6), // Start slightly lower
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
    _imageController.dispose(); // Dispose image controller
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
                  image: const AssetImage('assets/images/diksha/cult.webp'),
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
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: ShaderMask(
        shaderCallback: (bounds) => LinearGradient(
          colors: gradient,
        ).createShader(bounds),
        child: Text(title,
            style: TextStyle(
              fontFamily: "Orbitron",
              fontSize: isMobile ? 24 : 32,
              letterSpacing: 4,
              color: const Color.fromARGB(255, 226, 216, 15),
              fontWeight: FontWeight.bold,
            )),
      ),
    );
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
        horizontal: screenWidth > 1200
            ? 100
            : screenWidth > 800
                ? 60
                : screenWidth > 600
                    ? 40
                    : 20,
        vertical: 20,
      ),
      child: child,
    );
  }
}

class NeonGlow extends StatelessWidget {
  const NeonGlow({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: CustomPaint(
        painter: _NeonGridPainter(),
      ),
    );
  }
}

class _NeonGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF00F2FE).withOpacity(0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

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
