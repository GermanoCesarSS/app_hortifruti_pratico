import 'package:app_hortifruti_pratico/app/data/models/cart_product.dart';
import 'package:app_hortifruti_pratico/app/data/models/product.dart';
import 'package:app_hortifruti_pratico/app/data/models/store.dart';
import 'package:app_hortifruti_pratico/app/data/services/cart/services.dart';
import 'package:app_hortifruti_pratico/app/modules/product/widgts/quantity_and_weight/quantity_and_weight_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final product = Rxn<ProductModel>();
  final store = Rxn<StoreModel>();
  final observationController = TextEditingController();
  final _cardService = Get.find<CartService>();
  @override
  void onInit() {
    product.value = Get.arguments['product'];
    store.value = Get.arguments['store'];

    super.onInit();
  }

  void addToCart() async {
    observationController.text;
    var quantity = Get.find<QuantityAndWeightController>().quantity;

    if (_cardService.isANexStore(store.value!)) {
      if (await showDialogNewCArt() == true) {
        _cardService.clearCart();
      } else {
        return;
      }
    }

    if (_cardService.products.isEmpty) {
      _cardService.newCart(store.value!);
    }

    _cardService.addProductToCart(
      CartProductModel(
        product: product.value!,
        quantity: quantity,
        observation: observationController.text,
      ),
    );

    // Get.rawSnackbar(
    //   message: 'O item ${product.value!.name} foi adicionado no carrinho!',
    //   snackStyle: SnackStyle.GROUNDED,
    // );
    ScaffoldMessenger.of(Get.overlayContext!).showSnackBar(
      SnackBar(
        content:
            Text('O item ${product.value!.name} foi adicionado no carrinho!'),
      ),
    );
    Future.delayed(
      const Duration(milliseconds: 300),
      () => Get.back(),
    );
  }

  Future<bool> showDialogNewCArt() async {
    return await Get.dialog(
      barrierDismissible: false,
      AlertDialog(
        title: const Text('Iniciar um novo carrinho?'),
        content: const Text('Iniciar um novo carrinho?'),
        actions: [
          TextButton(
              onPressed: () => Get.back(result: false),
              child: const Text('Não')),
          TextButton(
              onPressed: () => Get.back(result: true),
              child: const Text('Sim')),
        ],
      ),
    );
  }
}
