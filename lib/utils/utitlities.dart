
import 'dart:typed_data';
import 'dart:html' as html;

import 'package:naqra_web/models/card_type.dart';
import 'package:naqra_web/models/contact_info_item.dart';
import 'package:naqra_web/models/profile.dart';
import 'package:url_launcher/url_launcher.dart';

class Utitlities {

static String truncate(String val, [int max = 26]) {
  return (val.length <= max) ? val : '${val.substring(0, max)}...';
}




static void downloadVCard(Profile userProfile) {
  final contactVCards = _contactListToVCard(userProfile.contacts);

  final vCard = '''
BEGIN:VCARD
VERSION:3.0
FN:${userProfile.name}
TITLE:${userProfile.title}
$contactVCards
END:VCARD
''';

  final bytes = Uint8List.fromList(vCard.codeUnits);
  final blob = html.Blob([bytes]);
  final url = html.Url.createObjectUrlFromBlob(blob);
  final anchor = html.AnchorElement(href: url)
    ..setAttribute("download", "${userProfile.name}.vcf")
    ..click();
  html.Url.revokeObjectUrl(url);
}


static String _contactListToVCard(List<ContactInfo> contacts) {
  final buffer = StringBuffer();

  for (var contact in contacts) {
    for (var item in contact.contactItems) {
      final type = item.type.vCardType;
      switch (contact.cardType) {
        case CardType.phone:
          buffer.writeln('TEL;TYPE=$type:${item.value}');
          break;
        case CardType.email:
          buffer.writeln('EMAIL;TYPE=$type:${item.value}');
          break;
        case CardType.website:
          buffer.writeln('URL:${item.value}');
          break;
        default:
          break;
      }
    }
  }

  return buffer.toString();
}

static Future<void> openExternalLink(String url) async {
  final Uri uri = Uri.parse(url);

  if (await canLaunchUrl(uri)) {
    await launchUrl(
      uri,
      mode: LaunchMode.externalApplication, // Ensures external browser or app
    );
  } else {
    throw 'Could not launch $url';
  }
}



}

/*
 *BEGIN:VCARD
VERSION:3.0
FN:John Doe
TEL;TYPE=CELL:+1234567890
TEL;TYPE=WORK:+1987654321
TEL;TYPE=FAX:+4412345678
EMAIL;TYPE=INTERNET;TYPE=WORK:john.doe@company.com
EMAIL;TYPE=HOME:john.doe@gmail.com
URL:https://johndoe.com
URL:https://linkedin.com/in/johndoe
ADR;TYPE=WORK:;;123 Business Rd;New York;NY;10001;USA
ADR;TYPE=HOME:;;789 Home St;Los Angeles;CA;90001;USA
ORG:Acme Inc.
TITLE:Senior Developer
*END:VCARD
 */

