import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:green_campus_app/app/data/helpers/assets.dart';
import 'package:green_campus_app/app/data/helpers/const.dart';
import 'package:green_campus_app/app/data/helpers/themes.dart';
import 'package:green_campus_app/app/data/models/facility_model.dart';
import 'package:green_campus_app/app/modules/facilities/map/views/facilities_map_view.dart';

class FacilitiesMapController extends GetxController {
  GoogleMapController? mapController;

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    setMapStyle();
  }

  RxList<FacilityModel> facilities = RxList();

  Stream<List<FacilityModel>> streamFacilities() {
    return FacilityModel.getCollection.snapshots().map((event) =>
        event.docs.map((e) => FacilityModel.fromSnapshot(e)).toList());
  }

  BitmapDescriptor? getIcon(String key) {
    if (iconList.containsKey(key)) {
      return iconList[key];
    }
    return null;
  }

  RxMap<String, BitmapDescriptor> iconList = <String, BitmapDescriptor>{}.obs;

  void loadIcon() async {
    FacilityType.list
        .forEach((e) async => await BitmapDescriptor.fromAssetImage(
              ImageConfiguration(),
              getMapIcon(e),
            ).then((value) => iconList.addEntries({e: value}.entries)));
  }

  RxList<Marker> markers = RxList();

  void loadMarkers() {
    print("LOAD MARKERS");
    markers.assignAll(
        facilities.map((facility) => createMarker(facility)).toList());
    print("${markers.length}");
  }

  Marker createMarker(FacilityModel facility) {
    return Marker(
      markerId: MarkerId(facility.id),
      position: LatLng(facility.location.latitude, facility.location.longitude),
      draggable: true,
      icon: getIcon(facility.type) ?? BitmapDescriptor.defaultMarker,
      onTap: () {
        if (Get.context is BuildContext) {
          Get.bottomSheet(
              FacilityDetail(
                facility: facility,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              backgroundColor: theme(Get.context).scaffoldBackgroundColor);
        }
        print(
            'Marker tapped: ${facility.location.latitude}_${facility.location.longitude}');
      },
    );
  }

  String jsonStyle = '''
      [
        {
          "elementType": "labels",
          "stylers": [
            {
              "visibility": "off"
            }
          ]
        }
      ]
    ''';

  void setMapStyle() {
    if (mapController is GoogleMapController) {
      mapController!.setMapStyle(jsonStyle);
    }
  }

  CameraPosition cameraPosition = CameraPosition(target: coordinatUM, zoom: 17);

  LatLngBounds mapBounds =
      LatLngBounds(southwest: southWest, northeast: northEast);

  void onCameraMove(CameraPosition position) {
    // If the camera moves outside the bounds, move it back
    if (!mapBounds.contains(position.target)) {
      mapController?.animateCamera(
          // CameraUpdate.newLatLngBounds(mapBounds, 0),
          CameraUpdate.newCameraPosition(cameraPosition));
    }
  }

  @override
  void onInit() {
    super.onInit();
    facilities.bindStream(streamFacilities());
    loadMarkers();
    loadIcon();
    ever(facilities, (callback) => loadMarkers());
    ever(iconList, (callback) => loadMarkers());
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    facilities.close();
    iconList.close();
    mapController?.dispose();

    super.onClose();
  }
}
