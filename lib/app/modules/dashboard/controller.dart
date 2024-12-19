import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  var currentPageIndex = RxInt(0);

  void changePageIndex(int index) {
    currentPageIndex.value = index;
    debugPrint('changePageIndex');
    debugPrint('Valor passado na funcao: $index');
    debugPrint('Valor do DashboardController.currentPageIndex.value: ${currentPageIndex.value}');
  }
}
