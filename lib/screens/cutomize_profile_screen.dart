import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  final String initialName;
  final String initialFName;
  final String initialLName;

  const EditProfileScreen({
    super.key,
    required this.initialFName,
    required this.initialLName,
  }) : initialName = '${initialFName} ${initialLName}';

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
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
      appBar: AppBar(
        title: const Text("Edit Profile"),
        centerTitle: true,
      ),
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
                image: const DecorationImage(
                  image: AssetImage('assets/images/cover.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Upload Banner Button
            Positioned(
              bottom: 8,
              left: 16,
              child: GestureDetector(
                onTap: () {
                  // TODO: Upload banner
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
                    style: TextStyle(color: Colors.white, fontSize: 12),
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
                    child: const CircleAvatar(
                      radius: 48,
                      backgroundImage: AssetImage(
                        'assets/images/avatar.jpg',
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 4,
                    right: 4,
                    child: GestureDetector(
                      onTap: () {
                        // TODO: Upload avatar

                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(4),
                        child: const Icon(
                          Icons.camera_alt,
                          size: 16,
                        ),
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
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
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
  child: Text(
    'Skills / Keywords',
    style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
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
            color: currentLength > maxLength!
                ? Colors.red
                : Colors.grey.shade600,
            fontWeight:
                currentLength > maxLength ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      );
    },
    onChanged: (text) {
      
    },
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

            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: () {
                // TODO: Save logic
              },
              child: const Text("Save Changes"),
            ),
          ],
        ),
      ),
    );
  }
}
