import 'package:get/get.dart';

import '../controllers/bike_rent_controller.dart';

class BikeRentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BikeRentController>(
      () => BikeRentController(),
    );
  }
}
