import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod_coutup/main.dart';
import 'package:riverpod_coutup/view_model.dart';

class MockViewModel extends Mock implements ViewModel {}

void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  Device iPhone55 = const Device(
      name: 'iPhone55', size: Size(414, 736), devicePixelRatio: 3.0);
  List<Device> devices = [iPhone55];

  testGoldens('normal', (tester) async {
    ViewModel viewModel = ViewModel();

    await tester.pumpWidgetBuilder(
      ProviderScope(
        child: MyHomePage(
          viewModel,
        ),
      ),
    );

    // 初期レンダリング
    await multiScreenGolden(
      tester,
      'myHomePage_init',
      devices: devices,
    );

    // 3回タップ
    await tester.tap(find.byIcon(CupertinoIcons.plus));
    await tester.tap(find.byIcon(CupertinoIcons.plus));
    await tester.tap(find.byIcon(CupertinoIcons.minus));
    await tester.pump();

    await multiScreenGolden(
      tester,
      'myHomePage_1tapped',
      devices: devices,
    );
  });

  testGoldens('viewModelTest', (tester) async {
    var mock = MockViewModel();
    when(() => mock.count).thenReturn(123456789.toString());
    when(() => mock.countUp).thenReturn(213456789.toString());
    when(() => mock.countDown).thenReturn(312456789.toString());

    await tester.pumpWidgetBuilder(
      ProviderScope(
        child: MyHomePage(mock),
      ),
    );

    await multiScreenGolden(
      tester,
      'MyHomePage_mock',
      devices: devices,
    );

    // 実行されてしまっていないかを確認
    verifyNever(() => mock.onIncrease());
    verifyNever(() => mock.onDecrease());
    verifyNever(() => mock.onReset());

    // 実行確認
    await tester.tap(find.byIcon(CupertinoIcons.plus));
    verify(() => mock.onIncrease()).called(1);
    verifyNever(() => mock.onDecrease());
    verifyNever(() => mock.onReset());

    await tester.tap(find.byIcon(CupertinoIcons.minus));
    await tester.tap(find.byIcon(CupertinoIcons.minus));
    verify(() => mock.onDecrease()).called(2);
    verifyNever(() => mock.onIncrease());
    verifyNever(() => mock.onReset());

    await tester.tap(find.byIcon(Icons.refresh));
    verify(() => mock.onReset()).called(1);
    verifyNever(() => mock.onIncrease());
    verifyNever(() => mock.onDecrease());
  });
}
