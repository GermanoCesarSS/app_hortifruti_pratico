import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_test/flutter_test.dart';

void configureTest() {
  setUp(() {
    debugPrint("Configuração inicial do teste.");
    Get.reset();
  });

  tearDown(() {
    debugPrint("Limpando após o teste.");
    Get.reset(); 
  });
}
