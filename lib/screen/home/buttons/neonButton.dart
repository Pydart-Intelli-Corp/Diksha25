
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NeonButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String label;
  final Color glowColor;

  const NeonButton({
    super.key,
    required this.onPressed,
    required this.label,
    required this.glowColor,
  });

  @override
  State<NeonButton> createState() => _NeonButtonState();
}

class _NeonButtonState extends State<NeonButton> 
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: widget.glowColor.withOpacity(_controller.value * 0.5),
                blurRadius: 15,
                spreadRadius: 2,
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: widget.onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black.withOpacity(0.3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(color: widget.glowColor, width: 2),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: Text(widget.label,
                style: TextStyle(
                  fontFamily: 'Orbitron',
                  fontSize: 16,
                  color: widget.glowColor,
                  fontWeight: FontWeight.bold,
                )),
          ),
        );
      },
    );
  }
}