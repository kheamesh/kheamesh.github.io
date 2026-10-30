import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../core/constants/app_icons.dart';
import '../core/constants/app_strings.dart';
import '../core/theme/app_colors.dart';
import '../core/utils/pdf_download/pdf_downloader.dart';
import '../widgets/pdf/pdf_viewer_dialog.dart';

class PdfController extends GetxController {
  static PdfController get instance => Get.find<PdfController>();

  final RxBool isDownloading = false.obs;

  void showPdf() {
    PdfViewerDialog.show();
  }

  Future<void> downloadPdf({
    String assetPath = AppStrings.resumePdfAsset,
    String fileName = AppStrings.resumeFileName,
  }) async {
    if (isDownloading.value) return;
    isDownloading.value = true;

    try {
      final candidatePaths = [
        assetPath,
        'assets/pdf/resume.pdf',
        'assets/pdf/Kheamesh soni.pdf',
      ];

      Uint8List? bytes;
      for (final path in candidatePaths) {
        try {
          final data = await rootBundle.load(path);
          bytes = data.buffer.asUint8List();
          break;
        } catch (_) {
          continue;
        }
      }

      if (bytes == null) {
        throw Exception(AppStrings.pdfAssetNotFound);
      }

      await PdfDownloader.download(bytes, fileName);

      Get.snackbar(
        AppStrings.downloadSuccessful,
        '${AppStrings.resumeDownloadMessage} $fileName',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.gold,
        colorText: AppColors.black,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 4),
        icon: const Icon(AppIcons.checkCircle, color: AppColors.black),
      );
    } catch (e) {
      Get.snackbar(
        AppStrings.downloadFailed,
        '${AppStrings.downloadFailureMessage} $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.redAccent,
        colorText: AppColors.white,
        margin: const EdgeInsets.all(16),
      );
    } finally {
      isDownloading.value = false;
    }
  }
}
