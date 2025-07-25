import 'package:flutter/material.dart';
import 'package:naqra_web/models/card_type.dart';
import 'package:naqra_web/widgets/input_widgets/contact_input_widget.dart';

class ContactInputCardWithDragHandle extends StatelessWidget {
  final CardType type;
  final Key reorderKey;

  const ContactInputCardWithDragHandle({
    super.key,
    required this.type,
    required this.reorderKey,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 26, top: 12),
          child: ContactInputCard(type: type),
        ),

        // Correctly positioned and working drag handle
        Positioned(
          top: 35,
          left: 1,
          child: ReorderableDragStartListener(
            index: int.parse(
              reorderKey.toString().replaceAll(RegExp(r'\D'), ''),
            ), // safer if you have actual index
            child: const Icon(
              Icons.drag_indicator,
              size: 20,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
