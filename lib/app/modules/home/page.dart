import 'package:app_hortifruti_pratico/app/modules/home/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('HomePageScaffold'),
      appBar: AppBar(title: const Text('Hortifruti Prático')),
      body: controller.obx(
        (state) => SafeArea(
          child: ListView(
            children: [
              for (var store in state!)
                _buildListItem(store.nome, store.online),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListItem(String titulo, bool aberto) {
    return ListTile(
      title: Text(titulo),
      leading: const FlutterLogo(),
      trailing: Text(aberto ? 'Aberto' : 'Fechado'),
    );
  }
}
