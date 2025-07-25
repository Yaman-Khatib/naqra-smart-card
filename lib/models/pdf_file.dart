import 'dart:typed_data';

class PdfFile {
  final String name;
  final Uint8List bytes;

  PdfFile({required this.name, required this.bytes});
}
