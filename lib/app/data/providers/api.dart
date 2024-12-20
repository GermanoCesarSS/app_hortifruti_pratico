import 'package:app_hortifruti_pratico/app/data/models/store.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/connect.dart';
import 'package:get/get_connect/http/src/request/request.dart';

class Api extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'localhost:3333';
    httpClient.addRequestModifier(
      (Request request) {
        request.headers['Accept'] = 'application/json';
        request.headers['Content-Type'] = 'application/json';
        return request;
      },
    );

    super.onInit();
  }

  Future<List<StoreModel>> getStores() async {
    debugPrint('FUNCAO getStores');
    var response = _errorHandler(await get('cidades/1/estabelecimentos'));

    List<StoreModel> data = [];

    for (var store in response.body) {
      data.add(StoreModel.fromJson(store));
    }

    return data;
  }

  Response _errorHandler(Response response) {
    debugPrint('Retorno API');
    debugPrint(response.bodyString);
    debugPrint('Retorno API');
    switch (response.statusCode) {
      case 200:
      case 202:
      case 204:
        return response;
      default:
        throw 'Ocorreu um erro';
    }
  }
}
