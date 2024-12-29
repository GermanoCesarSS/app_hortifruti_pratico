import 'package:app_hortifruti_pratico/app/data/models/cart_product.dart';
import 'package:app_hortifruti_pratico/app/data/models/store.dart';
import 'package:app_hortifruti_pratico/app/data/services/cart/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final _cardService = Get.find<CartService>();
  List<CartProductModel> get products => _cardService.products;

  final observationController = TextEditingController();
  StoreModel? get store => _cardService.store.value;

  @override
  void onInit() {
    observationController.text = _cardService.observation.value;
    observationController.addListener(
      () {
        _cardService.observation.value = observationController.text;
      },
    );
    super.onInit();
  }

  void removeProduct(CartProductModel cartProduct) {
    _cardService.removeProductFromCart(cartProduct);
  }
}
