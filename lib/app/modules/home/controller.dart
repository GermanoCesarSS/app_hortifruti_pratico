import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var counter = RxInt(0);

  void incrementCounter() {
    counter.value++;
    debugPrint('incrementCounter: Clicou no botao');
    debugPrint('Valor do botão: ${counter.value}');
  }
}
