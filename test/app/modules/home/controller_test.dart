import 'package:app_hortifruti_pratico/app/modules/home/controller.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late HomeController homeControllerTest;

  setUp(
    () {
      homeControllerTest = HomeController();
    },
  );
  group(
    'HomeController inclementacao',
    () {
      test(
        'inclementa mais um',
        () {
          homeControllerTest.incrementCounter();
          expect(homeControllerTest.counter.value, equals(1));
        },
      );
      test(
        'incrementa duas vezes',
        () {
          homeControllerTest.incrementCounter();
          homeControllerTest.incrementCounter();
          expect(homeControllerTest.counter.value, equals(2));
        },
      );
    },
  );
}
