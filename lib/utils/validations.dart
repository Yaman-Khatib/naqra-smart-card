import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

class Validations {

static bool isValidContactValue(String value, String pattern) {
  final regex = RegExp(pattern);
  return regex.hasMatch(value);
}


static Future<PlatformFile?> pickPdfFile() async {
  final result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf'],
    withData: kIsWeb,
  );
  return result?.files.firstOrNull;
}

}

