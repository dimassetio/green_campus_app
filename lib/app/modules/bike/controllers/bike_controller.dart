import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:green_campus_app/app/data/helpers/formatter.dart';
import 'package:green_campus_app/app/data/models/facility_model.dart';
import 'package:green_campus_app/app/data/models/rent_model.dart';
import 'package:green_campus_app/app/modules/auth/controllers/auth_controller.dart';

class BikeController extends GetxController {
  //TODO: Implement BikeController

  RxList<FacilityModel> stations = RxList();

  Stream<List<FacilityModel>> streamStations() {
    return FacilityModel.getCollection
        .where(FacilityModel.TYPE, isEqualTo: FacilityType.bikeStation)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => FacilityModel.fromSnapshot(e)).toList());
  }

  streamLocation() {
    Geolocator.getPositionStream();
  }

  Rxn<RentModel> activeRent = Rxn();

  RxList<RentModel> rents = RxList();

  Stream<List<RentModel>> streamRent() {
    return RentModel.getCollectionReference(authC.user.id!)
        .orderBy(RentModel.DATE_START, descending: true)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => RentModel.fromSnapshot(e)).toList());
  }

  Stream<RentModel?> streamActiveRent() {
    return RentModel.getCollectionReference(authC.user.id!)
        .where(RentModel.DATE_FINISH, isNull: true)
        .snapshots()
        .map((event) => event.docs
            .map((e) => RentModel.fromSnapshot(e))
            .toList()
            .firstOrNull);
  }

  onUpdateRent(RentModel? rent) {
    if (rent?.position != null) {
      _updateUserLocationMarker(geoToPost(rent!.position!));
    }
  }

  void _updateUserLocationMarker(Position position) {
    // final marker = Marker(
    //   markerId: MarkerId('userLocation'),
    //   position: LatLng(position.latitude, position.longitude),
    //   infoWindow: InfoWindow(title: 'Your Location'),
    // );

    // mapController?.animateCamera(
    //   CameraUpdate.newLatLng(
    //     LatLng(position.latitude, position.longitude),
    //   ),
    // );
  }

  GoogleMapController? mapController;

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  bool get hasActiveRent =>
      rents.where((element) => element.isActive).isNotEmpty;

  @override
  void onInit() {
    super.onInit();
    stations.bindStream(streamStations());
    rents.bindStream(streamRent());
    // activeRent.bindStream(streamActiveRent());
    // ever(activeRent, (callback) => onUpdateRent);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
