import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_hortifruti_pratico/app/modules/select_city/controller.dart';

class SelectCityPage extends GetView<SelectCityController> {
  const SelectCityPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Selecione uma cidade')),
      body: controller.obx(
        (state) => SingleChildScrollView(
          child: Column(
            children: [
              for (var city in state!)
                ListTile(
                  title: Text(
                    '${city.name} / ${city.uf}',
                    textAlign: TextAlign.center,
                  ),
                  onTap: () => controller.onSelected(city),
                )
            ],
          ),
        ),
      ),
    );
  }
}
