import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:naqra_web/adapters/profile_adapter.dart';
import 'package:naqra_web/models/profile.dart';
import 'package:naqra_web/pages/profile_skeleton.dart';
import 'package:naqra_web/utils/utitlities.dart';
import 'package:naqra_web/widgets/cards/contact_card.dart';
import 'package:naqra_web/widgets/map.dart';
import 'package:naqra_web/widgets/skillCard.dart';

class ViewContactScreen extends StatefulWidget {
  const ViewContactScreen({super.key});

  @override
  State<ViewContactScreen> createState() => _ViewContactScreenState();
}

class _ViewContactScreenState extends State<ViewContactScreen> {
  bool isLoading = true;
  bool profileNotFound = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getProfile();
  }
  Profile? userProfile;
  void _getProfile() async
  {
    setState(() {
    isLoading = true;      
    });
     userProfile = await MockProfileAdapter().fetchProfile('N500C');
    setState(() {
      isLoading = false;
      profileNotFound = (userProfile == null); //If the fetched user is null so profile doesnt exist
    });
  }
  @override
  Widget build(BuildContext context) {
    print('viewing contact');

    return (isLoading) ? ProfileSkeleton() : buildRealProfile(context,userProfile!);
  }

  static Widget _tagChip(BuildContext context, String text) {
    final theme = Theme.of(context);
    return Chip(
      label: Text(text),
      backgroundColor: theme.colorScheme.surfaceContainerHighest,
      padding: const EdgeInsets.symmetric(horizontal: 8),
    );
  }

  static Widget buildRealProfile(BuildContext context, Profile userProfile) {
    final screenWidth = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Text(
                  'Naqra',
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            height: 160,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.surfaceContainerHighest,
                              borderRadius: BorderRadius.circular(12),
                              image: const DecorationImage(
                                image: AssetImage('assets/images/cover.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: -22,
                            child: CircleAvatar(
                              radius: 50,
                              backgroundColor: theme.colorScheme.surface,
                              child: const CircleAvatar(
                                radius: 48,
                                backgroundImage: AssetImage(
                                  'assets/images/avatar.jpg',
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 120),
                        ],
                      ),
                      const SizedBox(height: 40),

                      Center(
                        child: Column(
                          children: [
                            Text(
                              // 'Yaman AlKhatib',
                              userProfile.name,
                              style: textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              // 'Creative UI / UX designer',,
                              userProfile.title,
                              style: textTheme.bodySmall?.copyWith(
                                color: theme.hintColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 8,
                        children: [
                          ...userProfile.keywords.map((skill)=> SkillCard(context, screenWidth, skill))
                          // SkillCard(context, screenWidth, 'Flutter'),
                          // SkillCard(context, screenWidth, 'Rest APIs'),
                          // SkillCard(context, screenWidth, '.Net'),
                        ],
                      ),
                      const SizedBox(height: 16),
                      IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Quote line
                            Container(
                              width: 3,
                              margin: const EdgeInsets.only(right: 12),
                              color: Colors.grey,
                            ),

                            // Wrapping text
                            Flexible(
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: screenWidth * 0.8,
                                ),
                                child: Text(
                                  userProfile.bio,
                                  // 'Building rust applications that are scalable\nCompleted over 15 desktop projects\nMy vision is making clients happy.\nI always say the client is always true.\nWaiting for you.',
                                  style: textTheme.bodySmall,
                                  textAlign: TextAlign.left,
                                  softWrap: true,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 26),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xff181818),
                      Color.fromARGB(195, 24, 24, 24),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Utitlities.downloadVCard(userProfile);
                  },
                  icon: Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: const Icon(Icons.contacts),
                  ),
                  label: const Text("Save contact"),
                ),
              ),
              // ],
              // ),
              const SizedBox(height: 16),

              ...userProfile.contacts.map((contact)=> ContactCard(contactInfo: contact)),
              // ContactCard(cardType: contact.cardType, values: [...contact.contactItems.map((item)=> item.value)])),
              
              const SizedBox(height: 24),

              Row(
                children: [
                  SizedBox(width: 12),
                  Icon(
                    FontAwesomeIcons.locationDot,
                    color: theme.primaryColor,
                    size: 20,
                  ),
                  SizedBox(width: 16),
                  Text(
                    "My location",
                    style: textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.primaryColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              MapWidget(userProfile.locationUrl),
              const SizedBox(height: 8),
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: const Text("Tap the map to view in Google Maps"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
