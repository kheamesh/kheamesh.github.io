import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

Future<void> downloadPdfBytes(Uint8List bytes, String fileName) async {
  Directory? dir;
  if (Platform.isAndroid) {
    dir = Directory('/storage/emulated/0/Download');
    if (!await dir.exists()) {
      dir = await getExternalStorageDirectory();
    }
  } else if (Platform.isIOS) {
    dir = await getApplicationDocumentsDirectory();
  } else {
    dir = await getDownloadsDirectory() ?? await getApplicationDocumentsDirectory();
  }

  if (dir != null) {
    final file = File('${dir.path}/$fileName');
    await file.writeAsBytes(bytes);
  }
}
