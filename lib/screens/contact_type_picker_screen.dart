import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:naqra_web/providers/card_type_provider.dart';
import '../models/card_type.dart';
import '../models/contact_info.dart';

import '../providers/contact_info_provider.dart';

class ContactTypePickerScreen extends ConsumerWidget {
  const ContactTypePickerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final availableTypes = ref.watch(cardTypeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Contact Type'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          children:
              availableTypes.map((type) {
                return ActionChip(
                  avatar: Icon(type.icon, size: 18),
                  label: Text(type.label),
                  backgroundColor: Colors.grey[200],
                  onPressed: () {
                    // 1. Remove from available types
                    ref.read(cardTypeProvider.notifier).remove(type);

                    // 2. Add to contact fields manager
                    ref.read(contactInfoProvider.notifier).addField(type);

                    // 3. Optional: Pop screen after selection
                    Navigator.pop(context);
                  },
                );
              }).toList(),
        ),
      ),
    );
  }
}
