import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_website/components/colors.dart';

import 'package:flutter_website/screen/Home/blocks/people.dart'
    show PeopleBlock;
import 'package:flutter_website/screen/Home/blocks/introBlock.dart';

import 'package:flutter_website/screen/home/blocks/HeaderBlock.dart';

import 'package:flutter_website/screen/home/blocks/block1.dart'
    show TechFestHero;
import 'package:flutter_website/ui/blocks/common/footer.dart';

class NoGlowScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoaded = false;
  bool _showScrollButtons = false;
  double _scrollOffset = 0.0;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
  }

  void _handleScroll() {
    final bool isAtBottom = _scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent;
    final bool isAtTop = _scrollController.position.pixels == 0;
    setState(() {
      _showScrollButtons = !isAtBottom && !isAtTop;
      _scrollOffset = _scrollController.position.pixels; // Update scroll offset
    });
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOutQuart,
    );
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOutQuart,
    );
  }

  Future<void> _precacheAssets() async {
    // await precacheImage(
    //     const AssetImage('assets/images/others/whoweare.png'), context);
    // await precacheImage(const AssetImage('assets/icons/whoweare.png'), context);
    // setState(() => _isLoaded = true);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isLoaded) _precacheAssets();
  }

  @override
  Widget build(BuildContext context) {
    final double opacity = (1.0 - (_scrollOffset / 200)).clamp(0.0, 1.0);
    final double blurSigma = (_scrollOffset / 20).clamp(0.0, 10.0);
    return Scaffold(
      backgroundColor: background,
      // appBar: const PreferredSize(
      //   preferredSize: Size(double.infinity, 66),
      //   child: Header(),
      // ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              Column(
                children: [
                  // SizedBox(
                  //   height: constraints.maxHeight / 2,
                  //   child: const FixedVideoBackground(),
                  // ),
                  Expanded(child: Container(color: Colors.black)),
                ],
              ),
              _buildContentLayer(),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Opacity(
                      opacity: opacity,
                      child: ClipRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: blurSigma,
                            sigmaY: blurSigma,
                          ),
                          child: Container(
                            child: HeaderBlock(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (_showScrollButtons) _buildScrollButtons(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildContentLayer() {
    return ScrollConfiguration(
      behavior: NoGlowScrollBehavior(),
      child: AnimationLimiter(
        child: ListView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(top: 0),
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 600),
            childAnimationBuilder: (widget) => SlideAnimation(
              verticalOffset: 50.0,
              curve: Curves.easeInOutCubic,
              child: FadeInAnimation(
                curve: Curves.easeInOutCirc,
                child: widget,
              ),
            ),
            children: [
              TechFestHero(),
              IntroBlock(),
              PeopleBlock(),
              FooterBlock()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScrollButtons() {
    return Positioned(
      bottom: 30,
      right: 30,
      child: Column(
        children: [
          ScaleTransition(
            scale: CurvedAnimation(
              parent: AlwaysStoppedAnimation(_showScrollButtons ? 1.0 : 0.0),
              curve: Curves.elasticOut,
            ),
            child: FloatingActionButton(
              onPressed: _scrollToTop,
              backgroundColor:
                  const Color.fromARGB(81, 54, 7, 87).withOpacity(0.8),
              child: const Icon(Icons.arrow_upward, color: Colors.white),
            ),
          ),
          const SizedBox(height: 15),
          ScaleTransition(
            scale: CurvedAnimation(
              parent: AlwaysStoppedAnimation(_showScrollButtons ? 1.0 : 0.0),
              curve: Curves.elasticOut,
            ),
            child: FloatingActionButton(
              onPressed: _scrollToBottom,
              backgroundColor:
                  const Color.fromARGB(81, 54, 7, 87).withOpacity(0.8),
              child: const Icon(Icons.arrow_downward, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
