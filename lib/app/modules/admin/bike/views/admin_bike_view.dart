import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:green_campus_app/app/data/helpers/assets.dart';
import 'package:green_campus_app/app/data/widgets/app_bar.dart';
import 'package:green_campus_app/app/data/widgets/main_container.dart';
import 'package:green_campus_app/app/modules/admin/bike/views/bike_card.dart';
import 'package:green_campus_app/app/routes/app_pages.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/admin_bike_controller.dart';

class AdminBikeView extends GetView<AdminBikeController> {
  const AdminBikeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.BIKE_FORM);
        },
        child: Icon(Icons.add),
      ),
      body: GCMainContainer(
        scrollable: true,
        children: [
          GCAppBar(
            label: 'bikeSharing'.tr,
            svgIcon: svg_ic_bike_a,
            showNotification: false,
          ),
          16.height,
          Obx(
            () => GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  mainAxisExtent: 250,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                ),
                itemCount: controller.bikes.length,
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return BikeCard(
                    onTap: () {
                      Get.toNamed(Routes.BIKE_FORM,
                          arguments: controller.bikes[index]);
                    },
                    bike: controller.bikes[index],
                  );
                }),
          ),
        ],
      ),
    );
  }
}
