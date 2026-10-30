import 'dart:typed_data';

import 'pdf_download_stub.dart'
    if (dart.library.html) 'pdf_download_web.dart'
    if (dart.library.io) 'pdf_download_mobile.dart';

class PdfDownloader {
  static Future<void> download(Uint8List bytes, String fileName) async {
    await downloadPdfBytes(bytes, fileName);
  }
}
