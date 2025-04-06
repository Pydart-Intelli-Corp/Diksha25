import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_website/screen/Home/homescreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class HeaderBlock extends StatefulWidget {
  const HeaderBlock({Key? key}) : super(key: key);

  @override
  State<HeaderBlock> createState() => _HeaderBlockState();
}

class _HeaderBlockState extends State<HeaderBlock> {
  int _selectedIndex = -1;
  bool _isMenuOpen = false;
  final List<String> _navItems = ['HOME', 'EVENTS', 'GALLERY', 'CONTACT US'];
int _expandedIndex = -1;
  // ─── Reload the HomeScreen ─────────────────────────────────────────────
  void _reloadHome() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const HomeScreen(),
        transitionDuration: Duration.zero,
      ),
    );
  }

  // ─── Desktop: Events dropdown with overview & image ───────────────────
  void _showEventsMenu(PointerEnterEvent event) {
  String selected = 'technical';
  final position = RelativeRect.fromLTRB(
    event.position.dx,
    event.position.dy,
    event.position.dx,
    event.position.dy,
  );

  showMenu(
    context: context,
    position: position,
    constraints: const BoxConstraints(minWidth: 1000, maxWidth: 1000),
    items: [
      PopupMenuItem(
        enabled: false,
        child: MouseRegion(
        
          child: StatefulBuilder(
            builder: (context, setState) {
              return Container(
                width: 1000,
                height: 300,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.purpleAccent, width: 1),
                ),
                child: Row(
                  children: [
                    // Left column: "Technical" / "Cultural" choices
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MouseRegion(
                          onEnter: (_) => setState(() => selected = 'technical'),
                          child: Text(
                            'Technical',
                            style: TextStyle(
                fontFamily: 'Orbitron',
                              color: selected == 'technical'
                                  ? Colors.purpleAccent
                                  : Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        MouseRegion(
                          onEnter: (_) => setState(() => selected = 'cultural'),
                          child: Text(
                            'Cultural',
                            style: TextStyle(
                fontFamily: 'Orbitron',
                              color: selected == 'cultural'
                                  ? Colors.purpleAccent
                                  : Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 24),
                    // Right column: overview & image
                    Expanded(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: selected == 'technical'
                            ? _buildOverviewContent(
                                key: const ValueKey('tech'),
                                title: 'Technical Events',
                                description:
                                    'Dive into coding challenges, robotics workshops, and hackathons designed to test your skills.',
                                imagePath: 'assets/images/diksha/tech.webp',
                                eventType: 'technical',
                              )
                            : _buildOverviewContent(
                                key: const ValueKey('cultural'),
                                title: 'Cultural Events',
                                description:
                                    'Enjoy music concerts, dance battles, and art exhibitions celebrating creativity.',
                                imagePath: 'assets/images/diksha/cult.webp',
                                eventType: 'cultural',
                              ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    ],
  );
}
Widget _buildContactItem({
  required IconData icon,
  required String text,
  required VoidCallback onTap,
}) {
  return StatefulBuilder(
    builder: (context, setState) {
      bool isHovered = false;
      return MouseRegion(
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        child: Container(
          decoration: BoxDecoration(
            color: isHovered ? Colors.purple : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(icon, color: Colors.white),
            title: Text(
              text,
              style: TextStyle(
                fontFamily: 'Orbitron',
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: onTap,
          ),
        ),
      );
    },
  );
}
void _showContactMenu(PointerEnterEvent event) {
  final position = RelativeRect.fromLTRB(
    event.position.dx,
    event.position.dy,
    event.position.dx,
    event.position.dy,
  );
  showMenu(
    context: context,
    position: position,
    constraints: const BoxConstraints(minWidth: 350, maxWidth: 350),
    items: [
      PopupMenuItem(
        enabled: false,
        child: MouseRegion(
          onExit: (_) => Navigator.pop(context),
          child: Container(
            width: 350,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.9),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.purpleAccent, width: 1),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildContactItem(
                  icon: Icons.email,
                  text: 'diksha25iet@gmail.com',
                  onTap: () async {
                    Navigator.pop(context);
                    final Uri emailUri = Uri(
                      scheme: 'mailto',
                      path: 'diksha25iet@gmail.com',
                    );
                    if (await canLaunchUrl(emailUri)) {
                      await launchUrl(emailUri);
                    }
                  },
                ),
                _buildContactItem(
                  icon: Icons.phone,
                  text: '+91-9876543210',
                  onTap: () async {
                    Navigator.pop(context);
                    final Uri telUri = Uri(
                      scheme: 'tel',
                      path: '+919876543210',
                    );
                    if (await canLaunchUrl(telUri)) {
                      await launchUrl(telUri);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}
void _showMobileMenu() {
  setState(() => _isMenuOpen = true);

  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Mobile Menu',
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) {
      int expandedIndex = -1; // Local state for expanded index
      return SafeArea(
        child: StatefulBuilder(
          builder: (context, setStateDialog) {
            return Align(
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
                        bottomLeft: Radius.circular(20)),
                      border: Border.all(
                        color: Colors.purpleAccent.withOpacity(0.3),
                        width: 1.5,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ..._navItems.asMap().entries.map((entry) {
                          final index = entry.key;
                          final item = entry.value;
                          if (item == 'EVENTS' || item == 'CONTACT US') {
                            return _buildExpandableMobileNavItem(
                              item,
                              index,
                              expandedIndex,
                              (newIndex) {
                                setStateDialog(() {
                                  expandedIndex = newIndex == expandedIndex 
                                      ? -1 
                                      : newIndex;
                                });
                              },
                            );
                          } else {
                            return _buildMobileNavItem(item, index);
                          }
                        }).toList(),
                        const SizedBox(height: 30),
                        _buildMobileJoinButton(),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    },
    transitionBuilder: (c, anim, secAnim, child) => SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1, 0),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: anim, curve: Curves.easeOut)),
      child: child,
    ),
  ).then((_) => setState(() => _isMenuOpen = false));
}
Widget _buildExpandableMobileNavItem(
  String title,
  int index,
  int expandedIndex,
  Function(int) onExpand,
) {
  final isExpanded = expandedIndex == index;
  return Column(
    children: [
      ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
                fontFamily: 'Orbitron',
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        onTap: () => onExpand(index),
      ),
      if (isExpanded)
        AnimatedCrossFade(
          duration: const Duration(milliseconds: 300),
          crossFadeState: isExpanded 
              ? CrossFadeState.showFirst 
              : CrossFadeState.showSecond,
          firstChild: _buildExpandedOptions(title),
          secondChild: const SizedBox.shrink(),
        ),
    ],
  );
}

Widget _buildExpandedOptions(String title) {
  if (title == 'EVENTS') {
    return Column(
      children: [
        _buildMobileSubItem('Technical Events', () {
          Navigator.pop(context);
          Navigator.pushNamed(context, '/technical-events');
        }),
        _buildMobileSubItem('Cultural Events', () {
          Navigator.pop(context);
          Navigator.pushNamed(context, '/cultural-events');
        }),
      ],
    );
  } else if (title == 'CONTACT US') {
    return Column(
      children: [
        _buildMobileContactItem(
          icon: Icons.email,
          text: 'diksha25iet@gmail.com',
          onTap: () async {
            Navigator.pop(context);
            final Uri emailUri = Uri(
              scheme: 'mailto',
              path: 'diksha25iet@gmail.com',
            );
            if (await canLaunchUrl(emailUri)) {
              await launchUrl(emailUri);
            }
          },
        ),
        _buildMobileContactItem(
          icon: Icons.phone,
          text: '+91-9876543210',
          onTap: () async {
            Navigator.pop(context);
            final Uri telUri = Uri(scheme: 'tel', path: '+919876543210');
            if (await canLaunchUrl(telUri)) {
              await launchUrl(telUri);
            }
          },
        ),
      ],
    );
  }
  return const SizedBox.shrink();
}

Widget _buildMobileSubItem(String text, VoidCallback onTap) {
  return ListTile(
    contentPadding: EdgeInsets.zero,
    title: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
                fontFamily: 'Orbitron',
        color: Colors.white70,
        fontSize: 16,
      ),
    ),
    onTap: onTap,
  );
}

Widget _buildMobileContactItem({
  required IconData icon,
  required String text,
  required VoidCallback onTap,
}) {
  return ListTile(
    contentPadding: EdgeInsets.zero,
    onTap: onTap,
    title: Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 20),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
                fontFamily: 'Orbitron',
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildMobileNavItem(String title, int index) {
  return ListTile(
    contentPadding: EdgeInsets.zero,
    title: Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
                fontFamily: 'Orbitron',
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
    ),
    onTap: () {
      if (title == 'HOME') _reloadHome();
      Navigator.pop(context);
    },
  );
}
  Widget _buildMobileJoinButton() {
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
          onPressed: () async{  
            
             final Uri _registerUri = Uri.parse('https://tiqr.events/e/PROSHOW-TICKETS-1119');

             await launchUrl(
              _registerUri,
              webOnlyWindowName: '_blank', // ← opens in new tab
            );},
          style: TextButton.styleFrom(
            padding:
                const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            "REGISTER",
            style: TextStyle(
                fontFamily: 'Orbitron',
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  // ─── Overview content builder (fixed image height) ──────────────────────
 Widget _buildOverviewContent({
  required Key key,
  required String title,
  required String description,
  required String imagePath,
  required String eventType,
}) {
  return Column(
    key: key,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(
                fontFamily: 'Orbitron',
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 8),
      Text(
        description,
        style: TextStyle(
                fontFamily: 'Orbitron',color: Colors.white70),
      ),
      const SizedBox(height: 12),
      MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: const LinearGradient(
              colors: [Color(0xFF9D50FF), Color(0xFF6E0CC0)],
            ),
          ),
          child: TextButton(
            onPressed: () {
              // Navigate based on event type.
              if (eventType == 'technical') {
                Navigator.pushNamed(context, '/technical-events');
              } else if (eventType == 'cultural') {
                Navigator.pushNamed(context, '/cultural-events');
              }
            },
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
            ),
            child: Text(
              'SHOW EVENTS',
              style: TextStyle(
                fontFamily: 'Orbitron',
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
      const SizedBox(height: 12),
      SizedBox(
        height: 130,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),
      ),
    ],
  );
}

  // ─── Build method with responsive layout ────────────────────────────────
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isMobile = w < 600;
    final isTablet = w >= 600 && w < 1024;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              width: isMobile
                  ? w * 0.95
                  : isTablet
                      ? w * 0.9
                      : 1200,
              height: isMobile
                  ? 70
                  : isTablet
                      ? 80
                      : 90,
              decoration: BoxDecoration(
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
              ),
              child: isMobile
                  ? _buildMobileLayout(isTablet)
                  : _buildDesktopLayout(isTablet),
            ),
          ),
        ),
      ),
    );
  }

  // ─── Desktop layout ─────────────────────────────────────────────────────
  Widget _buildDesktopLayout(bool isTablet) {
    return Row(
      children: [
        _buildLogo(),
        const Spacer(),
        ..._buildDesktopNav(isTablet),
        const Spacer(),
        _buildRegisterButton(isTablet),
      ],
    );
  }

  List<Widget> _buildDesktopNav(bool isTablet) {
    return _navItems.map((item) {
      final idx = _navItems.indexOf(item);
      return Padding(
        padding:
            EdgeInsets.symmetric(horizontal: isTablet ? 8 : 12),
        child: MouseRegion(
          onEnter: (e) {
            setState(() => _selectedIndex = idx);
            if (item == 'EVENTS') _showEventsMenu(e);
            if (item == 'CONTACT US') _showContactMenu(e);
          },
          onExit: (_) => setState(() => _selectedIndex = -1),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: _selectedIndex == idx
                  ? LinearGradient(
                      colors: [
                        Colors.purple.withOpacity(0.3),
                        Colors.transparent,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    )
                  : null,
            ),
            child: TextButton(
              onPressed: () {
                if (item == 'HOME') _reloadHome();
                // Add other nav actions here if needed
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  vertical: isTablet ? 12 : 16,
                  horizontal: isTablet ? 16 : 24,
                ),
                foregroundColor: _selectedIndex == idx
                    ? Colors.purpleAccent
                    : Colors.white.withOpacity(0.8),
              ),
              child: _buildNavText(item, idx),
            ),
          ),
        ),
      );
    }).toList();
  }

  Widget _buildNavText(String text, int idx) {
    return Stack(
      children: [
        Text(
          text,
          style: TextStyle(
                fontFamily: 'Orbitron',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white,
            shadows: _selectedIndex == idx
                ? [const Shadow(color: Colors.purpleAccent, blurRadius: 20)]
                : null,
          ),
        ),
        if (_selectedIndex == idx)
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

  Widget _buildLogo() {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Row(
          children: [
            Image.asset(
              'assets/logos/diksha/dikshalogoyellow.png',
              width: 34,
              height: 34,
            ),
            const SizedBox(width: 12),
            Text(
              'DIKSHA 25',
              style: TextStyle(
                fontFamily: 'Orbitron',
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                shadows: [const Shadow(color: Colors.purpleAccent, blurRadius: 10)],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRegisterButton(bool isTablet) {
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
                     onPressed: () async{  
            
             final Uri _registerUri = Uri.parse('https://tiqr.events/e/PROSHOW-TICKETS-1119');

             await launchUrl(
              _registerUri,
              webOnlyWindowName: '_blank', // ← opens in new tab
            );},
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
                Icon(
                  Icons.app_registration,
                  color: Colors.white,
                  size: isTablet ? 20 : 22,
                ),
                const SizedBox(width: 10),
                Text(
                  'REGISTER',
                  style: TextStyle(
                fontFamily: 'Orbitron',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      const Shadow(color: Colors.purpleAccent, blurRadius: 10)
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

  // ─── Mobile layout ─────────────────────────────────────────────────────
  Widget _buildMobileLayout(bool isTablet) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildLogo(),
        Row(
          children: [
            _buildMobileRegisterButton(),
            _buildMobileMenuButton(),
          ],
        ),
      ],
    );
  }

  Widget _buildMobileRegisterButton() {
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
                   onPressed: () async{  
            
             final Uri _registerUri = Uri.parse('https://tiqr.events/e/PROSHOW-TICKETS-1119');

             await launchUrl(
              _registerUri,
              webOnlyWindowName: '_blank', // ← opens in new tab
            );},
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: Colors.purpleAccent.withOpacity(0.5),
                  width: 1,
                ),
              ),
            ),
            child: Text(
              "REGISTER",
              style: TextStyle(
                fontFamily: 'Orbitron',
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  const Shadow(color: Colors.purpleAccent, blurRadius: 10)
                ],
              ),
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
        progress: AlwaysStoppedAnimation(_isMenuOpen ? 1.0 : 0.0),
        color: Colors.purpleAccent,
        size: 32,
      ),
      onPressed: _showMobileMenu,
    );
  }
}
