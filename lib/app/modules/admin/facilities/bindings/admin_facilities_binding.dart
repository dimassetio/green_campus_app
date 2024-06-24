import 'package:get/get.dart';

import '../controllers/admin_facilities_controller.dart';

class AdminFacilitiesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminFacilitiesController>(
      () => AdminFacilitiesController(),
    );
  }
}
