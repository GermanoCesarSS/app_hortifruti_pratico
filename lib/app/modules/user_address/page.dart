import 'package:app_hortifruti_pratico/app/modules/user_address/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserAddressPage extends GetView<UserAddressController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Novo endereço')),
      body: controller.obx(
        (state) => SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: controller.ruaController,
                  decoration: const InputDecoration(
                    labelText: 'Rua',
                  ),
                  validator: (String? value) {
                    if (value != null && value.isEmpty) {
                      return 'Informe a rua';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: controller.numeroController,
                  decoration: const InputDecoration(
                    labelText: 'Número',
                  ),
                  validator: (String? value) {
                    if (value != null && value.isEmpty) {
                      return 'Informe o número';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: controller.bairroController,
                  decoration: const InputDecoration(
                    labelText: 'Bairro',
                  ),
                  validator: (String? value) {
                    if (value != null && value.isEmpty) {
                      return 'Informe o bairro';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: controller.pontoRefController,
                  decoration: const InputDecoration(
                    labelText: 'Ponto de refêrencia',
                  ),
                  validator: (String? value) {
                    if (value != null && value.isEmpty) {
                      return 'Informe o ponto de refêrencia';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: controller.complementoController,
                  decoration: const InputDecoration(
                    labelText: 'Complemento',
                  ),
                ),
                DropdownButtonFormField(
                  value: controller.cityId.value,
                  items: state!
                      .map(
                        (city) => DropdownMenuItem<int>(
                          value: city.id,
                          child: Text(city.name),
                        ),
                      )
                      .toList(),
                  onChanged: controller.changeCity,
                  decoration: const InputDecoration(
                    labelText: 'Cidade',
                  ),
                  validator: (value) {
                    if (value == null) {
                      return 'Selecione a cidade';
                    }
                    return null;
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ElevatedButton(
                          onPressed: controller.submit,
                          child: const Text('Adicionar'),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
