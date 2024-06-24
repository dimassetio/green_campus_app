import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:green_campus_app/app/data/helpers/assets.dart';
import 'package:green_campus_app/app/data/helpers/formatter.dart';
import 'package:green_campus_app/app/data/helpers/themes.dart';
import 'package:green_campus_app/app/data/models/banner_model.dart';
import 'package:green_campus_app/app/data/widgets/bottom_bar.dart';
import 'package:green_campus_app/app/data/widgets/circle_container.dart';
import 'package:green_campus_app/app/data/widgets/notif_drawer.dart';
import 'package:green_campus_app/app/modules/admin/products/views/product_card.dart';
import 'package:green_campus_app/app/modules/auth/controllers/auth_controller.dart';
import 'package:green_campus_app/app/routes/app_pages.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  Widget pointsSection(BuildContext context) {
    return Positioned(
      top: 120,
      left: 0.0,
      right: 0.0,
      height: 72,
      child: Card(
        color: theme(context).colorScheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: EdgeInsets.symmetric(horizontal: 16),
        child: Obx(
          () => ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            leading:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8), color: lightColor),
                child: Icon(
                  Icons.stars_rounded,
                  color: primaryColor(context),
                ),
              ),
            ]),
            title: Text(
              "greenPoints".tr,
              style: textTheme(context).labelMedium,
            ),
            subtitle: Text(
              "${authC.user.gp?.toString() ?? 0} ${'gp'.tr}",
              style: textTheme(context).titleMedium,
            ),
            trailing: Card(
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              color: lightColor,
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {
                  Get.toNamed(Routes.TRANSACTIONS);
                },
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(
                    Icons.history,
                    color: primaryColor(context),
                    size: 24,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget carouselSection(BuildContext context) {
    return Obx(() {
      List list = controller.banners.isNotEmpty
          ? controller.banners
          : controller.carousel;
      return CarouselSlider.builder(
        itemCount: list.length,
        itemBuilder: (context, index, realIndex) => ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: controller.banners.isEmpty
              ? Image.asset(
                  list[index],
                  fit: BoxFit.contain,
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: CachedNetworkImage(
                    imageUrl: (list[index] as BannerModel).image ?? '',
                    fit: BoxFit.contain,
                  ),
                ),
        ).marginSymmetric(horizontal: 16),
        options: CarouselOptions(
          autoPlay: true,
          // aspectRatio: 16 / 9,
          height: 200,
          viewportFraction: 1,
        ),
      );
    });
  }

  Widget popularChallengeSection(BuildContext context) {
    return Obx(() => controller.isLoading
        ? LinearProgressIndicator()
        : Container(
            height: 80,
            child: ListView.builder(
                physics: ScrollPhysics(),
                itemCount: controller.challenges.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  var challenge = controller.challenges[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    margin: EdgeInsets.all(8),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () {
                        Get.toNamed(Routes.CHALLENGES_SHOW,
                            arguments: challenge);
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AspectRatio(
                              aspectRatio: 1,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: challenge.foto is String
                                    ? CachedNetworkImage(
                                        imageUrl: challenge.foto!,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.asset(
                                        img_logo,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                            16.width,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  challenge.title ?? 'challengeName'.tr,
                                  style: textTheme(context).titleSmall,
                                ),
                                2.height,
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      svg_gp,
                                      height: 20,
                                    ),
                                    8.width,
                                    Text(
                                      "${decimalFormatter(challenge.rewards)} ${'gp'.tr}",
                                      style: textTheme(context).labelMedium,
                                    ),
                                  ],
                                )
                              ],
                            ),
                            8.width,
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ));
  }

  Widget rewardItemSection(BuildContext context) {
    return Obx(
      () => GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            mainAxisExtent: 250,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
          ),
          itemCount: controller.products.length,
          physics: ScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) =>
              ProductCard(product: controller.products[index])),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GCBottomBar(selectedIndex: 0),
      endDrawer: NotifDrawer(),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                UsernameSection(),
                48.height,
                carouselSection(context),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      // Popular Challenges
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "earnMoreGP".tr,
                            style: textTheme(context).titleMedium,
                          ),
                          TextButton(
                            onPressed: () {
                              Get.toNamed(Routes.CHALLENGES_INDEX);
                            },
                            child: Text(
                              "seeAll".tr,
                              style: textTheme(context).labelMedium,
                            ),
                          )
                        ],
                      ),
                      popularChallengeSection(context),

                      // Reward Item
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "redeem".tr,
                          style: textTheme(context).titleMedium,
                        ),
                      ),
                      rewardItemSection(context),
                    ],
                  ),
                ),
                96.height,
              ],
            ),

            // Points section
            pointsSection(context),
          ],
        ),
      ),
    );
  }
}

class UsernameSection extends StatelessWidget {
  const UsernameSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(img_bg_pattern), fit: BoxFit.cover),
        color: primaryColor(context),
      ),
      padding: EdgeInsets.fromLTRB(20, 20, 20, 56),
      child: SafeArea(
        child: Obx(
          () => Row(
            children: [
              CircleAvatar(
                radius: 30,
                child: Text(authC.user.name?[0] ?? ''),
                foregroundImage: authC.user.foto is String
                    ? CachedNetworkImageProvider(authC.user.foto!)
                    : null,
              ),
              12.width,
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'welcomeBack'.tr,
                      style: textTheme(context).labelMedium?.copyWith(
                            color: theme(context).colorScheme.onPrimary,
                          ),
                    ),
                    Text(
                      authC.user.name ?? 'Name',
                      style: textTheme(context).titleLarge?.copyWith(
                          color: theme(context).colorScheme.onPrimary),
                    )
                  ],
                ),
              ),
              CircleContainer(
                child: IconButton(
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                  icon: Icon(Icons.notifications_outlined),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
