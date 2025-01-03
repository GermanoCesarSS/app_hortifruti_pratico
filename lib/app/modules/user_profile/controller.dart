import 'dart:ffi';

import 'package:app_hortifruti_pratico/app/data/models/user.dart';
import 'package:app_hortifruti_pratico/app/data/models/user_profile_request.dart';
import 'package:app_hortifruti_pratico/app/data/services/auth/service.dart';
import 'package:app_hortifruti_pratico/app/modules/user_profile/repository.dart';
import 'package:app_hortifruti_pratico/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserProfileController extends GetxController with StateMixin<UserModel> {
  final UserProfileRepository _repository;
  final _authService = Get.find<AuthService>();

  UserProfileController(this._repository);

  final formKey = GlobalKey<FormState>();
  // Perguntar sobre o tipo da variavel
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  bool isPhone = false;
  var passwordController = TextEditingController();

  @override
  void onInit() {
    _repository.getUser().then(
      (data) {
        nameController.text = data.name;
        emailController.text = data.email;
        if (data.phone != null) {
          phoneController.text = data.phone!;
          isPhone = true;
        }

        change(data, status: RxStatus.success());
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

    var userProfileRequest = UserProfileRequestModel(
      name: nameController.text,
      email: emailController.text,
      phone: phoneController.text,
      password: passwordController.text,
    );

    _repository.putUser(userProfileRequest).then(
      (value) {
        ScaffoldMessenger.of(Get.overlayContext!).showSnackBar(
          const SnackBar(content: Text('Seu perfil foi atualizado')),
        );
        passwordController.text = '';
      },
      onError: (error) => Get.dialog(
        AlertDialog(
          title: Text(error.toString()),
        ),
      ),
    );
  }

  void logout() async {
    await _authService.logout();
    Get.offAllNamed(Routes.dashboard);
  }
}
