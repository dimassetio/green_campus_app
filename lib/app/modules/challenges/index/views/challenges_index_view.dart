import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:green_campus_app/app/data/helpers/assets.dart';
import 'package:green_campus_app/app/data/helpers/formatter.dart';
import 'package:green_campus_app/app/data/helpers/themes.dart';
import 'package:green_campus_app/app/data/models/activity_model.dart';
import 'package:green_campus_app/app/data/widgets/app_bar.dart';
import 'package:green_campus_app/app/data/widgets/bottom_bar.dart';
import 'package:green_campus_app/app/data/widgets/button.dart';
import 'package:green_campus_app/app/data/widgets/circle_container.dart';
import 'package:green_campus_app/app/data/widgets/form_foto.dart';
import 'package:green_campus_app/app/data/widgets/main_container.dart';
import 'package:green_campus_app/app/data/widgets/notif_drawer.dart';
import 'package:green_campus_app/app/modules/challenges/index/views/challenges_card.dart';
import 'package:green_campus_app/app/modules/challenges/index/views/challenges_chart.dart';
import 'package:green_campus_app/app/routes/app_pages.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/challenges_index_controller.dart';

class ChallengesIndexView extends GetView<ChallengesIndexController> {
  const ChallengesIndexView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GCBottomBar(selectedIndex: 1),
      endDrawer: NotifDrawer(),
      body: GCMainContainer(
        scrollable: true,
        children: [
          // App Bar
          GCAppBar(svgIcon: svg_ic_challenge_a, label: 'greenChallenges'.tr),
          16.height,
          ChallengeChart(),
          // Open Challenge
          Container(
            margin: EdgeInsets.symmetric(vertical: 16),
            alignment: Alignment.centerLeft,
            child: Text(
              'openChallenge'.tr,
              style: textTheme(context).titleMedium,
            ),
          ),
          SizedBox(
            height: 130,
            child: Obx(
              () => ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.openChallenges.length,
                  itemBuilder: ((context, index) {
                    var challenge = controller.openChallenges[index];
                    return ChallengeCard(
                      showDate: false,
                      width: 300,
                      challenge: challenge,
                      onTap: () {
                        Get.toNamed(Routes.CHALLENGES_SHOW,
                            arguments: challenge);
                      },
                    ).marginOnly(right: 16);
                  })),
            ),
          ),

          // Recent Challenge
          Container(
            margin: EdgeInsets.symmetric(vertical: 16),
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'recentActivity'.tr,
                  style: textTheme(context).titleMedium,
                ),
                GCButton(
                  onPressed: () {
                    Get.toNamed(Routes.ACTIVITY_FORM);
                  },
                  title: 'addActivity'.tr,
                  icon: Icon(Icons.add_circle_outline_rounded),
                ),
              ],
            ),
          ),

          Obx(
            () => ListView.builder(
              itemCount: min(
                  controller.limitActivity, controller.recentActivities.length),
              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) => RecentActivityCard(
                  activity: controller.recentActivities[index]),
            ),
          ),
          Obx(
            () => controller.limitActivity < controller.recentActivities.length
                ? Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {
                          if (controller.limitActivity <
                              controller.recentActivities.length) {
                            controller.limitActivity += 5;
                          }
                        },
                        child: Text('showMore'.tr)),
                  )
                : SizedBox(),
          ),
          80.height,
        ],
      ),
    );
  }
}

class RecentActivityCard extends StatelessWidget {
  const RecentActivityCard({
    super.key,
    required this.activity,
  });

  final ActivityModel activity;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          Get.toNamed(Routes.ACTIVITY_SHOW, arguments: activity);
        },
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              GCFormFoto(
                oldPath: activity.foto ?? '',
                defaultPath: img_green_challenge,
                height: 60,
                width: 60,
                showButton: false,
              ),
              16.width,
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      activity.title ?? "",
                      style: textTheme(context)
                          .titleSmall
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    4.height,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(svg_gp, width: 24),
                        Text(
                            "  ${decimalFormatter(activity.rewards ?? 0)} ${'gp'.tr}"),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              CircleContainer(
                                padding: EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 8),
                                color: activity.status ==
                                        StatusActivity.approved
                                    ? primaryColor(context)
                                    : activity.status == StatusActivity.rejected
                                        ? clrSoftRed
                                        : secondaryColor,
                                margin: EdgeInsets.only(bottom: 4),
                                child: Text(
                                  (activity.status ?? '').tr,
                                  style: textTheme(context)
                                      .labelMedium
                                      ?.copyWith(
                                          color: activity.status !=
                                                  StatusActivity.pending
                                              ? theme(context)
                                                  .colorScheme
                                                  .onPrimary
                                              : theme(context)
                                                  .colorScheme
                                                  .onSecondary),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  dateTimeFormatter(activity.time),
                                  style: textTheme(context).labelMedium,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PercentageProgress extends StatelessWidget {
  const PercentageProgress({
    super.key,
    required this.size,
    required this.value,
  });

  final double size;
  final double value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: Stack(
        children: [
          CircleContainer(
            height: size,
            width: size,
            color: secondBg,
            alignment: Alignment.center,
            child: Text(
              '${(value * 100).toInt()}%',
              style: textTheme(context)
                  .headlineMedium
                  ?.copyWith(color: primaryColor(context)),
            ),
          ),
          SizedBox(
            height: size,
            width: size,
            child: CircularProgressIndicator(
              value: value,
              backgroundColor: lightColor,
              strokeCap: StrokeCap.round,
              strokeWidth: 12,
              strokeAlign: -1,
            ),
          ),
        ],
      ),
    );
  }
}
