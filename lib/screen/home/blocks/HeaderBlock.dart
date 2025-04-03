import 'dart:ui';
import 'package:flutter/material.dart';

class HeaderBlock extends StatefulWidget {
  const HeaderBlock({super.key});

  @override
  State<HeaderBlock> createState() => _HeaderBlockState();
}

class _HeaderBlockState extends State<HeaderBlock> {
  int _selectedIndex = 0;
  bool _isMenuOpen = false;
  final List<String> _navItems = ['Home', 'Events', 'Gallery', 'Contact us'];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1024;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  width: _getContainerWidth(screenWidth),
                  height: _getContainerHeight(isMobile, isTablet),
                  decoration: _buildBoxDecoration(),
                  child: _buildResponsiveLayout(isMobile, isTablet),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  double _getContainerWidth(double screenWidth) {
    if (screenWidth < 600) return screenWidth * 0.95;
    if (screenWidth < 1024) return screenWidth * 0.9;
    return 1200;
  }

  double _getContainerHeight(bool isMobile, bool isTablet) {
    if (isMobile) return 70;
    if (isTablet) return 80;
    return 90;
  }

  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
      color: Colors.black.withOpacity(0.3),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: Colors.purpleAccent.withOpacity(0.3),
        width: 1.5,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.purpleAccent.withOpacity(0.1),
          blurRadius: 30,
          spreadRadius: 5,
        )
      ],
    );
  }

  Widget _buildResponsiveLayout(bool isMobile, bool isTablet) {
    if (isMobile) {
      // Mobile header now shows both the REGISTER and menu buttons.
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildAILogo(),
          Row(
            children: [
              _buildMobileRegisterButton(),
              _buildMobileMenuButton(),
            ],
          ),
        ],
      );
    }

    return Row(
      children: [
        _buildAILogo(),
        const Spacer(),
        ..._buildDesktopNav(isTablet),
        const Spacer(),
        _buildJoinButton(isTablet), // Desktop REGISTER button
      ],
    );
  }

  Widget _buildAILogo() {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Row(
          children: [
            // Replace the Icon with an Image.asset widget.
            Image.asset(
              'assets/logos/diksha/dikshalogoyellow.png', // Make sure this path is correct
              width: 34,
              height: 34,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 12),
            const Text(
              'DIKSHA 25',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                shadows: [
                  Shadow(
                    color: Colors.purpleAccent,
                    blurRadius: 10,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildDesktopNav(bool isTablet) {
    return _navItems.map((item) {
      final index = _navItems.indexOf(item);
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: isTablet ? 4 : 8),
        child: MouseRegion(
          onEnter: (_) => setState(() => _selectedIndex = index),
          onExit: (_) => setState(() => _selectedIndex = -1),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: _selectedIndex == index
                  ? LinearGradient(
                      colors: [
                        Colors.purple.withOpacity(0.3),
                        Colors.transparent
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    )
                  : null,
            ),
            child: TextButton(
              onPressed: () => setState(() => _selectedIndex = index),
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  vertical: isTablet ? 12 : 16,
                  horizontal: isTablet ? 16 : 24,
                ),
                foregroundColor: _selectedIndex == index
                    ? Colors.purpleAccent
                    : Colors.white.withOpacity(0.8),
              ),
              child: _buildNavItemContent(item, index),
            ),
          ),
        ),
      );
    }).toList();
  }

  Widget _buildNavItemContent(String item, int index) {
    return Stack(
      children: [
        Text(
          item,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            shadows: _selectedIndex == index
                ? [
                    Shadow(
                      color: Colors.purpleAccent,
                      blurRadius: 20,
                    )
                  ]
                : null,
          ),
        ),
        if (_selectedIndex == index)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 2,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.purpleAccent,
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildJoinButton(bool isTablet) {
    // Desktop REGISTER button
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: const LinearGradient(
              colors: [Color(0xFF9D50FF), Color(0xFF6E0CC0)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.purpleAccent.withOpacity(0.4),
                blurRadius: 15,
                spreadRadius: 3,
              )
            ],
          ),
          child: TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(
                horizontal: isTablet ? 24 : 32,
                vertical: isTablet ? 12 : 16,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: Colors.purpleAccent.withOpacity(0.5),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.app_registration,
                    color: Colors.white, size: isTablet ? 20 : 22),
                const SizedBox(width: 10),
                const Text(
                  "REGISTER",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.purpleAccent,
                        blurRadius: 10,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileMenuButton() {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_close,
        progress: AlwaysStoppedAnimation(_isMenuOpen ? -1.0 : 0.0),
        color: Colors.purpleAccent,
        size: 32,
      ),
      onPressed: () {
        setState(() => _isMenuOpen = !_isMenuOpen);
        _showMobileMenu();
      },
    );
  }

  Widget _buildMobileRegisterButton() {
    // Mobile header REGISTER button
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: const LinearGradient(
              colors: [Color(0xFF9D50FF), Color(0xFF6E0CC0)],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.purpleAccent.withOpacity(0.4),
                blurRadius: 15,
                spreadRadius: 3,
              )
            ],
          ),
          child: TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: Colors.purpleAccent.withOpacity(0.5),
                  width: 1,
                ),
              ),
            ),
            child: const Text(
              "REGISTER",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    color: Colors.purpleAccent,
                    blurRadius: 10,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showMobileMenu() {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Mobile Menu',
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return SafeArea(
          child: Align(
            alignment: Alignment.centerRight,
            child: Material(
              type: MaterialType.transparency,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                    border: Border.all(
                      color: Colors.purpleAccent.withOpacity(0.3),
                      width: 1.5,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ..._navItems.map((item) => _buildMobileNavItem(item)),
                      _buildMobileJoinButton(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
          )),
          child: child,
        );
      },
    );
  }

  Widget _buildMobileNavItem(String item) {
    return ListTile(
      title: Text(
        item,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        // Handle navigation
      },
    );
  }

  Widget _buildMobileJoinButton() {
    // Updated mobile dialog button label to "REGISTER"
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(
            colors: [Color(0xFF9D50FF), Color(0xFF6E0CC0)],
          ),
        ),
        child: TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            "REGISTER",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
