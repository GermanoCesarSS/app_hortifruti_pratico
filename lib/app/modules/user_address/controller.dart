import 'package:app_hortifruti_pratico/app/data/models/city.dart';
import 'package:app_hortifruti_pratico/app/data/models/user_address_request.dart';
import 'package:app_hortifruti_pratico/app/data/services/auth/service.dart';
import 'package:app_hortifruti_pratico/app/modules/user_address/repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserAddressController extends GetxController
    with StateMixin<List<CityModel>> {
  final UserAddressRepository _repository;
  final _authService = Get.find<AuthService>();

  UserAddressController(this._repository);

  final formKey = GlobalKey<FormState>();
  // Perguntar sobre o tipo da variavel
  var ruaController = TextEditingController(text: 'test Rua');
  var numeroController = TextEditingController(text: 'test Numero');
  var bairroController = TextEditingController(text: 'test Bairro');
  var pontoRefController = TextEditingController(text: 'test PontoRef');
  var complementoController = TextEditingController(text: 'test Complemento');
  final cityId = RxnInt();

  @override
  void onInit() {
    _repository.getCities().then(
      (data) => {
        change(data, status: RxStatus.success()),
      },
      onError: (error) {
        change(null, status: RxStatus.error(error));
      },
    );
    super.onInit();
  }

  void submit() {
    Get.focusScope!.unfocus();
    if (!formKey.currentState!.validate()) return;

    var userAddressRequest = UserAddressRequestModel(
        street: ruaController.text,
        number: numeroController.text,
        neighborhood: bairroController.text,
        referencePoint: pontoRefController.text,
        cityId: cityId.value!,
        complement: complementoController.text);

    _repository.postAddress(userAddressRequest).then(
      (value) {
        ScaffoldMessenger.of(Get.overlayContext!).showSnackBar(
          const SnackBar(content: Text('Um novo endereço foi cadastrado')),
        );
        Get.back(result: true);
      },
      onError: (error) => Get.dialog(
        AlertDialog(
          title: Text(error.toString()),
        ),
      ),
    );
  }

  void changeCity(int? cityIdSelected) {
    cityId.value = cityIdSelected;
  }
}
