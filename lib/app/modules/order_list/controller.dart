import 'package:app_hortifruti_pratico/app/data/models/order.dart';
import 'package:app_hortifruti_pratico/app/data/services/auth/service.dart';
import 'package:app_hortifruti_pratico/app/modules/order_list/repository.dart';
import 'package:get/get.dart';

class OrderListController extends GetxController
    with StateMixin<List<OrderModel>> {
  final OrderListRepository _repository;
  final _authService = Get.find<AuthService>();

  OrderListController(this._repository);

  @override
  void onInit() {
    ever(_authService.user, (_) => fetchOrders());

    fetchOrders();

    super.onInit();
  }

  void fetchOrders() {
    _repository.getOrders().then((data) {
      var status = data.isEmpty ? RxStatus.empty() : RxStatus.success();
      change(data, status: status);
    }, onError: (error) {
      change(null, status: RxStatus.error(error.toString()));
    });
  }
}
