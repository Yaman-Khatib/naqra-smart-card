import 'package:naqra_web/models/card_type.dart';
import 'package:naqra_web/models/contact_info_item.dart';

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