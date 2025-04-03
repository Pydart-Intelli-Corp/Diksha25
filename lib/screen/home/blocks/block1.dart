import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_website/screen/Home/blocks/HeaderBlock.dart';
import 'package:video_player/video_player.dart';

class TechFestHero extends StatefulWidget {
  const TechFestHero({super.key});

  @override
  State<TechFestHero> createState() => _TechFestHeroState();
}

class _TechFestHeroState extends State<TechFestHero> {
  late VideoPlayerController _controller;
  final List<String> _navItems = ['Home', 'Events', 'Gallery', 'Contact'];
  int _hoverIndex = -1;

  @override
  void initState() {
    super.initState();
  _controller = VideoPlayerController.asset('assets/videos/diksha/block1bg.mp4')
      ..initialize().then((_) {
        _controller.setVolume(0);
        _controller.setLooping(true); // Loop the video.
        _controller.play();
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Stack(
        children: [
          // Background Video
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: _controller.value.isInitialized
                  ? SizedBox(
                      width: _controller.value.size.width,
                      height: _controller.value.size.height,
                      child: VideoPlayer(_controller),
                    )
                  : Container(color: Colors.black), // Fallback until video loads.
            ),
          ),

          // Gradient Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.6),
                  Colors.transparent,
                  Colors.black.withOpacity(0.6)
                ],
                stops: const [0.0, 0.5, 1.0],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),


          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Colors.purpleAccent, Colors.blueAccent],
                  ).createShader(bounds),
                  child: Text(
                    'TECHNOVATE',
                    style: TextStyle(
                      fontSize: 80,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Orbitron',
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Where Innovation Meets Reality',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 24,
                    letterSpacing: 3,
                    shadows: [
                      Shadow(
                        color: Colors.purpleAccent,
                        blurRadius: 10,
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 18,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: const LinearGradient(
                        colors: [Colors.purpleAccent, Colors.blueAccent],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.purpleAccent.withOpacity(0.4),
                          blurRadius: 20,
                          spreadRadius: 3,
                        )
                      ],
                    ),
                    child: const Text(
                      'REGISTER NOW',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HoverButton extends StatefulWidget {
  final bool isHovered;
  final Function(bool) onHover;
  final Widget child;

  const HoverButton({
    required this.child,
    required this.onHover,
    required this.isHovered,
    super.key,
  });

  @override
  State<HoverButton> createState() => _HoverButtonState();
}

class _HoverButtonState extends State<HoverButton> {
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => widget.onHover(true),
      onExit: (_) => widget.onHover(false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: widget.isHovered ? Colors.purpleAccent : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: widget.child,
      ),
    );
  }
}
