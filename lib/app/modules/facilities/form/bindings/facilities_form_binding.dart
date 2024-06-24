import 'package:get/get.dart';

import '../controllers/facilities_form_controller.dart';

class FacilitiesFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FacilitiesFormController>(
      () => FacilitiesFormController(),
    );
  }
}
