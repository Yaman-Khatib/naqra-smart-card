// ContactType defines the overall card category (e.g., Phone, Email).
// ContactItemType specifies the type of each individual contact detail
// inside the card (e.g., mobile, work, fax for phone numbers).
// This separation allows better organization and handling of contact info.

enum ContactItemType {
  mobile,
  phone,
  work,
  home,
  email,
  website,
  other,
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
