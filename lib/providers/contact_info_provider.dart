import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:naqra_web/models/contact_info_item.dart';
import '../models/contact_info.dart';
import '../models/card_type.dart';



class ContactInfoNotifier extends StateNotifier<List<ContactInfo>> {
  ContactInfoNotifier() : super([]);

  /// Add a new field (card type) with an empty list of items
  void addField(CardType type) {
    if (state.any((info) => info.cardType == type)) return;
    state = [...state, ContactInfo(cardType: type, contactItems: [])];
  }

  /// Remove a full contact field
  void removeField(CardType type) {
    state = state.where((info) => info.cardType != type).toList();
  }

  void reorderFields(int oldIndex, int newIndex) {
  final updated = [...state];
  final item = updated.removeAt(oldIndex);
  updated.insert(newIndex > oldIndex ? newIndex - 1 : newIndex, item);
  state = updated;
}


  /// Add a ContactInfoItem to a specific field
  void addItemToField(CardType type, ContactInfoItem item) {
    state = state.map((info) {
      if (info.cardType == type) {
        return ContactInfo(
          cardType: info.cardType,
          contactItems: [...info.contactItems, item],
        );
      }
      return info;
    }).toList();
  }

  /// Remove a specific ContactInfoItem from a field
  void removeItemFromField(CardType type, ContactInfoItem item) {
    state = state.map((info) {
      if (info.cardType == type) {
        return ContactInfo(
          cardType: info.cardType,
          contactItems: info.contactItems.where((i) => i != item).toList(),
        );
      }
      return info;
    }).toList();
  }
  
  void upsertItemToField(CardType type, ContactInfoItem item) {
  state = state.map((info) {
    if (info.cardType == type) {
      final items = [...info.contactItems];
      final index = items.indexWhere((i) => i.value == item.value);
      if (index != -1) {
        items[index] = item; // update
      } else {
        items.add(item); // add
      }
      return ContactInfo(cardType: info.cardType, contactItems: items);
    }
    return info;
  }).toList();
}



}

/// ✅ Riverpod Provider for ContactInfoNotifier
final contactInfoProvider =
    StateNotifierProvider<ContactInfoNotifier, List<ContactInfo>>(
  (ref) => ContactInfoNotifier(),
);
