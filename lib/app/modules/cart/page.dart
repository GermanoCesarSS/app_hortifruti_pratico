import 'package:app_hortifruti_pratico/app/data/models/cart_product.dart';
import 'package:app_hortifruti_pratico/app/modules/cart/controller.dart';
import 'package:app_hortifruti_pratico/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CartPage extends GetView<CartController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Carrinho')),
      body: SingleChildScrollView(
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: TextField(
                  controller: controller.observationController,
                  decoration: const InputDecoration(
                    labelText: 'Observação',
                  ),
                  maxLength: 50,
                ),
              ),
              if (controller.store != null)
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: Text(controller.store!.name),
                ),
              for (var cartProduct in controller.products)
                ListTile(
                  title: Text(cartProduct.product.name),
                  subtitle: Text(
                    '${NumberFormat.simpleCurrency().format(cartProduct.total)} (${NumberFormat.simpleCurrency().format(cartProduct.product.price)})',
                  ),
                  leading: _buildProductQuantitity(cartProduct),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => controller.removeProduct(cartProduct),
                  ),
                ),
              if (controller.products.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: ElevatedButton(
                    onPressed: () => Get.toNamed(Routes.checkout),
                    child: const Text('Pagamento'),
                  ),
                )
              else
                const Text('Seu carrinho está vazio'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductQuantitity(CartProductModel cartProduct) {
    return Text(
      NumberFormat.decimalPattern().format(cartProduct.quantity) +
          (cartProduct.product.isKg ? 'kg' : 'x'),
    );
  }
}
