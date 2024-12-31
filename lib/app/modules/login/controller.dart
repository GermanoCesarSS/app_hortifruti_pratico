import 'package:app_hortifruti_pratico/app/data/models/user_login_request.dart';
import 'package:app_hortifruti_pratico/app/data/services/auth/service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final _authService = Get.find<AuthService>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login() {
    final UserLoginRequestModel userLoginRequest = UserLoginRequestModel(
      email: emailController.text,
      password: passwordController.text,
    );

    _authService.login(userLoginRequest).then((value) => null);
  }
}
