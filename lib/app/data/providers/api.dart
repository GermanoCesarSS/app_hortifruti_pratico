import 'dart:convert';

import 'package:app_hortifruti_pratico/app/data/models/address.dart';
import 'package:app_hortifruti_pratico/app/data/models/city.dart';
import 'package:app_hortifruti_pratico/app/data/models/order.dart';
import 'package:app_hortifruti_pratico/app/data/models/order_request.dart';
import 'package:app_hortifruti_pratico/app/data/models/store.dart';
import 'package:app_hortifruti_pratico/app/data/models/user.dart';
import 'package:app_hortifruti_pratico/app/data/models/user_address_request.dart';
import 'package:app_hortifruti_pratico/app/data/models/user_login_request.dart';
import 'package:app_hortifruti_pratico/app/data/models/user_login_response.dart';
import 'package:app_hortifruti_pratico/app/data/models/user_profile_request.dart';
import 'package:app_hortifruti_pratico/app/data/services/storage/service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';

class Api extends GetConnect {
  final _storageService = Get.find<StorageService>();
  final noAuthPaths = [
    '/cidades/1/estabelecimentos',
  ];

  @override
  void onInit() {
    debugPrint('--API @override void onInit()');
    httpClient.baseUrl = 'http://10.0.2.2:3333/';
    // httpClient.baseUrl = 'http://localhost:3333/';

    httpClient.addRequestModifier((Request request) {
      request.headers['Accept'] = 'application/json';
      request.headers['Content-Type'] = 'application/json';

      return request;
    });

    httpClient.addAuthenticator((Request request) {
      debugPrint('--@override httpClient.addAuthenticator((Request request)');

      if (noAuthPaths.contains(request.url.path)) {
        return request; // Retorna sem adicionar o cabeçalho de autorização
      }

      var token = _storageService.token;
      if (token == null || token.isEmpty) {
        debugPrint('--REQUISICAO CANCELADA TOKEN NAO ENCONTRAO');
        // return Future.error(Exception('Requisição cancelada: Token não encontrado'),);
        throw 'Requisição cancelada: Token não encontrado';
      }

      var headers = {'Authorization': "Bearer $token"};
      request.headers.addAll(headers);
      return request;
    });

    super.onInit();
  }

  Future<UserLoginResponseModel> login(UserLoginRequestModel data) async {
    String nomeFn =
        'Future<UserLoginResponseModel> login(UserLoginRequestModel data) async';
    var response = _errorHandler(await post('login', jsonEncode(data)), nomeFn);
    return UserLoginResponseModel.fromJson(response.body);
  }

  Future<UserModel> getUser() async {
    String nomeFn = 'getUser() async';
    var response = _errorHandler(await get('auth/me'), nomeFn);
    return UserModel.fromJson(response.body);
  }

  Future<UserModel> putUser(UserProfileRequestModel data) async {
    String nomeFn =
        'Future<UserModel> putUser(UserProfileRequestModel data) async';
    var response = _errorHandler(await get('cliente'), nomeFn);

    return UserModel.fromJson(response.body);
  }

  Future<List<StoreModel>> getStores() async {
    String nomeFn = 'Future<List<StoreModel>> getStores()';
    var response = _errorHandler(
      await get('cidades/1/estabelecimentos'),
      nomeFn,
    );

    List<StoreModel> data = [];
    for (var store in response.body) {
      data.add(StoreModel.fromJson(store));
    }
    debugPrint('---$nomeFn List<StoreModel> data: $data');
    // return (response.body as List).map((store) => StoreModel.fromJson(store)).toList();
    return data;
  }

  Future<StoreModel> getStore(int id) async {
    String nomeFn = 'Future<StoreModel> getStore(int id) async';
    var response = _errorHandler(
      await get('estabelecimentos/$id'),
      nomeFn,
    );
    return StoreModel.fromJson(response.body);
  }

  Future<List<AddressModel>> getUserAddresses() async {
    String nomeFn = 'getUserAddress() async';
    var response = _errorHandler(await get('enderecos'), nomeFn);

    List<AddressModel> data = [];
    for (var address in response.body) {
      data.add(AddressModel.fromJson(address));
    }
    debugPrint('---$nomeFn List<AddressModel> data: $data');

    return data;
  }

  Future<List<CityModel>> getCities() async {
    String nomeFn = 'getCities() async';
    var response = _errorHandler(await get('cidades'), nomeFn);

    List<CityModel> data = [];
    for (var city in response.body) {
      data.add(CityModel.fromJson(city));
    }
    debugPrint('---$nomeFn List<CityModel> data: $data');

    return data;
  }

  Future<void> postAddress(UserAddressRequestModel data) async {
    String nomeFn =
        'Future<void> postAddress(UserAddressRequestModel data) async';
    _errorHandler(await post('enderecos', jsonEncode(data)), nomeFn);
  }

  Future<void> putAddress(UserAddressRequestModel data) async {
    String nomeFn =
        'Future<void> putAddress(UserAddressRequestModel data) async';
    _errorHandler(await put('enderecos/${data.id}', jsonEncode(data)), nomeFn);
  }

  Future<void> deleteAddress(int id) async {
    String nomeFn = 'Future<void> deleteAddress(int id) async';
    _errorHandler(await delete('enderecos/$id'), nomeFn);
  }

  Response _errorHandler(Response response, String nomeFn) {
    debugPrint(nomeFn);
    debugPrint('--$nomeFn status: ${response.statusCode}');
    debugPrint('--$nomeFn body: ${response.body}');
    debugPrint('--$nomeFn bodyString: ${response.bodyString}');

    switch (response.statusCode) {
      case 200:
      case 202:
      case 204:
        return response;
      default:
        throw 'Ocorreu um erro $nomeFn';
    }
  }

  // PEDIDOS

  Future<OrderModel> postOrder(OrderRequestModel data) async {
    String nomeFn = 'postOrder() async';
   var response = _errorHandler(await post('pedidos', jsonEncode(data)), nomeFn);
   //TODO: ver se o 'body' tem os pedidos
   return OrderModel.fromJson(response.body);
  }

  Future<List<OrderModel>> getOrders() async {
    String nomeFn = 'postOrder() async';
    var response = _errorHandler(await get('pedidos'), nomeFn);

    return (response.body as List)
        .map((orders) => OrderModel.fromJson(orders))
        .toList();
  }

  Future<OrderModel> getOrder(String hashId) async {
    String nomeFn = 'postOrder() async';
    var response = _errorHandler(await get('pedidos/$hashId'), nomeFn);

    return OrderModel.fromJson(response.body);
  }
}
