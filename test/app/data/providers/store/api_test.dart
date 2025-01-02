// import 'package:app_hortifruti_pratico/app/data/models/store.dart';
// import 'package:app_hortifruti_pratico/app/data/providers/api.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';

// import '../../../../config_test.dart';
// import '../api_test.mocks.dart';

// void main() {
//   late Api api;
//   late MockDio mockDio;
//   configureTest();

//   setUp(() {
//     debugPrint("Configuração inicial do teste API.");
//     mockDio = MockDio();
//     api = Api(dio: mockDio);
//   });

//   test('Deve retornar uma lista de StoreModel ao receber status 200', () async {
//     final mockResponse = Response(
//       data: [
//         {'id': 1, 'nome': 'Loja A', 'logo': '', 'online': true},
//         {'id': 2, 'nome': 'Loja B', 'logo': '', 'online': true},
//       ],
//       statusCode: 200,
//       requestOptions: RequestOptions(path: ''),
//     );

//     when(mockDio.get<List>('cidades/1/estabelecimentos'))
//         .thenAnswer((_) async => mockResponse);

//     final stores = await api.getStores();

//     expect(stores, isA<List<StoreModel>>());
//     expect(stores.length, 2);
//     expect(stores[0].name, 'Loja A');
//   });
// }
