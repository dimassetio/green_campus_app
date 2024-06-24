import 'package:get/get.dart';

import '../controllers/bike_controller.dart';

class BikeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BikeController>(
      () => BikeController(),
    );
  }
}
