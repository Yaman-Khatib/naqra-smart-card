import 'package:flutter/material.dart';
import 'package:naqra_web/models/card_type.dart';


class ContactTypeChip extends StatelessWidget {
  final CardType type;
  final VoidCallback onTap;

  const ContactTypeChip({
    super.key,
    required this.type,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Chip(
        labelPadding: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        avatar: Icon(
          type.icon,
          size: 18,
          color: theme.colorScheme.primary,
        ),
        label: Text(
          type.label,
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w500,
            color: theme.colorScheme.onSurface,
          ),
        ),
        backgroundColor: theme.colorScheme.surfaceContainerHighest.withOpacity(0.8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: BorderSide(color: theme.dividerColor),
        ),
      ),
    );
  }
}
