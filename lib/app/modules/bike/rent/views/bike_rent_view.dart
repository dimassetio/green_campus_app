import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:green_campus_app/app/data/helpers/assets.dart';
import 'package:green_campus_app/app/data/helpers/themes.dart';
import 'package:green_campus_app/app/data/models/rent_model.dart';
import 'package:green_campus_app/app/data/widgets/app_bar.dart';
import 'package:green_campus_app/app/data/widgets/card_column.dart';
import 'package:green_campus_app/app/data/widgets/main_container.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/bike_rent_controller.dart';

class BikeRentView extends GetView<BikeRentController> {
  const BikeRentView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GCMainContainer(scrollable: false, children: [
        GCAppBar(
          label: 'rentABike'.tr,
          svgIcon: svg_ic_bike_a,
          showNotification: false,
        ),
        16.height,
        Expanded(
          child: GCCardColumn(
            padding: 8,
            children: [
              Expanded(
                child: Obx(
                  () => controller.isLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: MobileScanner(
                            controller: controller.controller,
                            onDetect: controller.handleBarcode,
                            errorBuilder: (p0, p1, p2) => Center(
                              child: Icon(
                                Icons.error,
                                size: Get.width / 2,
                                color: primaryColor(context),
                              ),
                            ),
                            placeholderBuilder: (p0, p1) => Center(
                              child: Icon(
                                Icons.qr_code_scanner_rounded,
                                size: Get.width / 2,
                                color: primaryColor(context),
                              ),
                            ),
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
        16.height,
        Obx(
          () => GCCardColumn(
            children: [
              Center(
                child: Text(
                  controller.rentModel is RentModel
                      ? 'finishInstructions'.tr
                      : 'rentalInstructions'.tr,
                  style: textTheme(context).titleMedium,
                ),
              ),
              8.height,
              ...List.generate(
                controller.rentModel is RentModel
                    ? controller.finishInstructions.length
                    : controller.instructions.length,
                (index) => Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: 24, child: Text('${index + 1}.')),
                    Expanded(
                        child: Text(controller.rentModel is RentModel
                            ? controller.finishInstructions[index]
                            : controller.instructions[index])),
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
