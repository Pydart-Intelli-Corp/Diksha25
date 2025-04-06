import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

class TechFestHero extends StatefulWidget {
  const TechFestHero({super.key});

  @override
  State<TechFestHero> createState() => _TechFestHeroState();
}

class _TechFestHeroState extends State<TechFestHero>
    with TickerProviderStateMixin {
  late VideoPlayerController _controller;
  final Random _random = Random();
  late AnimationController _gridController;
  final List<bool> _letterHovered =
      List.generate('DIKSHAVERSE'.length, (_) => false);
  final List<AnimationController> _letterControllers = [];
final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller =
        VideoPlayerController.asset('assets/videos/diksha/block1bg.mp4')
          ..initialize().then((_) {
            _controller.setVolume(0);
            _controller.setLooping(true);
            _controller.play();
          });

    _gridController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    for (int i = 0; i < 'DIKSHAVERSE'.length; i++) {
      _letterControllers.add(AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
      ));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _gridController.dispose();
    for (var controller in _letterControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  List<Widget> _buildParticles(int count) {
    return List.generate(count, (index) {
      final size = _random.nextDouble() * 8 + 4;
      return Positioned(
        left: _random.nextDouble() * MediaQuery.of(context).size.width,
        top: _random.nextDouble() * MediaQuery.of(context).size.height,
        child: AnimatedBuilder(
          animation: _gridController,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, sin(_gridController.value * 2 * pi) * 20),
              child: Transform.rotate(
                angle: _gridController.value * 2 * pi,
                child: Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    color: Colors
                        .accents[_random.nextInt(Colors.accents.length)]
                        .withOpacity(0.3),
                    shape: _random.nextBool()
                        ? BoxShape.circle
                        : BoxShape.rectangle,
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }

  Widget _buildTitleLetter(int index, String letter, bool isMobile) {
    // For the first letter "D", use the PNG logo instead.
    if (index == 0 && letter == 'D') {
      return MouseRegion(
        onEnter: (_) => setState(() {
          _letterHovered[index] = true;
          _letterControllers[index].forward();
        }),
        onExit: (_) => setState(() {
          _letterHovered[index] = false;
          _letterControllers[index].reverse();
        }),
        child: AnimatedBuilder(
          animation: _letterControllers[index],
          builder: (context, child) {
            final double animationValue = _letterControllers[index].value;
            final Matrix4 transform = Matrix4.identity()
              ..rotateZ(0.05 * animationValue)
              ..scale(1 + 0.1 * animationValue);

            // Optionally, you can compute gradient colors if you want to blend the logo.
            // For a logo, you might simply change opacity or add a shadow.
      return Transform.translate(
        offset: const Offset(0, -5), // ← move up by 10px
        child: Transform(
          transform: transform,
          alignment: Alignment.center,
          child: Image.asset(
            'assets/logos/diksha/dikshalogoyellownoletter.png',
            width: isMobile ? 50 : 90,
            height: isMobile ? 40 : 80,
          ),
        ),
      );
    },
        ),
      );
    } else {
      // Default behavior for other letters.
      return MouseRegion(
        onEnter: (_) => setState(() {
          _letterHovered[index] = true;
          _letterControllers[index].forward();
        }),
        onExit: (_) => setState(() {
          _letterHovered[index] = false;
          _letterControllers[index].reverse();
        }),
        child: AnimatedBuilder(
          animation: _letterControllers[index],
          builder: (context, child) {
            final double animationValue = _letterControllers[index].value;
            final Matrix4 transform = Matrix4.identity()
              ..rotateZ(0.05 * animationValue)
              ..scale(1 + 0.1 * animationValue);

            final List<Color> gradientColors = [
              Color.lerp(Colors.blueAccent, Colors.tealAccent, animationValue)!,
              Color.lerp(Colors.purpleAccent,
                  const Color.fromARGB(255, 216, 219, 40), animationValue)!,
            ];

            return Transform(
              transform: transform,
              alignment: Alignment.center,
              child: Text(
                letter,
                style: TextStyle(
                fontFamily: "Orbitron",
                  fontSize: isMobile ? 40 : 80,
                  fontWeight: FontWeight.w900,
                  foreground: Paint()
                    ..shader = LinearGradient(
                      colors: gradientColors,
                    ).createShader(const Rect.fromLTWH(0, 0, 100, 100)),
                  shadows: [
                    Shadow(
                      color: Colors.cyanAccent
                          .withOpacity(0.5 + 0.5 * animationValue),
                      blurRadius: 10 + 20 * animationValue,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;

    return SizedBox(
      width: size.width,
      height: size.height,
      child: Stack(
        children: [
          // Background Video with Color Filter
          ColorFiltered(
            colorFilter: const ColorFilter.matrix([
              0.5,
              0.0,
              0.0,
              0.0,
              0.0,
              0.0,
              0.5,
              0.0,
              0.0,
              0.0,
              0.0,
              0.0,
              1.0,
              0.0,
              0.0,
              0.0,
              0.0,
              0.0,
              1.0,
              0.0,
            ]),
            child: SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: _controller.value.isInitialized
                    ? SizedBox(
                        width: _controller.value.size.width,
                        height: _controller.value.size.height,
                        child: VideoPlayer(_controller),
                      )
                    : Container(color: Colors.black),
              ),
            ),
          ),

          // Animated Grid
          AnimatedBuilder(
            animation: _gridController,
            builder: (context, child) {
              return CustomPaint(
                painter: _AnimatedGridPainter(
                  animationValue: _gridController.value,
                ),
              );
            },
          ),

          // Floating Particles
          ..._buildParticles(100),

          // Floating Shapes
          ...List.generate(20, (index) {
            return Positioned(
              left: _random.nextDouble() * size.width,
              top: _random.nextDouble() * size.height,
              child: AnimatedBuilder(
                animation: _gridController,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(
                      20 * sin(_gridController.value * 2 * pi + index),
                      20 * cos(_gridController.value * 2 * pi + index),
                    ),
                    child: Transform.rotate(
                      angle: _gridController.value * 2 * pi,
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.accents[index % Colors.accents.length]
                                .withOpacity(0.5),
                            width: 2,
                          ),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }),

// In your build method, inside the Title Section Column, update as follows:
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                isMobile ? 20 : 50,
                isMobile ? 50 : 100,
                isMobile ? 20 : 50,
                0,
              ),
               child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'INTO THE',
                    style: TextStyle(
                fontFamily: "Orbitron",
                      fontSize: isMobile ? 24 : 36,
                      fontWeight: FontWeight.w300,
                      color: Colors.white.withOpacity(0.8),
                      letterSpacing: 4,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: 'DIKSHAVERSE'
                        .split('')
                        .asMap()
                        .entries
                        .map((entry) =>
                            _buildTitleLetter(entry.key, entry.value, isMobile))
                        .toList(),
                  ),
                  const SizedBox(height: 20),
_AnimatedSubtitle(),
                  SizedBox(height: size.height * 0.04),
                
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class _HolographicButton extends StatefulWidget {
  final VoidCallback onPressed;
  final double width;

  const _HolographicButton({required this.onPressed, required this.width});

  @override
  State<_HolographicButton> createState() => _HolographicButtonState();
}

class _HolographicButtonState extends State<_HolographicButton>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
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
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, sin(_controller.value * 2 * pi) * 5),
            child: Container(
              width: widget.width,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: RadialGradient(
                  colors: [
                    Colors.cyanAccent.withOpacity(0.5),
                    Colors.purpleAccent.withOpacity(0.5),
                  ],
                  radius: 1.5,
                ),
                border: Border.all(
                  color: Colors.white
                      .withOpacity(0.5 + 0.3 * sin(_controller.value * 2 * pi)),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueAccent.withOpacity(0.5),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                  BoxShadow(
                    color: Colors.purpleAccent.withOpacity(0.5),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(),
                      ),
                    ),
                  ),
                  Center(
                   child: Text(
                      'EXPLORE NOW',
                      style: TextStyle(
                fontFamily: "Orbitron",
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 4,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 10,
                          ),
                        ],
                      ),
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
}

class _AnimatedGridPainter extends CustomPainter {
  final double animationValue;

  _AnimatedGridPainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..strokeWidth = 1;

    final animatedPaint = Paint()
      ..color =
          Colors.cyanAccent.withOpacity(sin(animationValue * pi * 2) * 0.3)
      ..strokeWidth = 2;

    for (double i = 0; i < size.width; i += 40) {
      canvas.drawLine(
        Offset(i, size.height * animationValue),
        Offset(i, size.height * (1 - animationValue)),
        i % 80 == 0 ? animatedPaint : paint,
      );
    }

    for (double j = 0; j < size.height; j += 40) {
      canvas.drawLine(
        Offset(size.width * animationValue, j),
        Offset(size.width * (1 - animationValue), j),
        j % 80 == 0 ? animatedPaint : paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
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
    )..addListener(() {
        setState(() {
          _offsetX = (_random.nextDouble() - 0.5) * 4;
          _offsetY = (_random.nextDouble() - 0.5) * 2;
          _redOpacity = _random.nextDouble() > 0.9 ? 1.0 : 0.0;
          _blueOpacity = _random.nextDouble() > 0.9 ? 1.0 : 0.0;
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
            "TECHNICAL AND CULTURAL FEST",
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
              "TECHNICAL AND CULTURAL FEST",
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
              "TECHNICAL AND CULTURAL FEST",
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