import 'package:app_hortifruti_pratico/app/data/models/address.module.dart';
import 'package:app_hortifruti_pratico/app/data/providers/api.dart';

class UserAddressListRepository {
  final Api _api;

  UserAddressListRepository(this._api);

  Future<List<AddressModel>> getUserAddresses() => _api.getUserAddresses();

  Future<void> deleteAddress(int id) => _api.deleteAddress(id);
}
