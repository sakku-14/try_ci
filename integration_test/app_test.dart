import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:try_ci/main.dart' as app;

void main() {
  // final binding = IntegrationTestWidgetsFlutterBinding();
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('tap on the floating action button, verify counter',
        (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Verify the counter starts at 0.
      expect(find.text('0'), findsOneWidget);
      // await takeScreenshot(tester, binding, 'shot-1');

      // Finds the floating action button to tap on.
      final Finder fab = find.byTooltip('Increment');

      // Emulate a tap on the floating action button.
      await tester.tap(fab);

      // Trigger a frame.
      await tester.pumpAndSettle();
      // await takeScreenshot(tester, binding, 'shot-2');

      // Verify the counter increments by 1.
      expect(find.text('1'), findsOneWidget);
    });
  });
}

takeScreenshot(tester, binding, name) async {
  if (Platform.isAndroid) {
    try {
      await binding.convertFlutterSurfaceToImage();
    } catch (e) {
      if (kDebugMode) {
        print("TakeScreenshot exception $e");
      }
    }
    await tester.pumpAndSettle();
  }

  await binding.takeScreenshot(name);
}

/// スクリーンショットを取得する.
// Future<void> _doScreenShot(
//     FlutterDriver driver, String path, String fileName) async {
//   await driver.waitUntilNoTransientCallbacks();
//   final picture = await driver.screenshot();
//   final file = File("$path/$fileName.png");
//   await file.writeAsBytes(picture);
// }
