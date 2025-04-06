import 'package:flutter/material.dart';

import 'package:flutter_website/screen/Home/Homescreen.dart';
import 'package:flutter_website/screen/culturalscreen.dart';
import 'package:flutter_website/screen/technicalScreen.dart';


import 'package:get/get.dart';

// Assign an order/index to each route.
final Map<String, int> routeOrder = {
  Routes.home: 0,
  Routes.culturalevents: 1,
  
};

/// A custom slide transition that determines the slide direction
/// based on the relative order of the current and previous route.
class CustomSlideTransition extends CustomTransition {
  @override
  Widget buildTransition(
    BuildContext context,
    Curve? curve,
    Alignment? alignment,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    int? currentIndex = routeOrder[Get.currentRoute];
    int? previousIndex = routeOrder[Get.previousRoute];

    // Default to a small slide from the right.
    Offset beginOffset = const Offset(0.1, 0);

    if (previousIndex != null && currentIndex != null) {
      // Slide from the left if navigating backwards.
      if (currentIndex < previousIndex) {
        beginOffset = const Offset(-0.1, 0);
      } else {
        beginOffset = const Offset(0.1, 0);
      }
    }

    return SlideTransition(
      position: Tween<Offset>(
        begin: beginOffset,
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  }
}

class Routes {
  static const String home = '/';
  static const String culturalevents = '/cultural-events';
   static const String TechnicalEvents = '/technical-events';


  static final List<GetPage> pages = [
    GetPage(
      name: home,
      page: () => HomeScreen(),
      customTransition: CustomSlideTransition(),
      transitionDuration: const Duration(milliseconds: 500),
    ),
     GetPage(
      name: culturalevents,
      page: () => CulturalEventsScreen(),
      customTransition: CustomSlideTransition(),
      transitionDuration: const Duration(milliseconds: 500),
    ),
       GetPage(
      name: TechnicalEvents,
      page: () => TechnicalEventsScreen(),
      customTransition: CustomSlideTransition(),
      transitionDuration: const Duration(milliseconds: 500),
    ),
  ];
}
