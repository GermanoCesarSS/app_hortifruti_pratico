import 'package:app_hortifruti_pratico/app/data/models/user.dart';
import 'package:app_hortifruti_pratico/app/data/models/user_login_request.dart';
import 'package:app_hortifruti_pratico/app/data/models/user_login_response.dart';
import 'package:app_hortifruti_pratico/app/data/providers/api.dart';
import 'package:get/get.dart';

class AuthRepository {
  final Api _api = Get.find<Api>();

  AuthRepository();

  Future<UserLoginResponseModel> login(
          UserLoginRequestModel userLoginRequest) =>
      _api.login(userLoginRequest);
  
  Future<UserModel> getUser() => _api.getUser();
  
}
