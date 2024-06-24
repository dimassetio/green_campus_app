import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:green_campus_app/app/data/helpers/assets.dart';
import 'package:green_campus_app/app/data/helpers/formatter.dart';
import 'package:green_campus_app/app/data/helpers/themes.dart';
import 'package:green_campus_app/app/data/widgets/app_bar.dart';
import 'package:green_campus_app/app/data/widgets/button.dart';
import 'package:green_campus_app/app/data/widgets/card_column.dart';
import 'package:green_campus_app/app/data/widgets/form_foto.dart';
import 'package:green_campus_app/app/data/widgets/main_container.dart';
import 'package:green_campus_app/app/data/widgets/tile.dart';
import 'package:green_campus_app/app/routes/app_pages.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/challenges_show_controller.dart';

class ChallengesShowView extends GetView<ChallengesShowController> {
  const ChallengesShowView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GCMainContainer(
      scrollable: true,
      children: [
        GCAppBar(
          label: 'challengeDetail'.tr,
          svgIcon: svg_ic_challenge_a,
          showNotification: false,
        ),
        16.height,
        GCFormFoto(
          showFrame: true,
          defaultPath: img_green_challenge,
          oldPath: controller.challenge.foto ?? '',
          showButton: false,
        ),
        16.height,
        GCCardColumn(
          children: [
            GCTile(
              leading: Icon(
                Icons.task_alt_rounded,
                color: primaryColor(context),
              ),
              label: 'title'.tr,
              value: controller.challenge.title ?? '',
            ),
            GCTile(
              leading: SvgPicture.asset(svg_gp),
              label: 'reward'.tr,
              value:
                  "${decimalFormatter(controller.challenge.rewards)} ${'gp'.tr}",
            ),
            GCTile(
              verticalAlignment: CrossAxisAlignment.start,
              leading: Icon(
                Icons.task_alt_rounded,
                color: primaryColor(context),
              ),
              label: 'description'.tr,
              value: controller.challenge.description ?? '',
            ),
          ],
        ),
        16.height,
        GCButton(
            title: 'startChallenge'.tr,
            onPressed: () {
              Get.toNamed(Routes.ACTIVITY_FORM,
                  arguments: controller.challenge);
            })
      ],
    ));
  }
}
