import 'package:app_hortifruti_pratico/app/modules/user_address_list/components/widgets.dart';
import 'package:app_hortifruti_pratico/app/modules/user_address_list/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserAddressListPage extends GetView<UserAddressListController> {
  const UserAddressListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meu Endereços')),
      body: controller.obx(
        (listAddressModel) => SingleChildScrollView(
          child: Column(
            children: [
              WidgetButtonEndereco(vfn: controller.goToNewAddress),
              for (var address in listAddressModel!)
                ListTile(
                  title: Text('${address.street}, n: ${address.number}'),
                  subtitle:
                      Text('${address.neighborhood}, ${address.city!.name}'),
                  trailing: PopupMenuButton(
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'edit',
                        child: Text('Editar'),
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Text('Excluir'),
                      ),
                    ],
                    onSelected: (value) {
                      switch (value) {
                        case 'edit':
                          controller.goToEditAddress(address);
                          break;
                        case 'delete':
                          controller.deleteAddress(address);
                          break;
                      }
                    },
                  ),
                  onTap: () => controller.goToEditAddress(address),
                ),
            ],
          ),
        ),
        onEmpty: SingleChildScrollView(
          child: Column(
            children: [
              WidgetButtonEndereco(vfn: controller.goToNewAddress),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Adicione um endereço',
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
