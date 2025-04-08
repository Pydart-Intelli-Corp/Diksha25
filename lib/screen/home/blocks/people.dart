import 'package:flutter/material.dart';
import 'package:flutter_website/components/icons.dart';
import 'package:flutter_website/components/spacing.dart';
import 'package:flutter_website/core/extensions/color_extensions.dart';
import 'package:url_launcher/url_launcher.dart';

class PeopleBlock extends StatefulWidget {
  const PeopleBlock({super.key});

  @override
  State<PeopleBlock> createState() => _PeopleBlockState();
}

class _PeopleBlockState extends State<PeopleBlock> {
  final List<Map<String, String>> teamMembers = [
    {
      'name': 'Sagar Sunny \n    ',
      'role': 'Convener',
      'bio': 'Diksha 25',
      'image': 'assets/images/diksha/sagar.webp'
    },
    {
      'name': 'Mohammed sanjid T M ',
      'role': 'Chairman',
      'bio': 'IET UOC',
      'image': 'assets/images/diksha/sanjid.jpg'
    },
    {
      'name': 'Mohammed Faljash T M',
      'role': 'Co-Convener',
      'bio': 'Diksha 25',
      'image': 'assets/images/diksha/Faljash.webp'
    },
    {
      'name': 'Aswin Uday PP\n',
      'role': 'Co-Convener',
      'bio': 'Diksha 25',
      'image': 'assets/images/diksha/aswin.jpg'
    },
    {
      'name': 'Dr. Ranjith C\n',
      'role': 'Principal',
      'bio': 'IET UOC',
      'image': 'assets/images/diksha/principal.jpg'
    },
    {
      'name': 'Gokul CT\n',
      'role': 'Treasurer',
      'bio': 'Diksha 25',
      'image': 'assets/images/diksha/gokul.jpg'
    },
  ];

  // FAQ items list remains unchanged.
  final List<bool> _isExpanded = [false, false, false];
  final List<Map<String, String>> faqItems = [
    {
      'question': 'How do I register for events and book tickets?',
      'answer':
          'Register for events and book tickets through our official website. Visit www.dikshaiet.com for all registrations.',
    },
    {
      'question': 'When is Diksha 2025 happening?',
      'answer':
          'Diksha 2025 will be held on April 11th and 12th. Mark your calendars!',
    },
    {
      'question': 'Can outsiders purchase Proshow tickets?',
      'answer':
          'Yes! Proshow tickets are available for everyone. Book early to secure your spot.',
    },
  ];

