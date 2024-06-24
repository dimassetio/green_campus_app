import 'package:get/get.dart';

import '../controllers/bike_form_controller.dart';

class BikeFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BikeFormController>(
      () => BikeFormController(),
    );
  }
}
