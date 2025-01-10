import 'package:app_hortifruti_pratico/app/data/models/address.module.dart';
import 'package:app_hortifruti_pratico/app/data/models/order_request.dart';
import 'package:app_hortifruti_pratico/app/data/models/payment_method.dart';
import 'package:app_hortifruti_pratico/app/data/models/shipping_by_city.dart';
import 'package:app_hortifruti_pratico/app/data/services/auth/service.dart';
import 'package:app_hortifruti_pratico/app/data/services/cart/services.dart';
import 'package:app_hortifruti_pratico/app/modules/checkout/repository.dart';
import 'package:app_hortifruti_pratico/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutController extends GetxController {
  final CheckoutRepository _repository;
  final loading = RxBool(true);
  final _cartService = Get.find<CartService>();
  final _authService = Get.find<AuthService>();
  final addresses = RxList<AddressModel>.empty();
  final addressSelected = Rxn<AddressModel>();
  final paymentMethod = Rxn<PaymentMethodModel>();

  CheckoutController(this._repository);

  num get totalCart => _cartService.total;
  num get deliveryCost {
    if (getShippingByCity != null) {
      return getShippingByCity!.cost;
    }
    return 0;
  }

  bool get isLogged => _authService.isLogged;
  num get totalOrder => totalCart + deliveryCost;
  ShippingByCityModel? get getShippingByCity {
    if (addressSelected.value == null) {
      return null;
    }
    return _cartService.store.value!.shippingByCity.firstWhereOrNull(
        (shippingByCity) =>
            shippingByCity.id == addressSelected.value!.city!.id);
  }

  List<PaymentMethodModel> get listPaymentMethod =>
      _cartService.store.value!.paymentMethod;
  bool get deliveryToMyaddress => getShippingByCity != null;
  bool get canSendOrder => isLogged && deliveryToMyaddress;

  @override
  void onInit() {
    fetchAddresses();

    ever(_authService.user, (_) => fetchAddresses());

    super.onInit();
  }

  void changePaymentMethod(PaymentMethodModel? newPaymentMethod) {
    paymentMethod.value = newPaymentMethod;
  }

  void goToLogin() async {
    var result = await Get.toNamed(Routes.login);
    if (result is bool && result) {
      fetchAddresses();
    }
  }

  void goToNewAddress() {
    Get.toNamed(Routes.userAddress);
  }

  void fetchAddresses() {
    loading.value = true;
    _repository.getUserAddresses().then((value) {
      addresses.assignAll(value);
      if (addresses.isNotEmpty) {
        addressSelected.value = addresses.first;
      }
      loading.value = false;
    }, onError: (error) {
      loading.value = false;
    });
  }

  void showAddressList() {
    Get.dialog(SimpleDialog(
      title: const Text('Selecione um endereço'),
      children: [
        for (var obj in addresses) ...{
          SimpleDialogOption(
            child: Text('Rua: ${obj.street}'),
            onPressed: () {
              addressSelected.value = obj;
              Get.back();
            },
          ),
        },
        TextButton(
          onPressed: () {
            Get.back();
            goToNewAddress();
          },
          child: const Text('Cadastrar um endereço novo'),
        )
      ],
    ));
  }

  void sendOrder() {
    if (paymentMethod.value == null) {
      ScaffoldMessenger.of(Get.overlayContext!).showSnackBar(const SnackBar(
          content: Text('Escolha a forma de pagamento do seu pedido')));
      return;
    }

    var orderRequest = OrderRequestModel(
      store: _cartService.store.value!,
      paymentMethod: paymentMethod.value!,
      cartProducts: _cartService.products,
      address: addressSelected.value!,
      observation: _cartService.observation.value,
    );

    _repository.postOrder(orderRequest).then((hashId) {
      Get.dialog(
        AlertDialog(
          title: const Text('Pedido enviado!'),
          actions: [
            TextButton(
              onPressed: () {
                _cartService.finalizarCart();
                Get.offAllNamed(Routes.dashboard, arguments: DashboardMenuIndex.orders);
                // Get.offAllNamed(Routes.order.replaceFirst(':hashId', hashId));
              },
              child: const Text('Ver meus Pedidos'),
            )
          ],
        ),
        barrierDismissible: false,
      );
    });
  }
}
