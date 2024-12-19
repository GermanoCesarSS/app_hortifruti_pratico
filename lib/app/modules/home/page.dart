import 'package:app_hortifruti_pratico/app/modules/home/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: const Key('HomePageScaffold'),
        appBar: AppBar(title: const Text('HomePage')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('Voce clicou:'),
              Obx(
                () => Text(
                  controller.counter.toString(),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              FloatingActionButton(
                onPressed: controller.incrementCounter,
                tooltip: 'Adicionado mais 1 :)',
                child: const Icon(Icons.add),
                ),
            ],
          ),
        ));
  }
}
