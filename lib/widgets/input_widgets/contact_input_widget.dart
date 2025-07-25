import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:naqra_web/models/card_type.dart';

import 'package:naqra_web/models/contact_info_item.dart';
import 'package:naqra_web/providers/card_type_provider.dart';
import 'package:naqra_web/providers/contact_info_provider.dart';
import 'package:naqra_web/providers/contact_validation_status.dart';
import 'package:naqra_web/providers/resume_provider.dart';
import 'package:naqra_web/utils/validations.dart';





class ContactInputCard extends ConsumerStatefulWidget {
  final CardType type;   

   const ContactInputCard({
    super.key,
    required this.type,    
  });

  @override
  ConsumerState<ContactInputCard> createState() => _ContactInputCardState();
}

class _ContactInputCardState extends ConsumerState<ContactInputCard> {
  final List<TextEditingController> controllers = [TextEditingController()];
  final List<FocusNode> focusNodes = [FocusNode()];
  final List<bool> showErrors = [false];

  String? uploadedFileName;

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < focusNodes.length; i++) {
      focusNodes[i].addListener(() => _validateField(i));
    }

  }

  @override
  void dispose() {
    for (var c in controllers) {
      c.dispose();
    }
    for (var f in focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  bool _validateAll() {
    bool isValid = true;
    for (int i = 0; i < controllers.length; i++) {
      final valid = _isValid(controllers[i].text);
      showErrors[i] = !valid;
      if (!valid) isValid = false;
    }

      ref
      .read(contactValidationStatusProvider.notifier)
      .setStatus(widget.type, isValid);

    setState(() {}); // Trigger UI update for error styling
    return isValid;
  }

  void _validateField(int index) {
    if (!focusNodes[index].hasFocus) {
      final isValid = _isValid(controllers[index].text);
      setState(() {
        showErrors[index] = !isValid;
      });
    }
  }

  bool _isValid(String value) {
    final regex = RegExp(widget.type.validationRegex);
    return regex.hasMatch(value);
  }

  void _addField() {
    setState(() {
      controllers.add(TextEditingController());
      focusNodes.add(
        FocusNode()..addListener(() => _validateField(controllers.length - 1)),
      );
      showErrors.add(false);
    });
  }

  void _removeField(int index) {
    setState(() {
      ref.read(contactInfoProvider.notifier).removeItemFromField(
            widget.type,
            ContactInfoItem(value: controllers[index].text, type: ContactItemType.other),
          );
      controllers.removeAt(index);
      focusNodes.removeAt(index);
      showErrors.removeAt(index);
    });
  }

  void _deleteEntireSection() {
    setState(() {
      controllers.clear();
      focusNodes.clear();
      showErrors.clear();
      if (widget.type == CardType.resume) {
        uploadedFileName = null;
      }
      ref.read(contactInfoProvider.notifier).removeField(widget.type);
      ref.read(cardTypeProvider.notifier).add(widget.type);
    });
  }

  Future<void> _pickPdfFile() async {
    final result = await Validations.pickPdfFile();

    if (result != null) {
      final pickedFile = result;
      final name = pickedFile.name;

      setState(() {
        uploadedFileName = name;
      });

      if (kIsWeb) {
        final bytes = pickedFile.bytes;
        if (bytes == null) return;

        ref.read(pdfFileProvider.notifier).setFile(bytes, name);

        ref.read(contactInfoProvider.notifier).removeField(widget.type);
        ref.read(contactInfoProvider.notifier).addField(widget.type);
        ref.read(contactInfoProvider.notifier).addItemToField(
              widget.type,
              ContactInfoItem(
                value: 'https://url-tosupabase-manually.com',
                type: ContactItemType.other,
              ),
            );
      } else {
        final path = pickedFile.path;
        if (path == null) return;

        ref.read(contactInfoProvider.notifier).removeField(widget.type);
        ref.read(contactInfoProvider.notifier).addField(widget.type);
        ref.read(contactInfoProvider.notifier).addItemToField(
              widget.type,
              ContactInfoItem(value: path, type: ContactItemType.other),
            );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Focus(
      onFocusChange: (hasFocus) 
      {
        if(!hasFocus)
        {
         _validateAll();
        }
      } ,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
          color: theme.cardColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(widget.type.icon, color: theme.primaryColor),
                    const SizedBox(width: 8),
                    Text(
                      widget.type.label,
                      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  tooltip: 'Remove this contact type',
                  onPressed: _deleteEntireSection,
                ),
              ],
            ),
            const SizedBox(height: 12),
      
            if (widget.type == CardType.resume)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.upload_file),
                    label: Text(
                      uploadedFileName == null ? 'Select PDF Resume' : 'Replace Resume',
                    ),
                    onPressed: _pickPdfFile,
                  ),
                  if (uploadedFileName != null) ...[
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Text('Selected file: '),
                        Expanded(
                          child: Text(
                            uploadedFileName!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              )
            else
              Column(
                children: [
                  ...List.generate(controllers.length, (index) {
                    final controller = controllers[index];
                    final showError = showErrors[index];
      
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        children: [
                          Expanded(
                            child: Focus(
                              onFocusChange: (hasFocus) {
                                if (!hasFocus) {
                                  final value = controller.text;
                                  final isValid = _isValid(value);
                                  setState(() {
                                    showErrors[index] = !isValid;
                                  });
      
                                  final notifier = ref.read(contactInfoProvider.notifier);
                                  if (isValid) {
                                    notifier.addItemToField(
                                      widget.type,
                                      ContactInfoItem(value: value, type: ContactItemType.other),
                                    );                                  
                                  } 
                                    
                                  
                                }
                              },
                              child: TextFormField(
                                controller: controller,
                                focusNode: focusNodes[index],
                                style: theme.textTheme.bodyMedium?.copyWith(color: Colors.black),
                                decoration: InputDecoration(
                                  hintText: widget.type.placeholder,
                                  hintStyle: TextStyle(color: Colors.grey[500]),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  errorText: showError ? widget.type.placeholder : null,
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(color: Colors.red),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: showError ? Colors.red : theme.primaryColor,
                                      width: 1.5,
                                    ),
                                  ),
                                  suffixIcon: controller.text.isNotEmpty && _isValid(controller.text)
                                      ? const Icon(Icons.check_circle, color: Colors.green)
                                      : null,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    showErrors[index] = !_isValid(value);
                                  });
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          if (controllers.length > 1)
                            IconButton(
                              onPressed: () => _removeField(index),
                              icon: const Icon(Icons.remove_circle, color: Colors.red),
                            ),
                        ],
                      ),
                    );
                  }),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.add_circle, color: Colors.blue),
                        onPressed: _addField,
                        tooltip: 'Add another ${widget.type.label.toLowerCase()}',
                      ),
                      Text(
                        'Add more ${widget.type.label.toLowerCase()}',
                        style: theme.textTheme.bodySmall?.copyWith(color: theme.primaryColor),
                      ),
                    ],
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
