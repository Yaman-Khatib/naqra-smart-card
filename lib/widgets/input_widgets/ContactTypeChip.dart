import 'package:flutter/material.dart';
import 'package:naqra_web/models/card_type.dart';

class ContactTypeChip extends StatelessWidget {
  final CardType type;
  final VoidCallback onSelected;

  const ContactTypeChip({
    super.key,
    required this.type,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: ActionChip(
        avatar: Icon(type.icon, size: 18, color: theme.primaryColor),
        label: Text(type.label),
        labelStyle: const TextStyle(fontWeight: FontWeight.w500),
        side: BorderSide(color: Colors.grey.shade400),
        backgroundColor: Colors.grey.shade100,
        onPressed: onSelected,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
