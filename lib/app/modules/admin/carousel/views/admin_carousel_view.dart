import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:green_campus_app/app/data/helpers/assets.dart';
import 'package:green_campus_app/app/data/widgets/app_bar.dart';
import 'package:green_campus_app/app/data/widgets/card_column.dart';
import 'package:green_campus_app/app/data/widgets/main_container.dart';
import 'package:green_campus_app/app/routes/app_pages.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/admin_carousel_controller.dart';

class AdminCarouselView extends GetView<AdminCarouselController> {
  const AdminCarouselView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.ADMIN_CAROUSEL_FORM);
        },
        child: Icon(Icons.add_rounded),
      ),
      body: GCMainContainer(
        scrollable: true,
        children: [
          GCAppBar(
              showNotification: false,
              label: 'bannerCarousel'.tr,
              svgIcon: svg_logo),
          16.height,
          Obx(
            () => ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: controller.banners.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () => Get.toNamed(Routes.ADMIN_CAROUSEL_FORM,
                    arguments: controller.banners[index]),
                child: GCCardColumn(
                  padding: 0,
                  children: [
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: CachedNetworkImage(
                          imageUrl: controller.banners[index].image ?? '',
                          errorWidget: (context, url, error) =>
                              Text(" Error: $error, \n Url: $url"),
                        ),
                      ),
                    ),
                  ],
                  margin: EdgeInsets.only(bottom: 16),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