  // Updated co sponsors data. Note the addition of 'width' and 'height'.
  // in your State class:
  final List<Map<String, dynamic>> coSponsors = [
    {
      'name': '',
      'logo': 'assets/logos/pydartw.png',
      'width': 250.0,
      'height': 200.0,
      'description':
          'Software, Hardware and Firmware developmet with Integrated AI',
      'website': 'https://www.pydart.in',
    },
    {
      'name': '',
      'logo': 'assets/logos/brickly.webp',
      'width': 400.0,
      'height': 200.0,
      'description': 'Innovating Construction Management',
      'website': 'https://www.brickly.ai',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final contentPadding = isMobile ? 24.0 : 48.0;

    return Container(
      width: double.infinity,
      margin: blockMargin.copyWith(top: 40, bottom: 40),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary.withOpacity(0.1),
            AppColors.secondary.withOpacity(0.3),
          ],
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/images/diksha/team.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.7),
              BlendMode.darken,
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 40,
            horizontal: contentPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(isMobile),
              const SizedBox(height: 40),
              _buildTeamSection(isMobile),
              const SizedBox(height: 40),
              _buildFAQSection(isMobile),
              const SizedBox(height: 40),
              _buildSponsorsSection(isMobile),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(bool isMobile) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        buildMaterialIconCircle(
          "assets/logos/diksha/dikshalogoyellownoletter.png",
          isMobile ? 40 : 56,
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Wisdom Circle",
              style: TextStyle(
                fontFamily: "Orbitron",
                color: Colors.white,
                fontSize: isMobile ? 28 : 36,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.2,
              ),
            ),
            Text(
              "Learn • Lead • Inspire",
              style: TextStyle(
                fontFamily: "Orbitron",
                color: AppColors.diksha,
                fontSize: isMobile ? 14 : 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTeamSection(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Organizing Team",
          style: TextStyle(
            fontFamily: "Orbitron",
            color: Colors.white,
            fontSize: isMobile ? 24 : 32,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 24),
        LayoutBuilder(
          builder: (context, constraints) {
            if (isMobile) {
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                ),
                itemCount: teamMembers.length,
                itemBuilder: (context, index) =>
                    _buildTeamCard(teamMembers[index], isMobile: true),
              );
            }
            return SizedBox(
              height: 280,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: teamMembers.length,
                separatorBuilder: (_, __) => const SizedBox(width: 24),
                itemBuilder: (context, index) =>
                    _buildTeamCard(teamMembers[index]),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildTeamCard(Map<String, String> member, {bool isMobile = false}) {
    return Container(
      width: isMobile ? null : 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.25),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.diksha.withOpacity(0.4),
                width: 2,
              ),
            ),
            child: CircleAvatar(
              radius: isMobile ? 48 : 56,
              backgroundImage: AssetImage(member['image']!),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            member['name']!,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "Orbitron",
              color: Colors.white,
              fontSize: isMobile ? 14 : 16,
              fontWeight: FontWeight.w600,
              height: 1.2,
            ),
            maxLines: 2,
          ),
          const SizedBox(height: 8),
          Text(
            member['role']!,
            style: TextStyle(
              fontFamily: "Orbitron",
              color: AppColors.diksha,
              fontSize: isMobile ? 12 : 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            member['bio']!,
            style: TextStyle(
              fontFamily: "Orbitron",
              color: Colors.white70,
              fontSize: isMobile ? 11 : 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAQSection(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Frequently Asked Questions",
          style: TextStyle(
            fontFamily: "Orbitron",
            color: Colors.white,
            fontSize: isMobile ? 24 : 32,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 24),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: faqItems.length,
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final faq = faqItems[index];
            return _buildFAQItem(
              question: faq['question']!,
              answer: faq['answer']!,
              isExpanded: _isExpanded[index],
              onTap: () =>
                  setState(() => _isExpanded[index] = !_isExpanded[index]),
              isMobile: isMobile,
            );
          },
        ),
      ],
    );
  }

  Widget _buildFAQItem({
    required String question,
    required String answer,
    required bool isExpanded,
    required VoidCallback onTap,
    required bool isMobile,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: isExpanded
                ? AppColors.diksha.withOpacity(0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isExpanded ? AppColors.diksha : Colors.white24,
              width: 1,
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      question,
                      style: TextStyle(
                        fontFamily: "Orbitron",
                        color: Colors.white,
                        fontSize: isMobile ? 16 : 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Icon(
                    isExpanded ? Icons.remove : Icons.add,
                    color: AppColors.diksha,
                    size: 24,
                  ),
                ],
              ),
              if (isExpanded) ...[
                const SizedBox(height: 12),
                Text(
                  answer,
                  style: TextStyle(
                    fontFamily: "Orbitron",
                    color: Colors.white70,
                    fontSize: isMobile ? 14 : 16,
                    height: 1.4,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSponsorsSection(bool isMobile) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.diksha.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Co - Sponsors",
            style: TextStyle(
              fontFamily: "Orbitron",
              color: Colors.white,
              fontSize: isMobile ? 24 : 32,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Center(
            child: Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: isMobile ? 24 : 48,
              runSpacing: isMobile ? 24 : 48,
              children: coSponsors.map((sponsor) {
                final double logoW =
                    isMobile ? sponsor['width'] * 0.7 : sponsor['width'] * 0.9;
                final double logoH = isMobile
                    ? sponsor['height'] * 0.7
                    : sponsor['height'] * 0.9;

                return Container(
                  width: 400,
                  height: 300,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: logoW,
                        height: logoH,
                        child: Image.asset(
                          sponsor['logo']!,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        sponsor['description']!,
                        style: TextStyle(
                          fontFamily: "Orbitron",
                          color: Colors.black87,
                          fontSize: isMobile ? 12 : 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      // tappable website link
                      InkWell(
                        onTap: () async {
                          final uri = Uri.parse(sponsor['website']!);
                          if (await canLaunchUrl(uri)) {
                            await launchUrl(uri,
                                mode: LaunchMode.externalApplication);
                          }
                        },
                        child: Text(
                          sponsor['website']!,
                          style: TextStyle(
                            fontFamily: "Orbitron",
                            fontSize: isMobile ? 12 : 14,
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
