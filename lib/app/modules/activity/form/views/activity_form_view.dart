import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:green_campus_app/app/data/helpers/assets.dart';
import 'package:green_campus_app/app/data/models/challenge_model.dart';
import 'package:green_campus_app/app/data/widgets/app_bar.dart';
import 'package:green_campus_app/app/data/widgets/button.dart';
import 'package:green_campus_app/app/data/widgets/card_column.dart';
import 'package:green_campus_app/app/data/widgets/dialog.dart';
import 'package:green_campus_app/app/data/widgets/dropdown_menu.dart';
import 'package:green_campus_app/app/data/widgets/main_container.dart';
import 'package:green_campus_app/app/data/widgets/text_field.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/activity_form_controller.dart';

class ActivityFormView extends GetView<ActivityFormController> {
  const ActivityFormView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: controller.formKey,
        child: GCMainContainer(scrollable: true, children: [
          GCAppBar(
              showNotification: false,
              label: 'activityForm',
              svgIcon: svg_ic_challenge_a),
          16.height,
          GCCardColumn(
            children: [
              controller.formFoto,
            ],
          ),
          16.height,
          GCCardColumn(
            children: [
              Obx(
                () => GCDropdown(
                  listValue: controller.challenges,
                  initValue: controller.selectedChallenge,
                  titleFunction: (value) =>
                      (value as ChallengeModel?)?.title ?? '',
                  onChanged: controller.loadingChallenge.value
                      ? null
                      : (value) {
                          controller.selectedChallenge = value;
                        },
                  label: 'selectChallenges'.tr,
                  icon: controller.loadingChallenge.value
                      ? Container(
                          padding: EdgeInsets.all(12),
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(),
                        )
                      : Icon(Icons.military_tech_outlined),
                ),
              ),
              16.height,
              GCTextfield(
                isReadOnly: true,
                controller: controller.timeC,
                label: 'activityTime'.tr,
                icon: Icon(Icons.access_time_outlined),
              ),
              16.height,
              Obx(
                () => GCTextfield(
                  label: 'activityLocation'.tr,
                  icon: Icon(Icons.location_on_outlined),
                  maxLine: 2,
                  controller: controller.positionC,
                  validator: (p0) {
                    if (controller.position == null) {
                      return 'locationValidation'.tr;
                    }
                    return null;
                  },
                  isReadOnly: true,
                  suffixIcon: controller.isLoading
                      ? Container(
                          padding: EdgeInsets.all(12),
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(),
                        )
                      : IconButton(
                          onPressed: controller.loadLocation,
                          icon: Icon(Icons.location_searching_rounded)),
                ),
              ),
            ],
          ),
          16.height,
          Obx(
            () => GCButton(
                icon: controller.isLoading
                    ? Expanded(child: LinearProgressIndicator())
                    : null,
                title: controller.isLoading ? '' : 'submit'.tr,
                onPressed: controller.isLoading
                    ? null
                    : () async {
                        if (controller.formKey.currentState?.validate() ??
                            false) {
                          if (controller.formFoto.newPath.isEmptyOrNull) {
                            await showDialog(
                              context: context,
                              builder: (context) => GCDialog(
                                  title: 'addPhoto'.tr,
                                  subtitle: 'addPhotoMessage'.tr),
                            );
                          } else {
                            controller.save();
                          }
                        }
                      }),
          )
        ]),
      ),
    );
  }
}
