// ContactType defines the overall card category (e.g., Phone, Email).
// ContactItemType specifies the type of each individual contact detail
// inside the card (e.g., mobile, work, fax for phone numbers).
// This separation allows better organization and handling of contact info.

enum ContactItemType {
  mobile,  
  work,
  home,
  email,
  website,
  other,
}

extension ContactItemTypeVCardExtension on ContactItemType {
  String get vCardType {
    switch (this) {
      case ContactItemType.mobile:
        return 'CELL';              
      case ContactItemType.work:
        return 'WORK';
      case ContactItemType.home:
        return 'HOME';
      case ContactItemType.email:
        return 'EMAIL'; // not always needed, but good for clarity
      case ContactItemType.website:
        return 'URL';   // VCARD uses URL, not WEBSITE
      case ContactItemType.other:
        return 'OTHER';
    }
  }
}

class ContactInfoItem {
  final String value; // The phone number, email, or URL string
  final ContactItemType type;

  ContactInfoItem({
    required this.value,
    required this.type,
  });

  @override
  String toString() => 'ContactInfoItem(type: $type, value: $value)';
}
