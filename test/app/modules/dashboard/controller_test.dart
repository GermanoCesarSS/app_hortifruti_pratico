import 'package:app_hortifruti_pratico/app/modules/dashboard/controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {
  late DashboardController dashboardController;

  setUp(
    () {
      dashboardController = DashboardController();
    },
  );
  group(
    'DashboardController Teste',
    () {
      test(
        'Passar um valor pro changePageIndex',
        () {
          expect(dashboardController.currentPageIndex.value, equals(RxInt(0)));
          dashboardController.changePageIndex(1);
          expect(dashboardController.currentPageIndex.value, equals(RxInt(1)));
        },
      );
    },
  );
}
