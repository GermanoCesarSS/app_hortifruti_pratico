import 'package:app_hortifruti_pratico/app/data/models/user_login_request.dart';
import 'package:app_hortifruti_pratico/app/data/providers/api.dart';
import 'package:get/get.dart';

class AuthRepository {
  final Api _api = Get.find<Api>();

  AuthRepository();

  Future login(UserLoginRequestModel UserLoginRequest) => _api.login(UserLoginRequest);
}
