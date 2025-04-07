import 'package:flutter/material.dart';
import 'package:flutter_website/components/colors.dart';
import 'package:flutter_website/core/extensions/color_extensions.dart';
import 'package:url_launcher/url_launcher.dart';

class FooterBlock extends StatefulWidget {
  const FooterBlock({super.key});

  @override
  State<FooterBlock> createState() => _FooterBlockState();
}

class _FooterBlockState extends State<FooterBlock> {
  bool _isHovered = false;
  final Map<String, bool> _hoverStates = {
    'instagram': false,
    'facebook': false,
    'twitter': false,
  };

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.black.withOpacity(0.97),
            Colors.black.withOpacity(0.95),
          ],
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 60,
              horizontal: isMobile ? 24 : 120,
            ),
            child: isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
          ),
          _buildBottomBar(isMobile),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildLogoSection(),
            _buildLinksSection(),
            _buildContactSection(),
          ],
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLogoSection(),
        const SizedBox(height: 40),
        _buildLinksSection(),
        const SizedBox(height: 40),
        _buildContactSection(),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildLogoSection() {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: _isHovered
              ? LinearGradient(
                  colors: [
                    AppColors.diksha.withOpacity(0.1),
                    Colors.transparent
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              "assets/logos/diksha/dikshalogoyellow.png",
              width: 180,
              height: 180,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 300),
              style: TextStyle(
                fontSize: 14,
                color: Colors.white54,
                fontWeight: _isHovered ? FontWeight.w600 : FontWeight.normal,
              ),
              child: const Text("Technical and Cultural Fest"),
            ),
            const SizedBox(height: 30),
            _buildPoweredBy(),
          ],
        ),
      ),
    );
  }

  Widget _buildPoweredBy() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Powered by",
          style: TextStyle(
            color: Colors.white54,
            fontSize: 12,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: _isHovered ? 1 : 0.8,
          child: Image.asset(
            "assets/logos/pydart.png",
            width: 200,
            height: 150,
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }

  Widget _buildLinksSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle("Quick Links"),
        const SizedBox(height: 20),
        _buildAnimatedLink("Technical Events", Icons.code,
            "https://www.dikshaiet.com/technical-events"),
        _buildAnimatedLink("Cultural Events", Icons.celebration,
            "https://www.dikshaiet.com/cultural-events"),
        _buildAnimatedLink("Event Location", Icons.location_on,
            "https://maps.app.goo.gl/Uv235erdEiFE4trC7?g_st=awb"),
      ],
    );
  }

  Widget _buildContactSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle("Contact Us"),
        const SizedBox(height: 20),
        _buildContactItem(Icons.email, "diksha25iet@gmail.com",
            () => _launchUrl('mailto:diksha25iet@gmail.com')),
        _buildContactItem(Icons.phone, "+91 73061 24112",
            () => _launchUrl('tel:+917306124112')),
        _buildContactItem(Icons.language, "www.dikshaiet.com",
            () => _launchUrl('https://dikshaiet.com')),
      ],
    );
  }

  Widget _buildSectionTitle(String text) {
    return Text(
      text,
      style: TextStyle(
        color: AppColors.diksha,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _buildAnimatedLink(String text, IconData icon, String url) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        hoverColor: Colors.transparent,
        onTap: () => _launchUrl(url),
        onHover: (hovering) => setState(() => _isHovered = hovering),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: _isHovered ? AppColors.diksha : Colors.transparent,
                width: 1.5,
              ),
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            children: [
              Icon(icon, size: 18, color: Colors.white70),
              const SizedBox(width: 12),
              Text(
                text,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String text, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: onTap,
        hoverColor: AppColors.diksha.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(icon, size: 18, color: Colors.white70),
              const SizedBox(width: 12),
              Text(
                text,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomBar(bool isMobile) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.white.withOpacity(0.1))),
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          _buildSocialIcons(),
          const SizedBox(height: 20),
          Text(
            '© 2024 Diksha25. All rights reserved',
            style: TextStyle(
              color: Colors.white54,
              fontSize: 12,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Website Credits: Pydart Intelli Corp',
            style: TextStyle(
              color: Colors.white54,
              fontSize: 12,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialIcon('assets/logos/diksha/insta.png', 'instagram',
            'https://www.instagram.com/diksha_iet?igsh=dXQ4ajJkbHBiMG8='),
        const SizedBox(width: 20),
        _buildSocialIcon(
            'assets/logos/diksha/fb.png', 'facebook', 'https://facebook.com'),
        const SizedBox(width: 20),
        _buildSocialIcon(
            'assets/logos/diksha/x.png', 'twitter', 'https://x.com'),
      ],
    );
  }

  Widget _buildSocialIcon(String asset, String key, String url) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hoverStates[key] = true),
      onExit: (_) => setState(() => _hoverStates[key] = false),
      child: GestureDetector(
        onTap: () => _launchUrl(url),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: _hoverStates[key]!
                ? LinearGradient(
                    colors: [
                      AppColors.diksha.withOpacity(0.3),
                      Colors.transparent,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
          ),
          child: AnimatedScale(
            duration: const Duration(milliseconds: 200),
            scale: _hoverStates[key]! ? 1.2 : 1.0,
            child: Image.asset(
              asset,
              width: 24,
              height: 24,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}
