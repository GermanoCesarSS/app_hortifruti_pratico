import 'package:app_hortifruti_pratico/app/data/models/store.dart';
import 'package:app_hortifruti_pratico/app/modules/home/repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController with StateMixin<List<StoreModel>> {
  var counter = RxInt(0);
  final HomeRepository _repository;

  HomeController(this._repository);
  
  HomeRepository get repository => _repository;


  @override
  void onInit() {
    _repository.getStores().then((data) {
      if (data.isNotEmpty) {
        change(data, status: RxStatus.success());
      } else {
        change([], status: RxStatus.empty());
      }
    }, onError: (error) {
      change(null, status: RxStatus.error(error.toString()));
    });
    super.onInit();
  }

  void incrementCounter() {
    counter.value++;
    debugPrint('incrementCounter');
    debugPrint('Valor do HomeController.counter.value: ${counter.value}');
  }
}
