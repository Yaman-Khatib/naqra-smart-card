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
  x, // Twitter
  tiktok,
  linkedin,
  resume, // The same as CV ..OK habib?!
  whatsapp,
  telegram,
  youtube,
  map,
  snapchat,
  github,
  payment,
  // calendar,
  custom,
  location,
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
      case CardType.whatsapp:
        return "WhatsApp";
      case CardType.telegram:
        return "Telegram";
      case CardType.youtube:
        return "YouTube";
      case CardType.location:
        return "Location";
      case CardType.map:
        return "Map";
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
      case CardType.phone:
        return FontAwesomeIcons.phone;

      case CardType.email:
        return FontAwesomeIcons.envelope;

      case CardType.website:
        return FontAwesomeIcons.globe;

      case CardType.facebook:
        return FontAwesomeIcons.facebook;

      case CardType.instagram:
        return FontAwesomeIcons.instagram;

      case CardType.x:
        return FontAwesomeIcons.xTwitter; // FontAwesomeIcons.twitter also works

      case CardType.tiktok:
        return FontAwesomeIcons.tiktok;

      case CardType.linkedin:
        return FontAwesomeIcons.linkedin;

      case CardType.resume:
        return FontAwesomeIcons.filePdf;

      case CardType.whatsapp:
        return FontAwesomeIcons.whatsapp;

      case CardType.telegram:
        return FontAwesomeIcons.telegram;

      case CardType.youtube:
        return FontAwesomeIcons.youtube;

      case CardType.snapchat:
        return FontAwesomeIcons.snapchat;

      case CardType.github:
        return FontAwesomeIcons.github;

      case CardType.payment:
        return FontAwesomeIcons.creditCard;
      case CardType.location:
        return FontAwesomeIcons.locationDot;
      case CardType.custom:
        return FontAwesomeIcons.circleQuestion;

      default:
        return FontAwesomeIcons.circleQuestion;
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
      case CardType.youtube:
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

      case CardType.map:
        return 'locations';

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

  String get placeholder {
    switch (this) {
      case CardType.phone:
        return 'e.g. +963987654321';

      case CardType.email:
        return 'e.g. example@email.com';

      case CardType.facebook:
        return 'facebook.com/yourprofile';

      case CardType.website:
        return 'https://yourwebsite.com';

      case CardType.instagram:
        return 'instagram.com/username';

      case CardType.x:
        return 'x.com/yourhandle';

      case CardType.tiktok:
        return 'tiktok.com/@username';

      case CardType.linkedin:
        return 'linkedin.com/in/yourname';

      case CardType.resume:
        return 'Link to your resume (PDF/Google Drive/etc)';

      case CardType.whatsapp:
        return 'e.g. https://wa.me/+963987654321';
      // return 'e.g. wa.me/123456789 or api.whatsapp.com/send?phone=123456789';

      case CardType.telegram:
        return 'telegram.me/@username or t.me/username';

      case CardType.youtube:
        return 'youtube.com/channel/yourchannelid';

      case CardType.snapchat:
        return 'snapchat.com/add/username';

      case CardType.github:
        return 'github.com/username';

      case CardType.payment:
        return 'Link to payment page (e.g., PayPal, Wise, etc)';
      case CardType.location:
        return 'e.g. https://maps.app.goo.gl/xyz123';
      case CardType.custom:
        return 'Enter a valid value';

      default:
        return '';
    }
  }

  String get validationRegex {
    switch (this) {
      case CardType.email:
        return r'^[^\s@]+@[^\s@]+\.[^\s@]+$';

      case CardType.website:
      case CardType.custom:
        return r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+';
      case CardType.linkedin:
        return r'^(https?:\/\/)?(www\.)?linkedin\.com\/in\/[A-z0-9_-]+\/?$';

      case CardType.youtube:
        return r'^(https?:\/\/)?(www\.)?youtube\.com\/(channel|c|user)\/[A-z0-9_-]+\/?$';

      case CardType.facebook:
        return r'^(https?:\/\/)?(www\.)?facebook\.com\/[A-z0-9_.-]+\/?$';

      case CardType.instagram:
        return r'^(https?:\/\/)?(www\.)?instagram\.com\/[A-z0-9_.]+\/?$';

      case CardType.x:
        return r'^(https?:\/\/)?(www\.)?(twitter|x)\.com\/[A-z0-9_]+\/?$';

      case CardType.tiktok:
        return r'^(https?:\/\/)?(www\.)?tiktok\.com\/@[\w.]+\/?$';

      case CardType.telegram:
        return r'^(https?:\/\/)?(t(elegram)?\.me|telegram\.org)\/@?[a-zA-Z0-9_]{5,32}$';

      case CardType.snapchat:
        return r'^(https?:\/\/)?(www\.)?snapchat\.com\/add\/[A-z0-9._]+\/?$';

      case CardType.github:
        return r'^(https?:\/\/)?(www\.)?github\.com\/[A-z0-9_-]+\/?$';
      case CardType.location:
        return r'^(https?:\/\/)?(maps\.app\.goo\.gl|goo\.gl\/maps|maps\.google\.com)\/[^\s]+$';
      case CardType.resume:
      case CardType.payment:
      case CardType.phone:
        return r'^\+?[0-9]{7,15}$';

      case CardType.whatsapp:
        return r'^(https?:\/\/)?(wa\.me\/\d{7,15}|api\.whatsapp\.com\/send\?phone=\d{7,15})$';

      default:
        return r'.+'; // Non-empty fallback
    }
  }
}
