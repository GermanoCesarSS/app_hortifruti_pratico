import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var counter = RxInt(0);

  void incrementCounter() {
    counter.value++;
    debugPrint('incrementCounter');
    debugPrint('Valor do HomeController.counter.value: ${counter.value}');
  }
}
