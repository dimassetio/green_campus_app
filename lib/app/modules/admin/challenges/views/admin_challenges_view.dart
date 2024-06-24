import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_campus_app/app/data/helpers/assets.dart';
import 'package:green_campus_app/app/data/widgets/app_bar.dart';
import 'package:green_campus_app/app/data/widgets/main_container.dart';
import 'package:green_campus_app/app/modules/challenges/index/views/challenges_card.dart';
import 'package:green_campus_app/app/routes/app_pages.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/admin_challenges_controller.dart';

class AdminChallengesView extends GetView<AdminChallengesController> {
  const AdminChallengesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Get.toNamed(Routes.CHALLENGES_FORM);
          }),
      body: GCMainContainer(
        scrollable: true,
        children: [
          GCAppBar(
            label: 'Challenges List',
            svgIcon: svg_ic_challenge_a,
            showNotification: false,
          ),
          16.height,
          Obx(
            () => ListView.builder(
                itemCount: controller.challenges.length,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemBuilder: (context, index) {
                  return ChallengeCard(
                    onTap: () {
                      Get.toNamed(Routes.CHALLENGES_FORM,
                          arguments: controller.challenges[index]);
                    },
                    challenge: controller.challenges[index],
                    showDate: true,
                  );
                }),
          )
        ],
      ),
    );
  }
}
