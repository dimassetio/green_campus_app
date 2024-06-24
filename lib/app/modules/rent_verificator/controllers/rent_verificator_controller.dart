import 'package:get/get.dart';
import 'package:green_campus_app/app/data/models/facility_model.dart';
import 'package:green_campus_app/app/data/models/rent_model.dart';

class RentVerificatorController extends GetxController {
  //TODO: Implement RentVerificatorController

  Rxn<FacilityModel> currentFacility = Rxn();

  FacilityModel? get getCurrentFacility =>
      currentFacility.value ?? stations.firstOrNull;

  RxList<FacilityModel> stations = RxList();

  Stream<List<FacilityModel>> streamStations() {
    return FacilityModel.getCollection
        .where(FacilityModel.TYPE, isEqualTo: FacilityType.bikeStation)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => FacilityModel.fromSnapshot(e)).toList());
  }

  RxList<RentModel> activeRents = RxList();

  Stream<List<RentModel>> streamRents() {
    return RentModel.getCollectionGroup()
        .orderBy(RentModel.DATE_START, descending: true)
        .snapshots()
        .map(
          (event) => event.docs.map((e) => RentModel.fromSnapshot(e)).toList(),
        );
  }

  @override
  void onInit() {
    super.onInit();
    activeRents.bindStream(streamRents());
    stations.bindStream(streamStations());
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
