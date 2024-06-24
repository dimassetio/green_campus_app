// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:green_campus_app/app/data/helpers/assets.dart';
import 'package:green_campus_app/app/data/helpers/themes.dart';
import 'package:green_campus_app/app/data/models/facility_model.dart';
import 'package:green_campus_app/app/data/widgets/app_bar.dart';
import 'package:green_campus_app/app/data/widgets/form_foto.dart';
import 'package:green_campus_app/app/data/widgets/main_container.dart';
import 'package:green_campus_app/app/data/widgets/notif_drawer.dart';
import 'package:green_campus_app/app/data/widgets/tile.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/facilities_map_controller.dart';

class FacilitiesMapView extends GetView<FacilitiesMapController> {
  FacilitiesMapView({Key? key}) : super(key: key);
  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: GCBottomBar(selectedIndex: 2),
      endDrawer: NotifDrawer(),
      body: Stack(children: [
        Obx(
          () => GoogleMap(
            onMapCreated: controller.onMapCreated,
            mapType: MapType.normal,
            markers: controller.markers.toSet(),
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            zoomControlsEnabled: false,
            padding: EdgeInsets.only(bottom: 80, top: 100),
            cameraTargetBounds: CameraTargetBounds(controller.mapBounds),
            onCameraMove: controller.onCameraMove,
            // liteModeEnabled: true,
            // onTap: controller.onTapMap,
            initialCameraPosition: controller.cameraPosition,
          ),
        ),
        GCMainContainer(scrollable: false, children: [
          GCAppBar(label: 'susMap'.tr, svgIcon: svg_ic_map_a),
          16.height,
        ]),
      ]),
    );
  }
}

class FacilityDetail extends StatelessWidget {
  const FacilityDetail({
    super.key,
    required this.facility,
  });

  final FacilityModel facility;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'facilityDetail'.tr,
            style: textTheme(context).titleMedium,
          ),
          12.height,
          GCFormFoto(
            height: 150,
            defaultPath: img_logo,
            oldPath: facility.foto ?? '',
            showButton: false,
          ),
          12.height,
          GCTile(
              leading: Image.asset(
                getMapIcon(facility.type),
                height: 32,
                width: 32,
              ),
              label: 'name'.tr,
              value: facility.name),
          if (facility.building is String)
            GCTile(
                leading: Icon(
                  Icons.location_city_outlined,
                  color: primaryColor(context),
                ),
                label: 'building'.tr,
                value: facility.building!),
          GCTile(label: 'description'.tr, value: facility.description),
        ],
      ),
    );
  }
}
