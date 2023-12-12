import 'dart:io';

import 'package:integration_test/integration_test_driver.dart';

Future<void> main() async {
  try {
    await integrationDriver(
      responseDataCallback: (Map<String, dynamic>? x) async {
        if (x == null || x.isEmpty) return;

        late Map<String, List<int>> nameByteDict;
        if (x is Map<String, List<int>>) {
          nameByteDict = x;
        }

        nameByteDict.forEach((key, value) async {
          final File image =
              await File('screenshots/$key.png').create(recursive: true);
          image.writeAsBytesSync(value);
        });
        return;
      },
    );
  } catch (e) {
    // if (kDebugMode) {
    //   print('onScreenshot - error - $e');
    // }
  }
}
