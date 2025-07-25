import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:naqra_web/models/card_type.dart';

class CardTypeProvider extends StateNotifier<List<CardType>> {
  CardTypeProvider() : super(List.from(CardType.values));

  void remove(CardType type) {
    if (state.contains(type)) {
      state = [...state]..remove(type);
    }
  }

  void add(CardType type) {
    if (!state.contains(type)) {
      state = [...state, type];
    }
  }

  void reset() {
    state = List.from(CardType.values);
  }
}

final cardTypeProvider =
    StateNotifierProvider<CardTypeProvider, List<CardType>>(
      (ref) => CardTypeProvider(),
    );
