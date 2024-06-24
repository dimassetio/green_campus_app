import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:green_campus_app/app/data/helpers/assets.dart';
import 'package:green_campus_app/app/data/helpers/formatter.dart';
import 'package:green_campus_app/app/data/helpers/themes.dart';
import 'package:green_campus_app/app/data/models/product_model.dart';
import 'package:green_campus_app/app/data/models/redemption_model.dart';
import 'package:green_campus_app/app/data/models/user_model.dart';
import 'package:green_campus_app/app/data/widgets/app_bar.dart';
import 'package:green_campus_app/app/data/widgets/button.dart';
import 'package:green_campus_app/app/data/widgets/card_column.dart';
import 'package:green_campus_app/app/data/widgets/circle_container.dart';
import 'package:green_campus_app/app/data/widgets/dialog.dart';
import 'package:green_campus_app/app/data/widgets/form_foto.dart';
import 'package:green_campus_app/app/data/widgets/main_container.dart';
import 'package:green_campus_app/app/data/widgets/tile.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/admin_redemption_controller.dart';

class AdminRedemptionView extends GetView<AdminRedemptionController> {
  const AdminRedemptionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GCMainContainer(
        scrollable: true,
        children: [
          GCAppBar(label: 'redemption'.tr, svgIcon: svg_logo),
          16.height,
          Obx(
            () => GCCardColumn(
              children: [
                GCTile(
                  leading: SvgPicture.asset(svg_gp),
                  label: 'totalRedemption',
                  value:
                      "${decimalFormatter(controller.getTotalRedemption)} ${'gp'.tr}",
                ),
                FutureBuilder<Map<String, int>>(
                  future: controller.totalRedemptionByStore(),
                  builder: (context, snapshot) => ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: snapshot.data?.keys.length ?? 0,
                    itemBuilder: (context, index) => GCTile(
                        leading: SvgPicture.asset(svg_gp),
                        label: snapshot.data!.keys.toList()[index],
                        value:
                            "${decimalFormatter(snapshot.data![snapshot.data!.keys.toList()[index]])} ${'gp'.tr}"),
                  ),
                ),
              ],
            ),
          ),
          8.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'allRedemptions'.tr,
                style: textTheme(context)
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w500),
              ),
              GCButton(
                title: 'scan'.tr,
                icon: Icon(Icons.qr_code_scanner_rounded),
                onPressed: () {},
              )
            ],
          ),
          8.height,
          Obx(() => ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: controller.redemptions.length,
                itemBuilder: (context, index) => AdminRedemptionCard(
                  redemption: controller.redemptions[index],
                ),
              )),
        ],
      ),
    );
  }
}

class AdminRedemptionCard extends StatelessWidget {
  const AdminRedemptionCard({
    super.key,
    required this.redemption,
  });

  final RedemptionModel redemption;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ProductModel?>(
        future: redemption.getProduct(),
        builder: (context, snapshot) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: InkWell(
              onTap: () {
                if (!redemption.isRedeemed) {
                  showDialog(
                    context: context,
                    builder: (context) => GCDialog(
                      title: 'confirmRedeem'.tr,
                      subtitle: 'confirmRedeemMessage'.tr,
                      negativeText: 'cancel'.tr,
                      onConfirm: () async {
                        await redemption.confirmRedeem(DateTime.now());
                        Get.back();
                        Get.snackbar('success'.tr, 'succeConfirmRedeem'.tr);
                      },
                    ),
                  );
                }
                // Get.toNamed(Routes.ACTIVITY_SHOW, arguments: activity);
              },
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    GCFormFoto(
                      oldPath: redemption.productModel?.foto ?? '',
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
                          FutureBuilder<UserModel?>(
                            future: redemption.getUser(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return LinearProgressIndicator();
                              }
                              if (snapshot.data?.name is String) {
                                return Text(
                                  snapshot.data!.name!,
                                  style: textTheme(context)
                                      .titleSmall
                                      ?.copyWith(fontWeight: FontWeight.w600),
                                );
                              }
                              return SizedBox();
                            },
                          ),
                          Text(
                            redemption.productModel?.title ?? "",
                          ),
                          4.height,
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset(svg_gp, width: 24),
                              Text(
                                  "  ${decimalFormatter(redemption.pointsRedeemed)} ${'gp'.tr}"),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    CircleContainer(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 2, horizontal: 8),
                                      color: redemption.isRedeemed
                                          ? primaryColor(context)
                                          : theme(context)
                                              .colorScheme
                                              .secondary,
                                      margin: EdgeInsets.only(bottom: 4),
                                      child: Text(
                                        (redemption.isRedeemed
                                                ? 'verified'
                                                : 'unverified')
                                            .tr,
                                        style: textTheme(context)
                                            .labelMedium
                                            ?.copyWith(
                                              color: redemption.isRedeemed
                                                  ? theme(context)
                                                      .colorScheme
                                                      .onPrimary
                                                  : theme(context)
                                                      .colorScheme
                                                      .onSecondary,
                                            ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        dateTimeFormatter(
                                            redemption.dateCreated),
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
        });
  }
}
