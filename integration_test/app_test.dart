import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:try_ci/main.dart' as app;

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding();

  /// Android端末であればスクリーンショットを撮る
  /// iPhone端末ではスクリーンショットが撮れない(例外が発生する)
  Future<void> takeScreenshot(String title) async {
    if (Platform.isAndroid) {
      await binding.takeScreenshot(title);
    }
  }

  Future<void> initialize() async {
    if (Platform.isAndroid) {
      await binding.convertFlutterSurfaceToImage();
    }
  }

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('portrait', (WidgetTester tester) async {
    app.main();

    await initialize();

    // 起動画面
    await tester.pump();
    await takeScreenshot('00_screenshot');

    await tester.pumpAndSettle();
    await takeScreenshot('01_screenshot');
  });
}
