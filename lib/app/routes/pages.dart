import 'package:app_hortifruti_pratico/app/modules/home/binding.dart';
import 'package:app_hortifruti_pratico/app/modules/home/page.dart';
import 'package:app_hortifruti_pratico/app/routes/routes.dart';
import 'package:get/get.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.INITIAL,
      page: () => const HomePage(),
      binding: HomeBinding(),
    )
  ];
}
