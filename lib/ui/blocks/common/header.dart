import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_website/widgets/Forms/enquiry_Page.dart';
import 'package:flutter_website/widgets/buttons/gradient_button.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:flutter_website/router.dart';
import 'package:flutter_website/ui/blocks/header%20contents/careers.dart';
import 'package:flutter_website/ui/blocks/header%20contents/insights.dart';

import 'package:flutter_website/widgets/buttons/loading_button.dart';
import 'package:flutter_website/widgets/buttons/text_hover_button.dart';
import 'package:url_launcher/url_launcher.dart';

class NavigationProvider extends ChangeNotifier {
  String _active = 'home';
  String? _previousActive;
  String? _hovered;

  String get active => _active;
  String? get previousActive => _previousActive;
  String? get hovered => _hovered;

  set active(String value) {
    if (_active != value) {
      _previousActive = _active;
      _active = value;
      notifyListeners();
    }
  }

  set hovered(String? value) {
    if (_hovered != value) {
      _hovered = value;
      notifyListeners();
    }
  }
}

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  final Color navLinkColor = Colors.white;
  // Global keys for dropdown placement on desktop.
  final GlobalKey _whoweareKey = GlobalKey();
  final GlobalKey _ourservicesKey = GlobalKey();
  final GlobalKey _careersKey = GlobalKey();
  final GlobalKey _insightsKey = GlobalKey();

  String? currentDropdown;
  OverlayEntry? _overlayEntry;
  Timer? _autoCloseTimer;
  // Variable to hold the previous hovered state.
  String? _previousHovered;
  // Cache the NavigationProvider for safe access.
  late NavigationProvider _navProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Cache the provider reference once dependencies are available.
    _navProvider = Provider.of<NavigationProvider>(context, listen: false);
  }

  void openUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  /// Shows the dropdown for the given [dropdown] key.
  /// If another dropdown is open, it is first closed without restoring the hovered state.
  void _showDropdown(String dropdown) {
    if (currentDropdown == dropdown) return;

    if (currentDropdown != null) {
      // Hide any open dropdown without restoring the previous hovered state.
      _hideDropdown(restorePreviousHovered: false);
    }

    currentDropdown = dropdown;
    // Calculate position using the key for the specific dropdown.
    GlobalKey keyForDropdown;
    switch (dropdown) {
      case 'whoweare':
        keyForDropdown = _whoweareKey;
        break;
      case 'ourservices':
        keyForDropdown = _ourservicesKey;
        break;
      case 'insights':
        keyForDropdown = _insightsKey;
        break;
      case 'careers':
        keyForDropdown = _careersKey;
        break;
      default:
        return;
    }

    final RenderBox? renderBox =
        keyForDropdown.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final offset = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx,
        top: offset.dy + size.height + 5,
        child: MouseRegion(
          onEnter: (_) => _cancelAutoClose(),
          onExit: (_) => _scheduleAutoClose(),
          child: _buildDropdownContent(dropdown),
        ),
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  /// Hides the currently open dropdown.
  /// If [restorePreviousHovered] is true, the previously stored hovered state is restored.
  void _hideDropdown({bool restorePreviousHovered = true}) {
    currentDropdown = null;
    _overlayEntry?.remove();
    _overlayEntry = null;
    if (restorePreviousHovered) {
      _navProvider.hovered = _previousHovered ?? 'home';
      _previousHovered = null;
    }
  }

  Widget _buildDropdownContent(String dropdown) {
    switch (dropdown) {
   
      // case 'ourservices':
      //   return OurServices(
      //     onItemPressed: _hideDropdown,
      //     openUrl: openUrl,
      //   );
      // case 'insights':
      //   return Insights(
      //     onItemPressed: _hideDropdown,
      //     openUrl: openUrl,
      //   );
      // case 'careers':
      //   return CareersContent(
      //     onItemPressed: _hideDropdown,
      //     openUrl: openUrl,
      //   );
      default:
        return Container();
    }
  }

  void _cancelAutoClose() => _autoCloseTimer?.cancel();

  void _scheduleAutoClose() =>
      _autoCloseTimer = Timer(const Duration(milliseconds: 200), () {
        // When auto-closing, restore previous hovered state.
        _hideDropdown();
      });

  @override
  void dispose() {
    // Avoid restoring hovered state on dispose to prevent provider update during tree lock.
    _hideDropdown(restorePreviousHovered: false);
    _autoCloseTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Ensure this widget is wrapped with a ChangeNotifierProvider<NavigationProvider>
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return _buildMobileHeader();
        } else {
          return _buildDesktopHeader();
        }
      },
    );
  }

  // --- Desktop Header ---
  Widget _buildDesktopHeader() {
    // Provider lookup is safe here.
    final navProvider = Provider.of<NavigationProvider>(context);
    return Container(
      height: 70,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 3, 10, 14),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 47, 47, 47),
            offset: Offset(0, 0.01),
            blurRadius: 0,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Row(
        children: [
          // Logo (clicking sets active to 'home').
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                navProvider.hovered = 'home';
                navProvider.active = 'home';
                Navigator.pushReplacementNamed(context, Routes.home);
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 0),
                child: SizedBox(
                  height: 100,
                  width: 150,
                  child: SvgPicture.asset(
                    "assets/logos/diksha/dikshalogoyellow.svg",
                    semanticsLabel: 'Diksha Logo',
                    fit: BoxFit.scaleDown,
                    allowDrawingOutsideViewBox: true,
                  ),
                ),
              ),
            ),
          ),
          // Home Button (no dropdown).
          MouseRegion(
            child: TextHoverButton(
              label: "Home",
              onPressed: () {
                navProvider.hovered = 'home';
                navProvider.active = 'home';
                Get.toNamed(Routes.home);
              },
              isActive: (navProvider.hovered == 'home') ||
                  (navProvider.hovered == null && navProvider.active == 'home'),
              color: navLinkColor,
            ),
          ),
          const SizedBox(width: 32),
          // "Who we are" Button with dropdown.
 
            const Spacer(),
          // "Contact Us" Button.
          PrimaryGradientButton(
            onPressed: () {
              _showDetailsPopup(context, 'Mobile Application');
            },
            text: "Enquire Now ",
          )
        ],
      ),
    );
  }

  void _showDetailsPopup(BuildContext context, String dropdownValue) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ResponsiveDialog(dropdownValue: dropdownValue);
      },
    );
  }

  // --- Mobile Header ---
  Widget _buildMobileHeader() {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 3, 10, 14),
      leadingWidth: 150,
      leading: SizedBox(
        width: 130,
        height: 60,
        child: SvgPicture.asset(
       "assets/logos/diksha/dikshalogoyellow.svg",
          semanticsLabel: 'Diksha Logo',
          fit: BoxFit.fill,
          allowDrawingOutsideViewBox: true,
        ),
      ),
      title: const Text(''),
      actions: [
        TextButton(
          onPressed: () => openUrl('https://www.tcs.com/services'),
          child: const Text(
            'About',
            style: TextStyle(color: Colors.white),
          ),
        ),
        TextButton(
          onPressed: () => openUrl('https://www.tcs.com/services'),
          child: const Text(
            'Contact Us',
            style: TextStyle(color: Colors.white),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => _buildMobileMenu(),
            );
          },
        ),
      ],
    );
  }

  Widget _buildMobileMenu() {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('Home'),
            onTap: () {
              Provider.of<NavigationProvider>(context, listen: false).active =
                  'home';
              Navigator.pushReplacementNamed(context, Routes.home);
            },
          ),
          // ListTile(
          //   title: const Text('Who we are'),
          //   trailing: const Icon(Icons.arrow_forward),
          //   onTap: () {
          //     Provider.of<NavigationProvider>(context, listen: false).active =
          //         'whoweare';
          //     Get.toNamed(Routes.whoweare);
          //   },
          // ),
          ListTile(
            title: const Text('Our services'),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Provider.of<NavigationProvider>(context, listen: false).active =
                  'ourservices';
              Navigator.pop(context);
              openUrl('https://www.tcs.com/services');
            },
          ),
          ListTile(
            title: const Text('Insights'),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Provider.of<NavigationProvider>(context, listen: false).active =
                  'insights';
              Navigator.pop(context);
              openUrl('https://www.tcs.com/services');
            },
          ),
          ListTile(
            title: const Text('Careers'),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Provider.of<NavigationProvider>(context, listen: false).active =
                  'careers';
              Navigator.pop(context);
              openUrl('https://www.tcs.com/services');
            },
          ),
          ListTile(
            title: const Text('About'),
            onTap: () {
              Navigator.pop(context);
              openUrl('https://www.tcs.com/services');
            },
          ),
          ListTile(
            title: const Text('Contact Us'),
            onTap: () {
              Navigator.pop(context);
              openUrl('https://www.tcs.com/services');
            },
          ),
        ],
      ),
    );
  }
}
