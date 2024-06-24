import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:green_campus_app/app/data/helpers/assets.dart';
import 'package:green_campus_app/app/data/helpers/formatter.dart';
import 'package:green_campus_app/app/data/helpers/themes.dart';
import 'package:green_campus_app/app/data/widgets/app_bar.dart';
import 'package:green_campus_app/app/data/widgets/card_column.dart';
import 'package:green_campus_app/app/data/widgets/error.dart';
import 'package:green_campus_app/app/data/widgets/main_container.dart';
import 'package:green_campus_app/app/data/widgets/tile.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../controllers/redemption_show_controller.dart';

class RedemptionShowView extends GetView<RedemptionShowController> {
  const RedemptionShowView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => controller.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : controller.redemptionModel == null
                ? GCErrorWidget(
                    message:
                        'failedLoadData'.trParams({'data': 'redemption'.tr}),
                  )
                : GCMainContainer(
                    scrollable: true,
                    children: [
                      GCAppBar(
                        label: 'redemption'.tr,
                        svgIcon: svg_logo,
                        showNotification: false,
                      ),
                      16.height,
                      Obx(
                        () => controller.redemptionModel!.isRedeemed
                            ? GCCardColumn(
                                crossAxis: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(svg_confirmation),
                                  16.height,
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'redeemConfirmed'.tr,
                                      style: textTheme(context).titleMedium,
                                    ),
                                  ),
                                ],
                              )
                            : GCCardColumn(
                                crossAxis: CrossAxisAlignment.center,
                                children: [
                                  QrImageView(
                                    padding: EdgeInsets.all(16),
                                    data: controller.redemptionModel!.code,
                                    embeddedImageStyle: QrEmbeddedImageStyle(),
                                    dataModuleStyle: QrDataModuleStyle(
                                        dataModuleShape:
                                            QrDataModuleShape.circle,
                                        color: theme(context).primaryColor),
                                    eyeStyle: QrEyeStyle(
                                        eyeShape: QrEyeShape.circle,
                                        color: primaryColor(context)),
                                    version: QrVersions.auto,
                                  ),
                                  8.height,
                                  Text(
                                    'redeemInstruction'.tr,
                                    style: textTheme(context).titleMedium,
                                  ),
                                  16.height,
                                  ...List.generate(
                                    controller.instructions.length,
                                    (index) => Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                            width: 24,
                                            child: Text('${index + 1}.')),
                                        Expanded(
                                            child: Text(controller
                                                .instructions[index])),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                      ),
                      16.height,
                      GCCardColumn(
                        children: [
                          Text(
                            'redemptionInfo'.tr,
                            style: textTheme(context).titleMedium,
                          ),
                          GCTile(
                              leading: Icon(
                                Icons.calendar_today_rounded,
                                color: primaryColor(context),
                              ),
                              label: 'dateCreated'.tr,
                              value: dateTimeFormatter(
                                  controller.redemptionModel!.dateCreated)),
                          GCTile(
                              leading: Icon(
                                Icons.check_circle_outline,
                                color: primaryColor(context),
                              ),
                              label: 'status'.tr,
                              value: controller.redemptionModel!.isRedeemed
                                  ? 'invalid'.tr
                                  : 'valid'.tr),
                          if (controller.redemptionModel!.isRedeemed)
                            GCTile(
                                leading: Icon(
                                  Icons.calendar_today_rounded,
                                  color: primaryColor(context),
                                ),
                                label: 'dateRedeemed'.tr,
                                value: dateTimeFormatter(
                                    controller.redemptionModel!.redeemed)),
                        ],
                      ),
                      16.height,
                      Obx(
                        () => GCCardColumn(
                          children: [
                            Text(
                              'productInfo'.tr,
                              style: textTheme(context).titleMedium,
                            ),
                            8.height,
                            if (controller.isLoading) LinearProgressIndicator(),
                            if (!controller.isLoading) ...[
                              GCTile(
                                label: 'productName',
                                value:
                                    "${controller.redemptionModel?.productModel?.title}",
                                leading: Icon(
                                  Icons.card_giftcard_outlined,
                                  color: primaryColor(context),
                                ),
                              ),
                              GCTile(
                                label: 'store',
                                leading: Icon(
                                  Icons.store_mall_directory_outlined,
                                  color: primaryColor(context),
                                ),
                                value:
                                    "${controller.redemptionModel?.productModel?.store}",
                              ),
                            ],
                          ],
                        ),
                      ),
                      16.height,
                    ],
                  ),
      ),
    );
  }
}
