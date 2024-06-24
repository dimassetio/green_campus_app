import 'package:get/get.dart';

import '../controllers/admin_bike_controller.dart';

class AdminBikeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminBikeController>(
      () => AdminBikeController(),
    );
  }
}
