import 'package:app_hortifruti_pratico/app/data/models/store.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ApiService {
  final Dio dio;

  ApiService({Dio? dio})
      : dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: 'http://10.0.2.2:3333/',
                // baseUrl: 'http://localhost:3333/',
                headers: {
                  'Accept': 'application/json',
                  'Content-Type': 'application/json',
                },
                connectTimeout: const Duration(seconds: 10),
                receiveTimeout: const Duration(seconds: 10),
              ),
            );

  Future<List<StoreModel>> getStores() async {
    try {
      debugPrint('FUNCAO getStores');
      final response = await dio.get<List>('cidades/1/estabelecimentos');

      debugPrint('getStore id status: ${response.statusCode}');
      debugPrint('Retorno API: ${response.data}');
      return response.data!.map((e) => StoreModel.fromJson(e)).toList();
    } on DioException catch (dioCatch) {
      switch (dioCatch.response?.statusCode) {
        case 400:
          debugPrint('Erro 1: Descrição do erro');
          throw ('Estabelecimento não encontrado.');
        case 404:
          debugPrint('Erro 404: Recurso não encontrado');
          throw ('Estabelecimento não encontrado.');
        case null:
          debugPrint('Erro Dio: Sem conecao');
          throw ('Sem conexao.');
        default:
          debugPrint(
              'Erro funcao getStores Dio: ${dioCatch.response?.statusCode}');
          throw 'Ocorreu um erro no getStores: ${dioCatch.message}';
      }
    } catch (e) {
      debugPrint('Erro na funcao getStores: $e');
      throw 'Ocorreu um erro desconhecido getStores';
    }
  }

  Future<StoreModel> getStore(int id) async {
    try {
      debugPrint('FUNCAO getStore id');
      final response = await dio.get('estabelecimentos/$id');
      debugPrint('Retorno da getStore id');

      debugPrint('Retorno API: ${response.data}');

      return StoreModel.fromJson(response.data);
    } on DioException catch (dioCatch) {
      switch (dioCatch.response?.statusCode) {
        case 400:
          debugPrint('Erro 1: Descrição do erro');
          throw ('Estabelecimento não encontrado.');
        case 404:
          debugPrint('Erro 404: Recurso não encontrado');
          throw ('Estabelecimento não encontrado.');
        case null:
          debugPrint('Erro Dio: Sem conecao');
          throw ('Sem conexao.');
        default:
          debugPrint(
              'Erro funcao getStores Dio: ${dioCatch.response?.statusCode}');
          throw 'Ocorreu um erro no getStores: ${dioCatch.message}';
      }
    } catch (e) {
      debugPrint('Erro na funcao getStore id: $e');
      throw 'Ocorreu um erro getStore id';
    }
  }
}
