import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:green_campus_app/app/data/helpers/assets.dart';
import 'package:green_campus_app/app/data/helpers/themes.dart';
import 'package:green_campus_app/app/data/models/bike_model.dart';
import 'package:green_campus_app/app/data/models/facility_model.dart';
import 'package:green_campus_app/app/data/widgets/app_bar.dart';
import 'package:green_campus_app/app/data/widgets/button.dart';
import 'package:green_campus_app/app/data/widgets/card_column.dart';
import 'package:green_campus_app/app/data/widgets/main_container.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../controllers/save_qr_controller.dart';

class SaveQrView extends GetView<SaveQrController> {
  const SaveQrView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GCMainContainer(
        scrollable: false,
        children: [
          GCAppBar(
              label: 'saveQr'.tr, svgIcon: svg_logo, showNotification: false),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RepaintBoundary(
                  key: controller.globalKey,
                  child: Obx(
                    () => GCCardColumn(
                      crossAxis: CrossAxisAlignment.center,
                      padding: 20,
                      children: [
                        if (controller.bike is BikeModel) ...[
                          Text(
                            'bikeSharingQr'.tr,
                            style: textTheme(context).titleMedium?.copyWith(
                                color: primaryColor(context),
                                fontWeight: FontWeight.w600),
                          ),
                          4.height,
                          Text(
                            controller.bike!.name,
                            style: textTheme(context).titleSmall,
                          ),
                          24.height,
                        ],
                        if (controller.facility is FacilityModel) ...[
                          Text(
                            'bikeStationQr'.tr,
                            style: textTheme(context).titleMedium?.copyWith(
                                color: primaryColor(context),
                                fontWeight: FontWeight.w600),
                          ),
                          4.height,
                          Text(
                            controller.facility!.name,
                            style: textTheme(context).titleSmall,
                          ),
                          24.height,
                        ],
                        QrImageView(
                          data: controller.data,
                          embeddedImageStyle: QrEmbeddedImageStyle(),
                          dataModuleStyle: QrDataModuleStyle(
                              dataModuleShape: QrDataModuleShape.circle,
                              color: theme(context).primaryColor),
                          eyeStyle: QrEyeStyle(
                              eyeShape: QrEyeShape.circle,
                              color: primaryColor(context)),
                          version: QrVersions.auto,
                        ),
                        24.height,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              svg_logo,
                              height: 48,
                            ),
                            12.width,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'generatedBy'.tr,
                                  style: textTheme(context)
                                      .labelMedium
                                      ?.copyWith(color: secondTextColor),
                                ),
                                Text(
                                  'greenCampusApp'.tr,
                                  style: textTheme(context)
                                      .titleMedium
                                      ?.copyWith(color: primaryColor(context)),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                20.height,
                // ElevatedButton(
                //   onPressed: controller.saveQrCode,
                //   child: Text('Save to Gallery'),
                // ),
                Obx(
                  () => GCButton(
                    title:
                        controller.isLoading ? 'wait'.tr : 'saveToGallery'.tr,
                    onPressed:
                        controller.isLoading ? null : controller.saveQrCode,
                    icon: Icon(Icons.download),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
