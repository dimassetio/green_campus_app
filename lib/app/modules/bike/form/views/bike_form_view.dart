import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:green_campus_app/app/data/helpers/assets.dart';
import 'package:green_campus_app/app/data/models/bike_model.dart';
import 'package:green_campus_app/app/data/models/facility_model.dart';
import 'package:green_campus_app/app/data/widgets/app_bar.dart';
import 'package:green_campus_app/app/data/widgets/button.dart';
import 'package:green_campus_app/app/data/widgets/card_column.dart';
import 'package:green_campus_app/app/data/widgets/dropdown_menu.dart';
import 'package:green_campus_app/app/data/widgets/main_container.dart';
import 'package:green_campus_app/app/data/widgets/text_field.dart';
import 'package:green_campus_app/app/routes/app_pages.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/bike_form_controller.dart';

class BikeFormView extends GetView<BikeFormController> {
  const BikeFormView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: controller.formKey,
        child: GCMainContainer(scrollable: true, children: [
          GCAppBar(
            label: 'bikeForm'.tr,
            svgIcon: svg_ic_bike_a,
            showNotification: false,
          ),
          16.height,
          controller.formFoto,
          16.height,
          GCCardColumn(
            children: [
              GCDropdown(
                icon: Icon(Icons.pedal_bike_outlined),
                label: 'type'.tr,
                initValue: controller.selectedType.value,
                listValue: BikeType.list,
                isValidationRequired: true,
                onChanged: (value) => controller.selectedType.value = value,
              ),
              16.height,
              GCTextfield(
                controller: controller.nameC,
                label: 'name'.tr,
                icon: Icon(Icons.pedal_bike_rounded),
                isValidationRequired: true,
              ),
              16.height,
              GCTextfield(
                controller: controller.descriptionC,
                label: 'description'.tr,
                icon: Icon(Icons.info_outline_rounded),
                isValidationRequired: true,
                textFieldType: TextFieldType.MULTILINE,
              ),
              16.height,
              GCDropdown(
                icon: Icon(Icons.check_circle_outline_rounded),
                label: 'status'.tr,
                initValue: controller.selectedStatus.value,
                listValue: BikeStatus.list,
                isValidationRequired: true,
                onChanged: (value) => controller.selectedStatus.value = value,
              ),
              16.height,
              Obx(
                () => controller.isLoadingStations
                    ? LinearProgressIndicator()
                    : GCDropdown(
                        icon: Icon(Icons.electric_bike),
                        label: 'bikeStation'.tr,
                        initValue: controller.selectedStation.value,
                        listValue: controller.bikeStations,
                        isValidationRequired: true,
                        titleFunction: (value) =>
                            (value as FacilityModel?)?.name ?? '',
                        onChanged: (value) =>
                            controller.selectedStation.value = value,
                      ),
              ),
            ],
          ),
          16.height,
          Obx(() => Row(
                children: [
                  if (controller.bike is BikeModel) ...[
                    GCButton(
                        icon: Icon(Icons.qr_code_2_rounded),
                        title: 'showQr'.tr,
                        onPressed: () {
                          Get.toNamed(Routes.SAVE_QR,
                              arguments: controller.bike!);
                        }),
                    16.width,
                  ],
                  Expanded(
                    child: GCButton(
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
                    ),
                  ),
                ],
              )),
          16.height,
        ]),
      ),
    );
  }
}
