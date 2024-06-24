import 'package:get/get.dart';
import 'package:green_campus_app/app/data/models/facility_model.dart';

class AdminFacilitiesController extends GetxController {
  //TODO: Implement AdminFacilitiesController

  RxList<FacilityModel> facilities = RxList();

  Stream<List<FacilityModel>> streamFacilities() {
    return FacilityModel.getCollection
        .orderBy(FacilityModel.DATE_CREATED, descending: true)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => FacilityModel.fromSnapshot(e)).toList());
  }

  @override
  void onInit() {
    super.onInit();
    facilities.bindStream(streamFacilities());
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
