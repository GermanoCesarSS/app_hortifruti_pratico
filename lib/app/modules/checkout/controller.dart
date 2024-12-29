import 'package:app_hortifruti_pratico/app/data/models/payment_method.dart';
import 'package:app_hortifruti_pratico/app/data/models/shipping_by_city.dart';
import 'package:app_hortifruti_pratico/app/data/services/cart/services.dart';
import 'package:app_hortifruti_pratico/app/modules/checkout/repository.dart';
import 'package:app_hortifruti_pratico/app/routes/routes.dart';
import 'package:get/get.dart';

class CheckoutController extends GetxController {
  final CheckoutRepository _repository;
  final _cartService = Get.find<CartService>();

  CheckoutController(this._repository);

  num get totalCart => _cartService.total;
  num get deliveryCost {
    if (getShippingByCity != null) {
      return getShippingByCity!.cost;
    }
    return 0;
  }

  ShippingByCityModel? get getShippingByCity {
    var cityId = 1;
    return _cartService.store.value!.shippingByCity
        .firstWhereOrNull((_) => _.id == cityId);
  }

  num get totalOrder => totalCart + deliveryCost;
  List<PaymentMethodModel> get listPaymentMethod =>
      _cartService.store.value!.paymentMethod;
  final paymentMethod = Rxn<PaymentMethodModel>();

  void changePaymentMethod(PaymentMethodModel? newPaymentMethod) {
    paymentMethod.value = newPaymentMethod;
  }

  void goToLogin() {
    Get.toNamed(Routes.login);
  }
}
