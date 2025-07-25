import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:naqra_web/models/pdf_file.dart';

class PdfFileNotifier extends StateNotifier<PdfFile?> {
  PdfFileNotifier() : super(null);

  void addFile(Uint8List bytes, String name) {
    if (state == null) {
      state = PdfFile(name: name, bytes: bytes);
    }
  }

  void replaceFile(Uint8List bytes, String name) {
    state = PdfFile(name: name, bytes: bytes);
  }

  void setFile(Uint8List bytes, String name) {
    state = PdfFile(name: name, bytes: bytes);
  }

  void removeFile() {
    state = null;
  }

  PdfFile? getFile() => state;
}

final pdfFileProvider = StateNotifierProvider<PdfFileNotifier, PdfFile?>(
  (ref) => PdfFileNotifier(),
);
