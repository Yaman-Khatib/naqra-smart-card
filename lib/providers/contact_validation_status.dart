import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/card_type.dart';

class ContactValidationStatusNotifier extends StateNotifier<Map<CardType, bool>> {
  ContactValidationStatusNotifier() : super({});

  /// Sets the validation status of a specific card type
  void setStatus(CardType type, bool isValid) {
    state = {
      ...state,
      type: isValid,
    };
  }

  /// Gets the status (returns null if not set)
  bool? getStatus(CardType type) => state[type];

  /// Resets all statuses
  void reset() => state = {};
}

final contactValidationStatusProvider =
    StateNotifierProvider<ContactValidationStatusNotifier, Map<CardType, bool>>(
        (ref) => ContactValidationStatusNotifier());