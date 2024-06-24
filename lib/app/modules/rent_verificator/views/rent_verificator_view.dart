import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:green_campus_app/app/data/helpers/assets.dart';
import 'package:green_campus_app/app/data/helpers/formatter.dart';
import 'package:green_campus_app/app/data/helpers/themes.dart';
import 'package:green_campus_app/app/data/models/facility_model.dart';
import 'package:green_campus_app/app/data/models/rent_model.dart';
import 'package:green_campus_app/app/data/widgets/card_column.dart';
import 'package:green_campus_app/app/data/widgets/circle_container.dart';
import 'package:green_campus_app/app/data/widgets/dialog.dart';
import 'package:green_campus_app/app/data/widgets/main_container.dart';
import 'package:green_campus_app/app/modules/auth/controllers/auth_controller.dart';
import 'package:green_campus_app/app/modules/bike/views/bike_station_card.dart';
import 'package:green_campus_app/app/routes/app_pages.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/rent_verificator_controller.dart';

class RentVerificatorView extends GetView<RentVerificatorController> {
  const RentVerificatorView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GCMainContainer(scrollable: true, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            48.width,
            CircleContainer(
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      svg_ic_bike_a,
                      height: 28,
                    ),
                    12.width,
                    Text(
                      'rentVerificator'.tr,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme(context).titleMedium,
                    )
                  ],
                )),
            CircleContainer(
              child: IconButton(
                onPressed: () {
                  Get.toNamed(Routes.PROFILE);
                },
                icon: Icon(
                  Icons.person,
                  color: primaryColor(context),
                ),
              ),
            )
          ],
        ),
        16.height,
        // GCCardColumn(
        //   children: [
        Row(
          children: [
            CircleAvatar(
              radius: 30,
              child: Text(authC.user.name?[0] ?? ''),
              foregroundImage: authC.user.foto is String
                  ? CachedNetworkImageProvider(authC.user.foto!)
                  : null,
            ),
            12.width,
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'welcomeBack'.tr,
                    style: textTheme(context).labelMedium,
                  ),
                  Text(
                    authC.user.name ?? 'Name',
                    style: textTheme(context).titleMedium,
                  )
                ],
              ),
            ),
            CircleContainer(
              color: primaryColor(context),
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
              child: Text(
                authC.user.role ?? '',
                style: textTheme(context)
                    .labelMedium
                    ?.copyWith(color: theme(context).colorScheme.onPrimary),
              ),
            ),
          ],
        ),
        16.height,
        Obx(
          () => controller.getCurrentFacility is FacilityModel
              ? BikeStationCard(facility: controller.getCurrentFacility!)
              : SizedBox(),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "activeRent".tr,
            style: textTheme(context).titleMedium,
          ),
        ),
        16.height,
        Obx(() => ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: controller.activeRents.length,
              itemBuilder: (context, index) =>
                  VerificatorRentCard(rent: controller.activeRents[index]),
            ))
      ]),
    );
  }
}

class VerificatorRentCard extends StatelessWidget {
  const VerificatorRentCard({
    super.key,
    required this.rent,
  });

  final RentModel rent;

  @override
  Widget build(BuildContext context) {
    return GCCardColumn(
      margin: EdgeInsets.symmetric(vertical: 8),
      onPressed: () {
        if (rent.needVerification) {
          Get.dialog(
            GCDialog(
              title: 'verificationConfirmation'.tr,
              subtitle: 'verificationConfirmationMessage'.tr,
              negativeText: 'cancel'.tr,
              onConfirm: () async {
                rent.verificatorId = authC.user.id;
                await rent.save();
                Get.back();
                Get.snackbar('success'.tr, 'successVerification'.tr);
              },
            ),
          );
        }
      },
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FutureBuilder(
                      future: rent.getUser(),
                      builder: (context, snapshot) {
                        return Text(
                          snapshot.data?.name ?? '............',
                          style: textTheme(context).titleSmall,
                        );
                      }),
                  2.height,
                  Text(
                    rent.bikeName,
                    style: textTheme(context)
                        .labelMedium
                        ?.copyWith(color: secondTextColor),
                  ),
                ],
              ),
            ),
            CircleContainer(
              color: rent.isActive
                  ? primaryColor(context)
                  : rent.needVerification
                      ? theme(context).colorScheme.secondary
                      : null,
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
              child: Text(
                rent.getStatus(),
                style: textTheme(context).labelMedium?.copyWith(
                    color: rent.isActive
                        ? theme(context).colorScheme.onPrimary
                        : rent.needVerification
                            ? theme(context).colorScheme.onSecondary
                            : null),
              ),
            ),
          ],
        ),
        4.height,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'start'.tr,
                  style: textTheme(context)
                      .labelMedium
                      ?.copyWith(color: textSecondaryColor),
                ),
                Text(timeFormatter(rent.dateStart)),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'finish'.tr,
                  style: textTheme(context)
                      .labelMedium
                      ?.copyWith(color: textSecondaryColor),
                ),
                Text(
                    rent.isActive ? '-- : --' : timeFormatter(rent.dateFinish)),
              ],
            ),
            Text(dateFormatter(rent.dateStart)),
          ],
        ),
      ],
    );
  }
}
