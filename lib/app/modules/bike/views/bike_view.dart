import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:green_campus_app/app/data/helpers/assets.dart';
import 'package:green_campus_app/app/data/helpers/const.dart';
import 'package:green_campus_app/app/data/helpers/formatter.dart';
import 'package:green_campus_app/app/data/helpers/themes.dart';
import 'package:green_campus_app/app/data/models/rent_model.dart';
import 'package:green_campus_app/app/data/widgets/app_bar.dart';
import 'package:green_campus_app/app/data/widgets/bottom_bar.dart';
import 'package:green_campus_app/app/data/widgets/button.dart';
import 'package:green_campus_app/app/data/widgets/card_column.dart';
import 'package:green_campus_app/app/data/widgets/circle_container.dart';
import 'package:green_campus_app/app/data/widgets/main_container.dart';
import 'package:green_campus_app/app/data/widgets/notif_drawer.dart';
import 'package:green_campus_app/app/modules/bike/views/bike_station_card.dart';
import 'package:green_campus_app/app/routes/app_pages.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/bike_controller.dart';

class BikeView extends GetView<BikeController> {
  const BikeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GCBottomBar(selectedIndex: 3),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      endDrawer: NotifDrawer(),
      body: GCMainContainer(
        scrollable: true,
        children: [
          GCAppBar(
            label: 'bikeSharing'.tr,
            svgIcon: svg_ic_bike_a,
          ),
          16.height,
          GCCardColumn(
            padding: 8,
            children: [
              AspectRatio(
                aspectRatio: 2 / 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: GoogleMap(
                      initialCameraPosition:
                          CameraPosition(target: coordinatUM, zoom: 17)),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              children: [
                Text(
                  'bikeStationLocation'.tr,
                  style: textTheme(context).titleMedium,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 120,
            child: Obx(() => ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: controller.stations.length,
                  itemBuilder: (context, index) => BikeStationCard(
                      width: (Get.width - 40) * 0.9,
                      facility: controller.stations[index]),
                )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'rentalHistory'.tr,
                    style: textTheme(context).titleMedium,
                  ),
                  if (!controller.hasActiveRent)
                    GCButton(
                        title: 'rentABike'.tr,
                        icon: Icon(Icons.add_rounded),
                        onPressed: () {
                          Get.toNamed(Routes.BIKE_RENT);
                        }),
                ],
              ),
            ),
          ),
          Obx(() => ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: controller.rents.length,
                itemBuilder: (context, index) =>
                    RentCard(rent: controller.rents[index]),
              )),
        ],
      ),
    );
  }
}

class RentCard extends StatelessWidget {
  const RentCard({
    super.key,
    required this.rent,
  });

  final RentModel rent;

  @override
  Widget build(BuildContext context) {
    return GCCardColumn(
      margin: EdgeInsets.symmetric(vertical: 8),
      onPressed: rent.isActive
          ? () {
              Get.toNamed(Routes.BIKE_RENT, arguments: rent);
            }
          : null,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              rent.bikeName,
              style: textTheme(context).titleSmall,
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
        if (rent.verificatorId is String)
          FutureBuilder(
              future: rent.getVerificator(),
              builder: (context, snapshot) {
                return Text(
                  'Verified by: ${snapshot.data?.name ?? '--'} ',
                  style: textTheme(context).labelMedium,
                ).marginOnly(top: 4);
              }),
      ],
    );
  }
}
