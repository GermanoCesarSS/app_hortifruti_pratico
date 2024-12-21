// coverage:ignore-file
import 'package:app_hortifruti_pratico/app/data/models/store.dart';
import 'package:app_hortifruti_pratico/app/data/providers/api.dart';

class HomeRepository {
  final ApiService _api;

  HomeRepository(this._api);

  ApiService get api => _api;

  Future<List<StoreModel>> getStores() => _api.getStores();
}
