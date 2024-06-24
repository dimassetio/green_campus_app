import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_campus_app/app/data/helpers/assets.dart';
import 'package:green_campus_app/app/data/helpers/formatter.dart';
import 'package:green_campus_app/app/data/widgets/app_bar.dart';
import 'package:green_campus_app/app/data/widgets/button.dart';
import 'package:green_campus_app/app/data/widgets/card_column.dart';
import 'package:green_campus_app/app/data/widgets/dropdown_menu.dart';
import 'package:green_campus_app/app/data/widgets/main_container.dart';
import 'package:green_campus_app/app/data/widgets/text_field.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/challenges_form_controller.dart';

class ChallengesFormView extends GetView<ChallengesFormController> {
  const ChallengesFormView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: controller.formKey,
        child: GCMainContainer(scrollable: true, children: [
          GCAppBar(
            label: 'addChallenge'.tr,
            svgIcon: svg_ic_challenge_a,
            showNotification: false,
          ),
          16.height,
          controller.formFoto,
          16.height,
          GCCardColumn(
            children: [
              GCTextfield(
                controller: controller.titleC,
                label: 'title'.tr,
                icon: Icon(Icons.military_tech_outlined),
                isValidationRequired: true,
              ),
              16.height,
              GCTextfield(
                controller: controller.rewardC,
                label: 'reward'.tr,
                icon: Icon(Icons.stars_rounded),
                isValidationRequired: true,
                digitsOnly: true,
                textFieldType: TextFieldType.NUMBER,
              ),
              16.height,
              GCTextfield(
                controller: controller.descriptionC,
                label: 'description'.tr,
                icon: Icon(Icons.info_outline_rounded),
                isValidationRequired: true,
                textFieldType: TextFieldType.MULTILINE,
              ),
            ],
          ),
          16.height,
          GCCardColumn(
            children: [
              GCDropdown(
                icon: Icon(Icons.check_circle_outline_rounded),
                label: 'status'.tr,
                initValue: controller.isActive.value,
                listValue: [true, false],
                titleFunction: (value) => value ? 'aktif'.tr : 'nonaktif'.tr,
                onChanged: (value) => controller.isActive.value = value,
              ),
              16.height,
              GCTextfield(
                  controller: controller.startDateC,
                  icon: Icon(Icons.calendar_month_outlined),
                  label: 'startDate'.tr,
                  isReadOnly: true,
                  onTap: () async {
                    var date = await controller.pickDate(context);
                    if (date is DateTime) {
                      controller.startDateC.text = dateFormatter(date);
                      controller.startDate.value = date;
                    }
                  }),
              16.height,
              GCTextfield(
                  controller: controller.endDateC,
                  icon: Icon(Icons.calendar_month_outlined),
                  label: 'endDate'.tr,
                  isReadOnly: true,
                  onTap: () async {
                    var date = await controller.pickDate(context);
                    if (date is DateTime) {
                      controller.endDateC.text = dateFormatter(date);
                      controller.endDate.value = date;
                    }
                  }),
            ],
          ),
          16.height,
          Obx(() => GCButton(
                icon: controller.isLoading
                    ? Expanded(child: LinearProgressIndicator())
                    : null,
                title: controller.isLoading ? '' : 'submit'.tr,
                onPressed: controller.isLoading
                    ? null
                    : () {
                        if (controller.formKey.currentState?.validate() ??
                            false) controller.save();
                      },
              )),
          16.height,
        ]),
      ),
    );
  }
}
