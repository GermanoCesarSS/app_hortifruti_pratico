import 'package:app_hortifruti_pratico/app/modules/home/binding.dart';
import 'package:app_hortifruti_pratico/app/modules/home/controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {
  group('HomeBinding teste', () {
    setUp(
      () {
        Get.reset();
      },
    );
    test('Deve injetar HomeController com sucesso', () {
      // Executa o binding
      HomeBinding().dependencies();

      // Verifica se o HomeController foi registrado
      expect(() => Get.find<HomeController>(), returnsNormally);

      // Opcional: verifica se o controller é realmente uma instância de HomeController
      final controller = Get.find<HomeController>();
      expect(controller, isA<HomeController>());
    });
  });
}
