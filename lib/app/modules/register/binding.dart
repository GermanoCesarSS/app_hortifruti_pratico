import 'package:app_hortifruti_pratico/app/data/providers/api.dart';
import 'package:app_hortifruti_pratico/app/modules/register/controller.dart';
import 'package:app_hortifruti_pratico/app/modules/register/repository.dart';
import 'package:get/get.dart';

class RegisterBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(
        () => RegisterController(RegisterRepository(Get.find<Api>())));
  }
}
