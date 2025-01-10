import 'package:app_hortifruti_pratico/app/data/models/user_login_request.dart';
import 'package:app_hortifruti_pratico/app/data/models/user_profile_request.dart';
import 'package:app_hortifruti_pratico/app/data/services/auth/service.dart';
import 'package:app_hortifruti_pratico/app/modules/register/repository.dart';
import 'package:app_hortifruti_pratico/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final RegisterRepository _repository;
  final _authService = Get.find<AuthService>();

  RegisterController(this._repository);

  final formKey = GlobalKey<FormState>();
  // Perguntar sobre o tipo da variavel
  var nameController = TextEditingController(text: 'Nome');
  var emailController = TextEditingController(text: 'Nome@gmail.com');
  var phoneController = TextEditingController(text: '11996652887');
  var passwordController = TextEditingController(text: '11996652887');

  void register() {
    Get.focusScope!.unfocus();
    if (!formKey.currentState!.validate()) return;

    var userProfileRequest = UserProfileRequestModel(
      name: nameController.text,
      email: emailController.text,
      phone: phoneController.text,
      password: passwordController.text,
    );

    _repository.register(userProfileRequest).then(
      (value) async {
        await _authService.login(
          UserLoginRequestModel(
            email: emailController.text,
            password: passwordController.text,
          ),
        );
        await Get.dialog(
          barrierDismissible: false,
          AlertDialog(
            title: const Text('Conta criada'),
            content: const Text('Seja bem vindo ao mercado de frutas'),
            actions: [
              ElevatedButton(
                  onPressed: () => Get.offAllNamed(Routes.dashboard),
                  child: const Text('Ir para as compras'))
            ],
          ),
        );
      },
      onError: (error) {
        Get.dialog(
          AlertDialog(
            title: Text(error.toString()),
          ),
        );
      },
    );
  }
}
