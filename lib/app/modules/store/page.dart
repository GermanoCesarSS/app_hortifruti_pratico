// coverage:ignore-file
import 'package:app_hortifruti_pratico/app/modules/store/controller.dart';
import 'package:app_hortifruti_pratico/app/widgtes/store_status.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transparent_image/transparent_image.dart';

class StorePage extends GetView<StoreController> {
  const StorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: controller.obx(
        (state) => ListView(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Row(
                children: [
                  SizedBox(
                    width: 96.0,
                    child: ClipRRect(
                      child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: state!.imagem,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.name,
                          style: Get.textTheme.headlineSmall,
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        StoreStatus(isOnline: state.isOnline),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
