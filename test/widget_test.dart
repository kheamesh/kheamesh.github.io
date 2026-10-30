import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:resume/controllers/theme_controller.dart';
import 'package:resume/controllers/pdf_controller.dart';
import 'package:resume/main.dart';

void main() {
  testWidgets('Portfolio loads smoke test', (WidgetTester tester) async {
    Get.put(ThemeController());
    Get.put(PdfController());

    await tester.pumpWidget(const PortfolioApp());
    expect(find.text('KHEAMESH SONI'), findsAtLeast(1));

    Get.reset();
  });
}
