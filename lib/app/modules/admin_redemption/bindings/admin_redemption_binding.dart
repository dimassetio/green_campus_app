import 'package:get/get.dart';

import '../controllers/admin_redemption_controller.dart';

class AdminRedemptionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminRedemptionController>(
      () => AdminRedemptionController(),
    );
  }
}
