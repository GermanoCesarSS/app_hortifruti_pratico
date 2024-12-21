// coverage:ignore-file
import 'package:app_hortifruti_pratico/app/data/models/store.dart';
import 'package:app_hortifruti_pratico/app/data/providers/api.dart';

class StoreRepository {
  final ApiService _api;

  StoreRepository(this._api);

  Future<StoreModel> getStore(int id) {
    return _api.getStore(id);
  }
}
