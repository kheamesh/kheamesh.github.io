import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../core/constants/app_icons.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_text_sizes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/pdf_download/pdf_downloader.dart';

class PdfViewerDialog extends StatefulWidget {
  final String assetPath;
  final String fileName;

  const PdfViewerDialog({
    super.key,
    this.assetPath = AppStrings.resumePdfAsset,
    this.fileName = AppStrings.resumeFileName,
  });

  static void show({
    String assetPath = AppStrings.resumePdfAsset,
    String fileName = AppStrings.resumeFileName,
  }) {
    Get.dialog(
      Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        backgroundColor: AppColors.transparent,
        child: PdfViewerDialog(assetPath: assetPath, fileName: fileName),
      ),
      barrierDismissible: true,
    );
  }

  @override
  State<PdfViewerDialog> createState() => _PdfViewerDialogState();
}

class _PdfViewerDialogState extends State<PdfViewerDialog> {
  late PdfViewerController _pdfViewerController;
  late Future<Uint8List> _pdfBytesFuture;
  int _pageCount = 0;
  int _currentPage = 1;
  bool _isDownloading = false;

  @override
  void initState() {
    super.initState();
    _pdfViewerController = PdfViewerController();
    _pdfBytesFuture = _loadAssetBytes();
  }

  Future<Uint8List> _loadAssetBytes() async {
    final candidatePaths = [
      widget.assetPath,
      'assets/pdf/resume.pdf',
      'assets/pdf/Kheamesh soni.pdf',
    ];

    for (final path in candidatePaths) {
      try {
        final data = await rootBundle.load(path);
        final bytes = data.buffer.asUint8List();
        if (bytes.isNotEmpty) {
          return bytes;
        }
      } catch (e) {
        debugPrint('Could not load asset at $path: $e');
        continue;
      }
    }
    throw Exception('PDF asset not found in bundle');
  }

  Future<void> _handleDownload() async {
    if (_isDownloading) return;
    setState(() => _isDownloading = true);

    try {
      final bytes = await _loadAssetBytes();
      await PdfDownloader.download(bytes, widget.fileName);

      Get.snackbar(
        AppStrings.success,
        '${AppStrings.downloadSuccessMessage} ${widget.fileName}',
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
      if (mounted) {
        setState(() => _isDownloading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: Get.width * 0.9,
      height: Get.height * 0.85,
      constraints: const BoxConstraints(maxWidth: 1000, maxHeight: 900),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.gold.withValues(alpha: 0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.5),
            blurRadius: 25,
            spreadRadius: 5,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          children: [
            // Header Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.darkHeaderBg
                    : AppColors.lightHeaderBg,
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.gold.withValues(alpha: 0.2),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  const Icon(AppIcons.pdf, color: AppColors.gold, size: 28),
                  SizedBox(width: Get.width * 0.008),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.resumePdfTitle,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: AppTextSizes.bodyMedium,
                            color: Theme.of(
                              context,
                            ).textTheme.titleLarge?.color,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          widget.fileName,
                          style: TextStyle(
                            fontSize: AppTextSizes.caption,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Download Button
                  ElevatedButton.icon(
                    onPressed: _isDownloading ? null : _handleDownload,
                    icon: _isDownloading
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.black,
                            ),
                          )
                        : const Icon(AppIcons.download, size: 18),
                    label: Text(
                      _isDownloading
                          ? AppStrings.downloadingBtnText
                          : AppStrings.downloadBtnText,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: AppTextSizes.bodySmall,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.gold,
                      foregroundColor: AppColors.black,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  SizedBox(width: Get.width * 0.008),
                  // Close Button
                  IconButton(
                    icon: const Icon(AppIcons.close),
                    onPressed: () => Get.back(),
                    tooltip: AppStrings.close,
                  ),
                ],
              ),
            ),

            // PDF Viewer Area
            Expanded(
              child: FutureBuilder<Uint8List>(
                future: _pdfBytesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(color: AppColors.gold),
                    );
                  }

                  if (snapshot.hasError || !snapshot.hasData) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            AppIcons.errorOutline,
                            size: 48,
                            color: AppColors.redAccent,
                          ),
                          SizedBox(height: Get.width * 0.01),
                          Text(
                            '${AppStrings.failedToLoadPdf}\n${snapshot.error ?? ''}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurfaceVariant,
                              fontSize: AppTextSizes.bodySmall,
                            ),
                          ),
                          SizedBox(height: Get.width * 0.015),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _pdfBytesFuture = _loadAssetBytes();
                              });
                            },
                            child: Text(
                              AppStrings.retry,
                              style: TextStyle(
                                fontSize: AppTextSizes.bodySmall,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return SfPdfViewer.memory(
                    snapshot.data!,
                    controller: _pdfViewerController,
                    onDocumentLoaded: (PdfDocumentLoadedDetails details) {
                      if (mounted) {
                        setState(() {
                          _pageCount = details.document.pages.count;
                        });
                      }
                    },
                    onPageChanged: (PdfPageChangedDetails details) {
                      if (mounted) {
                        setState(() {
                          _currentPage = details.newPageNumber;
                        });
                      }
                    },
                  );
                },
              ),
            ),

            // Footer Bar with Page Controls & Zoom
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.darkHeaderBg
                    : AppColors.lightHeaderBg,
                border: Border(
                  top: BorderSide(
                    color: AppColors.gold.withValues(alpha: 0.2),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${AppStrings.pagePrefix} $_currentPage ${AppStrings.ofPrefix} $_pageCount',
                    style: TextStyle(
                      fontSize: AppTextSizes.caption,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(AppIcons.zoomOut, size: 20),
                        onPressed: () {
                          _pdfViewerController.zoomLevel =
                              (_pdfViewerController.zoomLevel - 0.25).clamp(
                                1.0,
                                3.0,
                              );
                        },
                        tooltip: AppStrings.zoomOut,
                      ),
                      IconButton(
                        icon: const Icon(AppIcons.zoomIn, size: 20),
                        onPressed: () {
                          _pdfViewerController.zoomLevel =
                              (_pdfViewerController.zoomLevel + 0.25).clamp(
                                1.0,
                                3.0,
                              );
                        },
                        tooltip: AppStrings.zoomIn,
                      ),
                      IconButton(
                        icon: const Icon(AppIcons.navigatePrevious, size: 22),
                        onPressed: _currentPage > 1
                            ? () => _pdfViewerController.previousPage()
                            : null,
                        tooltip: AppStrings.previousPage,
                      ),
                      IconButton(
                        icon: const Icon(AppIcons.navigateNext, size: 22),
                        onPressed: _currentPage < _pageCount
                            ? () => _pdfViewerController.nextPage()
                            : null,
                        tooltip: AppStrings.nextPage,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
