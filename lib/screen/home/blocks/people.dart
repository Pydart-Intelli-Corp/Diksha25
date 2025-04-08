import 'package:flutter/material.dart';
import 'package:flutter_website/components/icons.dart';
import 'package:flutter_website/components/spacing.dart';
import 'package:flutter_website/core/extensions/color_extensions.dart';

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
  final List<Map<String, dynamic>> coSponsors = [
    {
      'name': '',
      'logo': 'assets/logos/pydartw.png',
      'width': 250.0,
      'height': 200.0,
    },
    {
      'name': '',
      'logo': 'assets/logos/brickly.png',
      'width': 400.0,
      'height': 300.0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 600;
    return Container(
      width: double.infinity,
      margin: blockMargin.copyWith(top: 40, bottom: 40),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 0,
            spreadRadius: 2,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(0),
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: const AssetImage('assets/images/diksha/team.jpg'),
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
                      AppColors.primary.withOpacity(0.1),
                      AppColors.secondary.withOpacity(0.3),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: blockPadding(context).copyWith(top: 40, bottom: 60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        buildMaterialIconCircle(
                          "assets/logos/diksha/dikshalogoyellownoletter.png",
                          48,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Wisdom Circle",
                                style: TextStyle(
                                  fontFamily: "Orbitron",
                                  color: Colors.white,
                                  fontSize: isMobile ? 24 : 32,
                                  fontWeight: FontWeight.w600,
                                  height: 1.2,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Learn. Lead. Inspire.",
                                style: TextStyle(
                                  fontFamily: "Orbitron",
                                  color: AppColors.whitegrey,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Team Members Section
                  isMobile
                      ? GridView.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: teamMembers
                              .map((member) => _buildTeamMemberCard(
                                    member,
                                    isMobile: isMobile,
                                  ))
                              .toList(),
                        )
                      : SizedBox(
                          height: 220, // Compact height for team members
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            itemCount: teamMembers.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: _buildTeamMemberCard(
                                  teamMembers[index],
                                  isMobile: isMobile,
                                ),
                              );
                            },
                          ),
                        ),
                  const SizedBox(height: 30),
                  // FAQ Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "FAQs",
                          style: TextStyle(
                            fontFamily: "Orbitron",
                            color: Colors.white,
                            fontSize: isMobile ? 20 : 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ...faqItems.asMap().entries.map((entry) {
                          final index = entry.key;
                          final faq = entry.value;
                          return _buildFAQItem(
                            question: faq['question']!,
                            answer: faq['answer']!,
                            isExpanded: _isExpanded[index],
                            onTap: () => setState(
                                () => _isExpanded[index] = !_isExpanded[index]),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  // New Co Sponsors Section with individualized logo sizes
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Co Sponsors",
                            style: TextStyle(
                              fontFamily: "Orbitron",
                              color: Colors.black87,
                              fontSize: isMobile ? 20 : 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: coSponsors.map((sponsor) {
                              return Column(
                                children: [
                                  Image.asset(
                                    sponsor['logo']!,
                                    width: sponsor['width'],
                                    height: sponsor['height'],
                                    fit: BoxFit.contain,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    sponsor['name']!,
                                    style: TextStyle(
                                      fontFamily: "Orbitron",
                                      color: Colors.black54,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQItem({
    required String question,
    required String answer,
    required bool isExpanded,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppColors.diksha.withOpacity(isExpanded ? 0.3 : 0.15),
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        question,
                        style: TextStyle(
                          fontFamily: "Orbitron",
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Icon(
                      isExpanded ? Icons.expand_less : Icons.expand_more,
                      color: AppColors.diksha,
                      size: 20,
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
                      fontSize: 12,
                      height: 1.4,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTeamMemberCard(Map<String, String> member,
      {required bool isMobile}) {
    // Remove newline characters from the name when on mobile
    final String displayName =
        isMobile ? member['name']!.replaceAll('\n', '') : member['name']!;
    return Container(
      width: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color.fromARGB(90, 0, 0, 0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(member['image']!),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              displayName,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Orbitron",
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 2,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            member['role']!,
            style: TextStyle(
              fontFamily: "Orbitron",
              color: AppColors.diksha,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            member['bio']!,
            style: TextStyle(
              fontFamily: "Orbitron",
              color: Colors.white70,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
