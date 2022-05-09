import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:riverpod_coutup/main.dart';
import 'package:riverpod_coutup/view_model.dart';

void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  testGoldens('normal', (tester) async {
    Device iPhone55 = const Device(
        name: 'iPhone55', size: Size(414, 736), devicePixelRatio: 3.0);

    List<Device> devices = [iPhone55];

    ViewModel viewModel = ViewModel();

    await tester.pumpWidgetBuilder(
      ProviderScope(
        child: MyHomePage(
          viewModel,
        ),
      ),
    );

    await multiScreenGolden(
      tester,
      'myHomePage_init',
      devices: devices,
    );
  });
}
