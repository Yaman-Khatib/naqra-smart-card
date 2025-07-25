import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:naqra_web/models/card_type.dart';
import 'package:naqra_web/providers/contact_info_provider.dart';
import 'package:naqra_web/providers/contact_validation_status.dart';
import 'package:naqra_web/widgets/input_widgets/contact_fields_section.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  final String initialName;
  final String initialFName;
  final String initialLName;

  const EditProfileScreen({
    super.key,
    required this.initialFName,
    required this.initialLName,
  }) : initialName = '$initialFName $initialLName';

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final List<String> keywords = [];
  final maxKeywords = 3;

  final _nameFocusNode = FocusNode();
  final _titleFocusNode = FocusNode();

  final int maxBioLength = 300;

  bool _nameHasError = false;
  String? _nameErrorText;
  Uint8List? avatarImage;
  Uint8List? bannerImage;
  @override
  void initState() {
    super.initState();
    nameController.text = widget.initialName;
  }

  void _addKeyword(String keyword) {
    if (keyword.trim().isNotEmpty && keywords.length < maxKeywords) {
      setState(() {
        keywords.add(keyword.trim());
      });
    }
  }

  void _removeKeyword(int index) {
    setState(() {
      keywords.removeAt(index);
    });
  }

  Future<Uint8List?> pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true, // this gives you the Uint8List
    );
    if (result != null && result.files.first.bytes != null) {
      return result.files.first.bytes!;
    }
    return null;
  }

  void _onTapAddKeyword() async {
    final newKeyword = await showDialog<String>(
      context: context,
      builder: (context) {
        String temp = '';
        return AlertDialog(
          title: const Text('Add skill/keyword'),
          content: TextField(
            autofocus: true,
            onChanged: (val) => temp = val,
            decoration: const InputDecoration(hintText: 'Enter a skill'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, null),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, temp),
              child: const Text('Add'),
            ),
          ],
        );
      },
    );

    if (newKeyword != null) {
      _addKeyword(newKeyword);
    }
  }

  bool areAllCardsValid(WidgetRef ref) {
    final statuses = ref.watch(contactValidationStatusProvider);
    return statuses.values.every((status) => status == true);
  }

  bool hasAtLeastOneContactValue(WidgetRef ref) {
    final contacts = ref.watch(contactInfoProvider);
    return contacts.any((info) => info.contactItems.isNotEmpty);
  }

  final List<CardType> allCardTypes = CardType.values.toList();

  Widget _buildKeywordChip(String keyword, int index) {
    return Chip(
      label: Text(keyword),
      deleteIcon: const Icon(Icons.close),
      onDeleted: () => _removeKeyword(index),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }

  Widget _buildAddKeywordChip() {
    return ActionChip(
      label: const Text('Click to add a keyword'),
      onPressed: _onTapAddKeyword,
      backgroundColor: Colors.grey.shade100,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("Edit Profile"), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Cover Image + Avatar Stack
            Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                  ),
                ),
                Column(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          height: 160,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: theme.colorScheme.surfaceContainerHighest,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child:
                                bannerImage != null
                                    ? Image.memory(
                                      bannerImage!,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: 160,
                                    )
                                    : Image.asset(
                                      'assets/images/default/banner.jpg',
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: 160,
                                    ),
                          ),
                        ),

                        // Upload Banner Button
                        Positioned(
                          bottom: 8,
                          left: 16,
                          child: GestureDetector(
                            onTap: () async {
                              final selectedImage = await pickImage();

                              // Only update if a new image is selected
                              if (selectedImage != null) {
                                setState(() {
                                  bannerImage = selectedImage;
                                });
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text(
                                'Upload Banner',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Avatar with camera icon
                        Positioned(
                          bottom: -22,
                          child: Stack(
                            clipBehavior: Clip.none,
                            alignment: Alignment.bottomRight,
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundColor: theme.colorScheme.surface,
                                child: CircleAvatar(
                                  radius: 48,
                                  backgroundImage:
                                      avatarImage != null
                                          ? MemoryImage(avatarImage!)
                                          : const AssetImage(
                                                'assets/images/avatar.jpg',
                                              )
                                              as ImageProvider,
                                ),
                              ),

                              // Camera IconButton with circular border
                              Positioned(
                                bottom: 5,
                                right: 5,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                      width: 2,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 4,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.camera_alt,
                                      size: 18,
                                    ),
                                    padding: const EdgeInsets.all(
                                      6,
                                    ), // controls size inside container
                                    constraints: const BoxConstraints(),
                                    splashRadius:
                                        22, // optional: customize ripple area
                                    onPressed: () async {
                                      final selectedImage = await pickImage();
                                      if (selectedImage != null) {
                                        setState(() {
                                          avatarImage = selectedImage;
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 120),
                      ],
                    ),
                    const SizedBox(height: 40), // spacing below avatar
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Name Field (REQUIRED)
            TextFormField(
              controller: nameController,
              focusNode: _nameFocusNode,
              decoration: InputDecoration(
                label: const Text.rich(
                  TextSpan(
                    text: 'Name ',
                    style: TextStyle(fontWeight: FontWeight.w600),
                    children: [
                      TextSpan(
                        text: '*',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                hintText: 'Enter your full name',
                hintStyle: TextStyle(color: Colors.grey.shade500),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                errorText: _nameHasError ? _nameErrorText : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.blue, width: 2),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.red),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.red, width: 2),
                ),
              ),
              onChanged: (val) {
                setState(() {
                  _nameHasError = val.trim().isEmpty;
                  _nameErrorText = _nameHasError ? 'Name is required' : null;
                });
              },
            ),
            const SizedBox(height: 16),

            // Position Field (optional)
            TextFormField(
              controller: titleController,
              focusNode: _titleFocusNode,
              decoration: InputDecoration(
                labelText: 'Position / Role',
                hintText: 'e.g. UX Designer, Backend Dev',
                hintStyle: TextStyle(color: Colors.grey.shade500),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.blue, width: 2),
                ),
              ),
            ),

            const SizedBox(height: 26),

            // Skills Section Header
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Skills / Keywords',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    '(Up to 3 keywords)',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.grey[600],
                      // fontStyle: FontStyle.italic,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),

            // const Divider(
            //   thickness: 1,
            //   height: 20,
            //   color: Color(0xFFE0E0E0), // light grey divider
            // ),
            // Skills Wrap
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ...keywords.asMap().entries.map(
                  (entry) => _buildKeywordChip(entry.value, entry.key),
                ),
                if (keywords.length < maxKeywords) _buildAddKeywordChip(),
              ],
            ),
            const SizedBox(height: 20),

            // Bio Field
            const Divider(
              thickness: 1,
              height: 20,
              color: Color(0xFFE0E0E0), // light grey divider
            ),

            const SizedBox(height: 20),

            TextFormField(
              controller: bioController,
              maxLines: 5,
              maxLength: maxBioLength,
              buildCounter: (
                context, {
                required int currentLength,
                required int? maxLength,
                required bool isFocused,
              }) {
                return Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    '$currentLength / $maxLength characters',
                    style: TextStyle(
                      fontSize: 12,
                      color:
                          currentLength > maxLength!
                              ? Colors.red
                              : Colors.grey.shade600,
                      fontWeight:
                          currentLength > maxLength
                              ? FontWeight.bold
                              : FontWeight.normal,
                    ),
                  ),
                );
              },
              onChanged: (text) {},
              decoration: InputDecoration(
                labelText: 'Bio',
                hintText: 'Tell about yourself...',
                hintStyle: TextStyle(color: Colors.grey.shade400),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                alignLabelWithHint: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.blue, width: 2),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.red),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Bio Field
            const Divider(
              thickness: 1,
              height: 20,
              color: Color(0xFFE0E0E0), // light grey divider
            ),
            const SizedBox(height: 15),

            //The sections for adding contact info
            const ContactFieldsSection(),

            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: () {
                final allValid = areAllCardsValid(ref);
                final hasContact = hasAtLeastOneContactValue(ref);

                if (allValid && hasContact) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text("✅ Saved successfully!"),
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating,
                      duration: const Duration(seconds: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );

                  // TODO: Save logic here (API, local DB, etc.)
                } else {
                  final message =
                      !allValid
                          ? "Please fix the invalid contact fields."
                          : "Please add at least one contact field.";

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(message),
                      backgroundColor: Colors.redAccent,
                      behavior: SnackBarBehavior.floating,
                      duration: const Duration(seconds: 3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                }
              },
              child: const Text("Save Changes"),
            ),
          ],
        ),
      ),
    );
  }
}
