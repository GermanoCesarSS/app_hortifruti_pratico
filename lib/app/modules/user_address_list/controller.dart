import 'package:app_hortifruti_pratico/app/data/models/address.module.dart';
import 'package:app_hortifruti_pratico/app/modules/user_address_list/repository.dart';
import 'package:app_hortifruti_pratico/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserAddressListController extends GetxController
    with StateMixin<List<AddressModel>> {
  final UserAddressListRepository _repository;
  UserAddressListController(this._repository);

  @override
  void onInit() {
    fetchAddresses();
    super.onInit();
  }

  Future<void> fetchAddresses() {
    return _repository.getUserAddresses().then((data) {
      if (data.isNotEmpty) {
        change(data, status: RxStatus.success());
      } else {
        change(null, status: RxStatus.empty());
      }
    }, onError: (error) {
      change(null, status: RxStatus.error(error.toString()));
    });
  }

  void goToNewAddress() async {
    var result = await Get.toNamed(Routes.userAddress);
    if (result is bool && result) {
      fetchAddresses();
    }
  }

  void goToEditAddress(AddressModel address) async {
    var result = await Get.toNamed(Routes.userAddress, arguments: address);
    if (result is bool && result) {
      fetchAddresses();
    }
  }

  void deleteAddress(AddressModel address) {
    _repository.deleteAddress(address.id).then((value) async {
      await fetchAddresses();
      ScaffoldMessenger.of(Get.overlayContext!).showSnackBar(
        const SnackBar(content: Text('O endereço foi excluido')),
      );
    }, onError: (error) {
      Get.dialog(
        AlertDialog(
          title: Text(
            error.toString(),
          ),
        ),
      );
    });
  }
}
