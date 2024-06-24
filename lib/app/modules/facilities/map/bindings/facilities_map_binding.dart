import 'package:get/get.dart';

import '../controllers/facilities_map_controller.dart';

class FacilitiesMapBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FacilitiesMapController>(
      () => FacilitiesMapController(),
    );
  }
}
