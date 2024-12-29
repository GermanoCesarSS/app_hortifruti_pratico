import 'package:app_hortifruti_pratico/app/modules/checkout/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CheckoutPage extends GetView<CheckoutController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            Obx(
              () => Column(
                children: [
                  for (var paymentMethod in controller.listPaymentMethod)
                    RadioListTile(
                      title: Text(paymentMethod.name),
                      value: paymentMethod,
                      groupValue: controller.paymentMethod.value,
                      onChanged: controller.changePaymentMethod,
                    ),
                ],
              ),
            ),
            _InformacaoLinha(
              titulo: 'Produtos',
              numero:
                  NumberFormat.simpleCurrency().format(controller.totalCart),
            ),
            _InformacaoLinha(
              titulo: 'Custo de Entrega',
              numero:
                  NumberFormat.simpleCurrency().format(controller.deliveryCost),
            ),
            _InformacaoLinha(
              titulo: 'Total',
              numero:
                  NumberFormat.simpleCurrency().format(controller.totalCart),
              estiloTitulo: Get.textTheme.titleLarge,
            ),
            Align(
                child: ElevatedButton(
                    onPressed: () {}, child: const Text('Enviar pedido'))),
          ],
        ),
      ),
    );
  }
}

class _InformacaoLinha extends StatelessWidget {
  final String titulo;
  final String numero;
  final TextStyle? estiloTitulo;
  final TextStyle? estiloNumero;

  const _InformacaoLinha({
    required this.titulo,
    required this.numero,
    this.estiloTitulo,
    this.estiloNumero,
  });

  @override
  Widget build(BuildContext _) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '$titulo: ',
              style: estiloTitulo ?? Get.textTheme.titleMedium,
            ),
          ),
          Text(
            numero,
            style: estiloNumero ?? Get.textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
