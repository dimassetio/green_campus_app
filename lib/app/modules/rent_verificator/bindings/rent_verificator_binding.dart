import 'package:get/get.dart';

import '../controllers/rent_verificator_controller.dart';

class RentVerificatorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RentVerificatorController>(
      () => RentVerificatorController(),
    );
  }
}
