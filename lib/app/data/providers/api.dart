import 'dart:convert';

import 'package:app_hortifruti_pratico/app/data/models/store.dart';
import 'package:app_hortifruti_pratico/app/data/models/user.dart';
import 'package:app_hortifruti_pratico/app/data/models/user_login_request.dart';
import 'package:app_hortifruti_pratico/app/data/models/user_login_response.dart';
import 'package:app_hortifruti_pratico/app/data/services/storage/service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';

class Api extends GetConnect {
  final _storageService = Get.find<StorageService>();

  @override
  void onInit() {
    debugPrint('--@override void onInit()');
    httpClient.baseUrl = 'http://10.0.2.2:3333/';
    // httpClient.baseUrl = 'http://localhost:3333/';

    httpClient.addRequestModifier((Request request) {
      request.headers['Accept'] = 'application/json';
      request.headers['Content-Type'] = 'application/json';

      return request;
    });

    httpClient.addAuthenticator((Request request) {
      debugPrint('--@override httpClient.addAuthenticator((Request request)');
      var token = _storageService.token;
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
}
