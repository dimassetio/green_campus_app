import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:green_campus_app/app/data/helpers/assets.dart';
import 'package:green_campus_app/app/data/helpers/themes.dart';
import 'package:green_campus_app/app/data/widgets/app_bar.dart';
import 'package:green_campus_app/app/data/widgets/card_column.dart';
import 'package:green_campus_app/app/data/widgets/main_container.dart';
import 'package:green_campus_app/app/routes/app_pages.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/admin_controller.dart';

class AdminView extends GetView<AdminController> {
  const AdminView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GCMainContainer(
        scrollable: true,
        children: [
          GCAppBar(
            label: 'Admin Page'.tr,
            svgIcon: svg_ic_home_a,
            showNotification: false,
          ),
          16.height,
          AdminCard(
            title: "activities".tr,
            onPress: () {
              Get.toNamed(Routes.ADMIN_ACTIVITIES);
            },
            leading: Icon(
              Icons.task_alt_rounded,
              color: primaryColor(context),
              size: 60,
            ),
          ),
          16.height,
          AdminCard(
            title: "greenChallenges".tr,
            onPress: () {
              Get.toNamed(Routes.ADMIN_CHALLENGES);
            },
            leading: Image.asset(
              img_green_challenge,
              width: 60,
              height: 60,
            ),
          ),
          16.height,
          AdminCard(
            onPress: () {
              Get.toNamed(Routes.ADMIN_PRODUCTS);
            },
            leading: Icon(
              Icons.card_giftcard_outlined,
              color: primaryColor(context),
              size: 60,
            ),
            title: "rewardProducts".tr,
          ),
          16.height,
          AdminCard(
            onPress: () {
              Get.toNamed(Routes.ADMIN_REDEMPTION);
            },
            leading: Icon(
              Icons.qr_code_2,
              color: primaryColor(context),
              size: 60,
            ),
            title: "redemption".tr,
          ),
          16.height,
          AdminCard(
            onPress: () {
              Get.toNamed(Routes.ADMIN_FACILITIES);
            },
            leading: SvgPicture.asset(
              svg_ic_map_a,
              height: 60,
              width: 60,
            ),
            title: "greenFacilities".tr,
          ),
          16.height,
          AdminCard(
            onPress: () {
              Get.toNamed(Routes.ADMIN_BIKE);
            },
            leading: SvgPicture.asset(
              svg_ic_bike_a,
              height: 60,
              width: 60,
            ),
            title: "bikeSharing".tr,
          ),
          16.height,
          AdminCard(
            onPress: () {
              Get.toNamed(Routes.ADMIN_CAROUSEL);
            },
            leading: Icon(
              Icons.view_carousel_outlined,
              size: 60,
              color: primaryColor(context),
            ),
            title: "bannerCarousel".tr,
          ),
        ],
      ),
    );
  }
}

class AdminCard extends StatelessWidget {
  const AdminCard({
    super.key,
    required this.title,
    required this.leading,
    required this.onPress,
  });

  final void Function()? onPress;
  final String title;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return GCCardColumn(
      onPressed: onPress,
      crossAxis: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            leading ??
                SizedBox(
                  width: 60,
                  height: 60,
                ),
            16.width,
            Text(
              title,
              style: textTheme(context).titleMedium,
            ),
          ],
        )
      ],
    );
  }
}
