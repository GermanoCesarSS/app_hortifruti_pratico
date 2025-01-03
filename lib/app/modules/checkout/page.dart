import 'package:app_hortifruti_pratico/app/modules/checkout/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'widget/informacao_linha.dart';

class CheckoutPage extends GetView<CheckoutController> {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: Obx(() {
        if (controller.loading.isTrue) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Text(
                  'Endereço',
                  style: Get.textTheme.titleLarge,
                ),
              ),
              if (controller.isLogged) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (controller.addresses.isNotEmpty) ...[
                        Expanded(child: _buildAddress()),
                        TextButton(
                          onPressed: controller.showAddressList,
                          child: const Text('Alterar'),
                        ),
                      ] else ...[
                        OutlinedButton(
                          onPressed: controller.goToNewAddress,
                          child: const Text('Cadastrar um endereço'),
                        ),
                      ],
                    ],
                  ),
                ),
                if (!controller.deliveryToMyaddress)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        'O endereço selecionado não é atendido',
                        textAlign: TextAlign.center,
                        style: Get.textTheme.bodyMedium!
                            .copyWith(color: Colors.red),
                      ),
                    ),
                  ),
              ] else
                Center(
                  child: OutlinedButton(
                    onPressed: controller.goToLogin,
                    child: const Text('Entre com a sua conta para continuar'),
                  ),
                ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Text(
                  'Forma de pagamento',
                  style: Get.textTheme.titleLarge,
                ),
              ),
              // Obx(
              //   () => ListView.builder(
              //     shrinkWrap: true,
              //     physics: const NeverScrollableScrollPhysics(),
              //     itemCount: controller.listPaymentMethod.length,
              //     itemBuilder: (context, index) {
              //       var paymentMethod = controller.listPaymentMethod[index];
              //       return RadioListTile(
              //         title: Text(paymentMethod.name),
              //         value: paymentMethod,
              //         groupValue: controller.paymentMethod.value,
              //         onChanged: controller.changePaymentMethod,
              //       );
              //     },
              //   ),
              // ),

              for (var paymentMethod in controller.listPaymentMethod) ...[
                RadioListTile(
                  title: Text(paymentMethod.name),
                  value: paymentMethod,
                  groupValue: controller.paymentMethod.value,
                  onChanged: controller.changePaymentMethod,
                ),
              ],
              InformacaoLinha(
                titulo: 'Produtos',
                numero:
                    NumberFormat.simpleCurrency().format(controller.totalCart),
              ),
              InformacaoLinha(
                titulo: 'Custo de Entrega',
                numero: NumberFormat.simpleCurrency()
                    .format(controller.deliveryCost),
              ),
              InformacaoLinha(
                titulo: 'Total',
                numero:
                    NumberFormat.simpleCurrency().format(controller.totalCart),
                estiloTitulo: Get.textTheme.titleLarge,
              ),
              Align(
                  child: ElevatedButton(
                      onPressed:
                          controller.canSendOrder ? controller.sendOrder : null,
                      child: const Text('Enviar pedido'))),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildAddress() {
    var address = controller.addressSelected.value!;
    return Text(address.street);
  }
}
