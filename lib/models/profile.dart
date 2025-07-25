import 'package:naqra_web/models/card_type.dart';
import 'package:naqra_web/models/contact_info.dart';
import 'package:naqra_web/models/contact_info_item.dart';

class Profile {
  final String name;
  final String bio;
  final List<String> keywords;
  final String title;
  final List<ContactInfo> contacts;
  
  Profile({
    required this.name,
    required this.bio,
    required this.keywords,
    required this.title,
    required this.contacts,
    
  });
}
