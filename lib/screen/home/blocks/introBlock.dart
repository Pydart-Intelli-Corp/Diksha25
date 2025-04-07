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

    // Define text spans conditionally based on the screen size.
    final List<TextSpan> textSpans = isMobile
        ? [
            TextSpan(
              text: "Diksha 25",
              style: TextStyle(
                fontFamily: "Orbitron",
                fontWeight: FontWeight.w500,
                color: AppColors.diksha,
              ),
            ),
            const TextSpan(
              text:
                  " is the flagship fest of IET, University of Calicut. Join us for a day of tech & culture.",
            ),
          ]
        : const [
            TextSpan(
              text: "Diksha 25",
              style: TextStyle(
                fontFamily: "Orbitron",
                fontWeight: FontWeight.w500,
                color: AppColors.diksha,
              ),
            ),
            TextSpan(
                text:
                    " is the flagship technical and cultural fest of the "),
            TextSpan(
              text:
                  "Institute of Engineering and Technology, University of Calicut",
              style: TextStyle(
                fontFamily: "Orbitron",
                fontWeight: FontWeight.w500,
                color: AppColors.diksha,
              ),
            ),
            TextSpan(
              text:
                  ". Scheduled for April 11 and 12, 2025, Diksha is a vibrant celebration of innovation, creativity, and culture, bringing together passionate minds from across the region.",
            ),
            TextSpan(
              text:
                  "\n\nFrom thrilling competitions and hands-on workshops to inspiring tech talks and mesmerizing cultural performances, ",
            ),
            TextSpan(
              text: "Diksha 25",
              style: TextStyle(
                fontFamily: "Orbitron",
                fontWeight: FontWeight.w500,
                color: AppColors.diksha,
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
                color: AppColors.diksha,
              ),
            ),
            TextSpan(
              text:
                  " as we transform our campus into a vibrant hub of knowledge and expression. Be part of a movement that shapes the future – one idea, one beat, one breakthrough at a time.",
            ),
          ];

    return Container(
      width: double.infinity,
      margin: blockMargin.copyWith(top: 40, bottom: 40),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: AppColors.diksha.withOpacity(0.2),
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
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            // Background with updated blend of gradient and image
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: const AssetImage(
                        'assets/images/diksha/whoweare.jpg'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.6),
                      BlendMode.darken,
                    ),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.diksha.withOpacity(0.2),
                      AppColors.secondary.withOpacity(0.4),
                    ],
                  ),
                ),
              ),
            ),
            // Content container with modern padding
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 20 : 48,
                vertical: isMobile ? 30 : 60,
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Section with icon and title
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        buildMaterialIconCircle(
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
                            shadows: const [
                              Shadow(
                                color: Colors.black,
                                blurRadius: 10,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: isMobile ? 24 : 48),
                    // Content Card with updated design
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(12),
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
                          children: textSpans,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    // CTA Buttons - arranged in column for mobile and row for web.
                    isMobile
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              NeonButton(
                                onPressed: () => Navigator.pushNamed(
                                    context, '/technical-events'),
                                label: 'TECHNICAL EVENTS',
                                glowColor: AppColors.diksha,
                              ),
                              const SizedBox(height: 20),
                              NeonButton(
                                onPressed: () => Navigator.pushNamed(
                                    context, '/cultural-events'),
                                label: 'CULTURAL EVENTS',
                                glowColor: Colors.white,
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              NeonButton(
                                onPressed: () => Navigator.pushNamed(
                                    context, '/technical-events'),
                                label: 'TECHNICAL EVENTS',
                                glowColor: AppColors.diksha,
                              ),
                              const SizedBox(width: 20),
                              NeonButton(
                                onPressed: () => Navigator.pushNamed(
                                    context, '/cultural-events'),
                                label: 'CULTURAL EVENTS',
                                glowColor: Colors.white,
                              ),
                            ],
                          ),
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
