/// Supported card types for contact/social links.
library;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
enum CardType {
  phone,
  // mobile,
  email,
  facebook,
  website,
  instagram,
  x,            // Twitter
  tiktok,
  linkedin,
  resume,       // The same as CV ..OK habib?!
  // whatsapp,
   telegram,
   youtube,  
  snapchat,
  github,
  payment,
  // calendar,
  custom, 
}

/// Extension to add useful properties to CardType.
extension CardTypeProperties on CardType {
  /// Returns a human-friendly label.
  String get label {
    switch (this) {
      case CardType.phone:
        return "Phone";
        // case CardType.mobile:
        // return "Mobile";
      case CardType.email:
        return "Email";
      case CardType.facebook:
        return "Facebook";
      case CardType.website:
        return "Website";
      case CardType.instagram:
        return "Instagram";
      case CardType.x:
        return "X (Twitter)";
      case CardType.tiktok:
        return "TikTok";
      case CardType.linkedin:
        return "LinkedIn";
        case CardType.resume:
        return "Resume";
      // case CardType.whatsapp:
      //   return "WhatsApp";
       case CardType.telegram:
         return "Telegram";
       case CardType.youtube:
         return "YouTube";
      // case CardType.address:
      //   return "Address";
      // case CardType.maps:
      //   return "Maps";
      case CardType.snapchat:
        return "Snapchat";
      case CardType.github:
        return "GitHub";
      case CardType.payment:
        return "Payment";
      // case CardType.calendar:
      //   return "Calendar";
      case CardType.custom:
        return "Custom";
    }
  }

  /// Returns the icon representing this card type.
  IconData get icon {
    switch (this) {
      // case CardType.mobile:
      //   return FontAwesomeIcons.mobileScreen;
      case CardType.phone:
      return FontAwesomeIcons.phone;  
      case CardType.email:
        return Icons.email;
      case CardType.facebook:
        return Icons.facebook;
      case CardType.website:
        return Icons.language;
      case CardType.instagram:
        return FontAwesomeIcons.instagram;
      case CardType.x:
        return FontAwesomeIcons.xTwitter; 
      case CardType.tiktok:
        return FontAwesomeIcons.tiktok;
      case CardType.linkedin:
        return FontAwesomeIcons.linkedin;
        case CardType.resume:
  return FontAwesomeIcons.fileLines;
      // case CardType.whatsapp:
      //   return Icons.chat;
       case CardType.telegram:
         return Icons.send;
       case CardType.youtube:
      //   return Icons.ondemand_video;
      // case CardType.address:
      //   return Icons.home;
      // case CardType.maps:
      //   return Icons.map;
      case CardType.snapchat:
        return FontAwesomeIcons.snapchat;
      case CardType.github:
        return FontAwesomeIcons.github;
      case CardType.payment:
        return FontAwesomeIcons.moneyBill;
      // case CardType.calendar:
      //   return Icons.calendar_today;
      case CardType.custom:
        return Icons.star;
    }
  }

    String get countLabel {
    switch (this) {
      case CardType.instagram:      
      case CardType.facebook:
      case CardType.x:
      case CardType.tiktok:
      case CardType.linkedin:
      case CardType.snapchat:
      // case CardType.telegram:
      // case CardType.youtube:
      case CardType.github:
        return 'accounts';

      case CardType.phone:
      // case CardType.mobile:
        return 'numbers';

      case CardType.email:
        return 'emails';

      case CardType.website:
        return 'websites';

      // case CardType.address:
      //   return 'addresses';

      // case CardType.maps:
      //   return 'locations';

      // case CardType.whatsapp:
      //   return 'contacts';

      case CardType.payment:
        return 'methods';

      // case CardType.calendar:
      //   return 'events';

      case CardType.custom:
        return 'items';

      default:
        return 'items';
    }
  }
}
