import 'package:naqra_web/models/card_type.dart';
import 'package:naqra_web/models/contact_info_item.dart';

class Profile {
  final String name;
  final String bio;
  final List<String> keywords;
  final String title;
  final List<ContactInfo> contacts;
  final String locationUrl;
  Profile({
    required this.name,
    required this.bio,
    required this.keywords,
    required this.title,
    required this.contacts,
    required this.locationUrl
  });
}

class ContactInfo {
  CardType cardType;
  List<ContactInfoItem> contactItems;

    ContactInfo({required this.cardType, required this.contactItems});

  @override @override
  String toString() 
  {
    String text = '${cardType.label}:  }';
    for(var item in contactItems)
    {
        text += '\n-${item.value}';
    }
    return text;
  }
}