import 'package:app_hortifruti_pratico/app/data/models/address.module.dart';
import 'package:app_hortifruti_pratico/app/data/models/order_request.dart';
import 'package:app_hortifruti_pratico/app/data/providers/api.dart';

class CheckoutRepository {
  final Api _api;

  CheckoutRepository(this._api);

  Future<List<AddressModel>> getUserAddresses() => _api.getUserAddresses();
  Future<String> postOrder(OrderRequestModel orderRequest) =>
      _api.postOrder(orderRequest);
}
