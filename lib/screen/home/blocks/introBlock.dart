import 'package:flutter/material.dart';
import 'package:flutter_website/components/icons.dart';
import 'package:flutter_website/components/spacing.dart';
import 'package:flutter_website/components/typography.dart';
import 'package:flutter_website/components/colors.dart';
import 'package:flutter_website/core/extensions/color_extensions.dart';
import 'package:flutter_website/screen/Home/buttons/neonButton.dart';
import 'package:flutter_website/widgets/buttons/gradient_button.dart';

class IntroBlock extends StatefulWidget {
  const IntroBlock({super.key});

  @override
  State<IntroBlock> createState() => _IntroBlockState();
}

class _IntroBlockState extends State<IntroBlock> {
  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Container(
      width: double.infinity,
      margin: blockMargin.copyWith(top: 40, bottom: 40),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0),
        boxShadow: [
          BoxShadow(
              color: AppColors.pydart.withOpacity(0.2),
              blurRadius: 32,
              spreadRadius: -12,
              offset: const Offset(0, 24)),
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 16,
            spreadRadius: -8,
            offset: const Offset(0, 16),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(0),
        child: Stack(
          children: [
            // The background uses a preloaded image (ensure this image is pre-cached in main)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    // This AssetImage will be loaded from cache if it was pre-cached earlier.
                    image:
                        const AssetImage('assets/images/diksha/whoweare.jpg'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.8),
                      BlendMode.darken,
                    ),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.pydart.withOpacity(0.1),
                      AppColors.secondary.withOpacity(0.3),
                    ],
                  ),
                ),
              ),
            ),
            // Content container
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 24 : 48,
                vertical: isMobile ? 40 : 60,
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Section with an icon that is also preloaded.
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        buildMaterialIconCircle(
                          // This icon image is preloaded (from the asset pre-caching in main).
                          "assets/logos/diksha/dikshalogoyellownoletter.png",
                          isMobile ? 56 : 72,
                        ),
                        SizedBox(width: isMobile ? 16 : 24),
                        Text(
                          "Diksha 25",
                          style: TextStyle(
                            fontFamily: "Orbitron",
                            color: Colors.white,
                            fontSize: isMobile ? 28 : 40,
                            fontWeight: FontWeight.w600,
                            height: 1.2,
                            shadows: [
                              Shadow(
                                color: const Color.fromARGB(255, 0, 0, 0),
                                blurRadius: 10,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: isMobile ? 32 : 48),
                    // Content Card
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 26, 26, 26)
                            .withOpacity(0.4),
                        borderRadius: BorderRadius.circular(0),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.1),
                          width: 1,
                        ),
                      ),
                    child: RichText(
  textAlign: TextAlign.justify,
  text: TextSpan(
    style: bodyTextStyle.copyWith(
      fontFamily: "Orbitron",
      color: Colors.white.withOpacity(0.95),
      fontSize: isMobile ? 16 : 18,
      height: 1.6,
      letterSpacing: 0.2,
    ),
    children: const [
      TextSpan(
        text: "Diksha 25",
        style: TextStyle(
          fontFamily: "Orbitron",
          fontWeight: FontWeight.w500,
          color: AppColors.pydart,
        ),
      ),
      TextSpan(text: " is the flagship technical and cultural fest of the "),
      TextSpan(
        text: "Institute of Engineering and Technology, University of Calicut",
        style: TextStyle(
          fontFamily: "Orbitron",
          fontWeight: FontWeight.w500,
          color: AppColors.pydart,
        ),
      ),
      TextSpan(
        text:
            ". Scheduled for April 11 and 12, 2025, Diksha is a vibrant celebration of innovation, creativity, and culture, bringing together passionate minds from across the region.",
      ),
      TextSpan(
        text: "\n\nFrom thrilling competitions and hands-on workshops to inspiring tech talks and mesmerizing cultural performances, ",
      ),
      TextSpan(
        text: "Diksha 25",
        style: TextStyle(
          fontFamily: "Orbitron",
          fontWeight: FontWeight.w500,
          color: AppColors.pydart,
        ),
      ),
      TextSpan(
        text:
            " is designed to ignite curiosity and foster collaboration. This year’s edition explores the cutting edge of technology, while celebrating the artistic spirit that unites us all.",
      ),
      TextSpan(
        text: "\n\nJoin us for two electrifying days of ",
      ),
      TextSpan(
        text: "innovation, inspiration, and celebration",
        style: TextStyle(
          fontFamily: "Orbitron",
          fontWeight: FontWeight.w500,
          color: AppColors.pydart,
        ),
      ),
      TextSpan(
        text:
            " as we transform our campus into a vibrant hub of knowledge and expression. Be part of a movement that shapes the future – one idea, one beat, one breakthrough at a time.",
      ),
    ],
  ),
),

                    ),
                    // CTA Button (shown on larger screens)
                    if (!isMobile) ...[
                      const SizedBox(height: 32),
                        Row(
                          children: [
                            NeonButton(
                                                  onPressed: () => Navigator.pushNamed(context, '/technical-events'),
                                                  label: 'TECHNICAL EVENTS',
                                                  glowColor: const Color.fromARGB(255, 221, 232, 12),
                                                ),

SizedBox(width: 20,),   NeonButton(
                      onPressed: () => Navigator.pushNamed(context, '/cultural-events'),
                      label: 'CULTURAL EVENTS ',
                      glowColor: const Color(0xFFFE53BB),
                    ),

                          ],


                          
                        ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
