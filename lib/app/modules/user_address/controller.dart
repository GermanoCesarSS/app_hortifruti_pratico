import 'package:app_hortifruti_pratico/app/data/models/address.dart';
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
  var complementoController = TextEditingController(text: 'test Complemento Controller');
  final cityId = RxnInt();
  final _address = Rxn<AddressModel>();
  final editing = RxBool(false);

  @override
  void onInit() {
    if (Get.arguments != null) {
      _address.value = Get.arguments;
      ruaController.text = _address.value!.street;
      numeroController.text = _address.value!.number;
      bairroController.text = _address.value!.neighborhood;
      pontoRefController.text = _address.value!.referencePoint;
      complementoController.text = _address.value!.complement ?? '';
      cityId.value = _address.value!.city!.id;
      editing.value = true;
    }
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
      id: editing.isTrue ? _address.value!.id : null,
      street: ruaController.text,
      number: numeroController.text,
      neighborhood: bairroController.text,
      referencePoint: pontoRefController.text,
      cityId: cityId.value!,
      complement: complementoController.text,
    );

    if (editing.isTrue) {
      _updateAddress(userAddressRequest);
    } else {
      _addAddress(userAddressRequest);
    }
  }

  void _addAddress(UserAddressRequestModel userAddressRequest) {
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

  void _updateAddress(UserAddressRequestModel userAddressRequest) {
    _repository.putAddress(userAddressRequest).then(
      (value) {
        ScaffoldMessenger.of(Get.overlayContext!).showSnackBar(
          const SnackBar(content: Text('O endereço foi atualizado')),
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
