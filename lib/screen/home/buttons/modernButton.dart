import 'package:flutter/material.dart';
import 'package:flutter_website/components/colors.dart';
import 'package:flutter_website/core/extensions/color_extensions.dart';

class ModernButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final String label;
  final Gradient? gradient;
  final Gradient? hoverGradient;
  final double width;
  final double height;
  final IconData? icon;

  const ModernButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.gradient,
    this.hoverGradient,
    this.width = 200,
    this.height = 50,
    this.icon,
  });

  @override
  State<ModernButton> createState() => _ModernButtonState();
}

class _ModernButtonState extends State<ModernButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _handleHover(true),
      onExit: (_) => _handleHover(false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            gradient: _isHovered 
                ? (widget.hoverGradient ?? _defaultHoverGradient)
                : (widget.gradient ?? _defaultGradient),
            borderRadius: BorderRadius.circular(15),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: AppColors.diksha.withOpacity(0.4),
                      blurRadius: 20,
                      spreadRadius: 2,
                      offset: const Offset(0, 4),
                    )
                  ]
                : null,
          ),
          child: ScaleTransition(
            scale: Tween(begin: 1.0, end: 0.95).animate(
              CurvedAnimation(
                parent: _controller,
                curve: Curves.easeOut,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.icon != null) ...[
                  Icon(
                    widget.icon,
                    color: Colors.white,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                ],
                Text(
                  widget.label,
                  style: TextStyle(
                    fontFamily: 'Orbitron',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleHover(bool isHovered) {
    setState(() => _isHovered = isHovered);
    if (isHovered) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  final Gradient _defaultGradient = LinearGradient(
    colors: [
      AppColors.diksha,
      AppColors.secondary,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  final Gradient _defaultHoverGradient = LinearGradient(
    colors: [
      AppColors.secondary,
      AppColors.diksha,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}