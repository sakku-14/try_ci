// import 'dart:io';

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:try_ci/main.dart' as app;

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding();

  /// Android端末であればスクリーンショットを撮る
  /// iPhone端末ではスクリーンショットが撮れない(例外が発生する)
  Future<void> takeScreenshot(WidgetTester tester, String title) async {
    if (Platform.isAndroid) {
      try {
        await binding.convertFlutterSurfaceToImage();
      } catch (e) {
        // ignore: avoid_print
        print("Take Screenshot exception $e");
      }
      await tester.pumpAndSettle();
    }

    await binding.takeScreenshot(title);
  }

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('portrait', (WidgetTester tester) async {
    app.main();

    // 起動画面
    await takeScreenshot(tester, '00_screenshot');
    await tester.pumpAndSettle(const Duration(seconds: 5));

    await takeScreenshot(tester, '01_screenshot');
    await tester.pumpAndSettle(const Duration(seconds: 5));
  });
}
