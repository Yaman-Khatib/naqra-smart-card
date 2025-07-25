import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:naqra_web/models/card_type.dart';
import 'package:naqra_web/providers/contact_info_provider.dart';
import 'package:naqra_web/screens/contact_type_picker_screen.dart';
import 'package:naqra_web/widgets/input_widgets/contact_input_card_with_drag_handler.dart';
import 'package:naqra_web/widgets/input_widgets/contact_input_widget.dart';
import 'package:naqra_web/models/contact_info.dart';

class ContactFieldsSection extends ConsumerStatefulWidget {
  const ContactFieldsSection({super.key});

  @override
  ConsumerState<ContactFieldsSection> createState() =>
      ContactFieldsSectionState();
}

class ContactFieldsSectionState extends ConsumerState<ContactFieldsSection> {
  void _openTypePicker() {
    showDialog(
      context: context,
      builder: (context) => const ContactTypePickerScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final contactFields = ref.watch(contactInfoProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact Information',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),

        if (contactFields.isEmpty)
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                'No contact methods added yet.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.hintColor,
                ),
              ),
            ),
          )
        else
          ReorderableListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: contactFields.length,
            buildDefaultDragHandles: false, // Hide default drag icon
            onReorder: (oldIndex, newIndex) {
              ref
                  .read(contactInfoProvider.notifier)
                  .reorderFields(oldIndex, newIndex);

              ref.read(contactInfoProvider).forEach((field) {
                print(field.cardType.label);
              });
            },
            itemBuilder: (context, index) {
              final contactInfo = contactFields[index];
              return Padding(
                key: ValueKey(index), // Use index for drag key
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ContactInputCardWithDragHandle(
                  reorderKey: ValueKey(index),
                  type: contactInfo.cardType,
                ),
              );
            },
          ),

        const SizedBox(height: 12),

        Align(
          alignment: Alignment.centerLeft,
          child: TextButton.icon(
            onPressed: _openTypePicker,
            icon: const Icon(Icons.add),
            label: const Text('Add Contact Method'),
            style: TextButton.styleFrom(
              foregroundColor: theme.primaryColor,
              textStyle: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ),

        const SizedBox(height: 24),
      ],
    );
  }
}
