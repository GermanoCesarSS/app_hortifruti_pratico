import 'package:app_hortifruti_pratico/app/modules/home/controller.dart';
import 'package:app_hortifruti_pratico/app/modules/home/page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {
  group(
    'HomePage Widget Test',
    () {
      late HomeController homeController;

      setUp(
        () {
          homeController = HomeController();
          Get.put(homeController);
        },
      );

      tearDown(
        () {
          Get.reset();
        },
      );

      testWidgets(
        'Deve exibir o contador inicial com 0',
        (WidgetTester tester) async {
          await tester.pumpWidget(
            const GetMaterialApp(
              home: HomePage(),
            ),
          );

          expect(find.text('0'), findsOneWidget);
        },
      );

      testWidgets(
        'Deve incrementar 1 no contador ao pressionar o botão',
        (WidgetTester tester) async {
          await tester.pumpWidget(
            const GetMaterialApp(
              home: HomePage(),
            ),
          );

          expect(find.text('0'), findsOneWidget);

          await tester.tap(find.byType(FloatingActionButton));
          await tester.pump();

          expect(find.text('1'), findsOneWidget);
        },
      );
    },
  );
}
