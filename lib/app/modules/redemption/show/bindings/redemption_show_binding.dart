import 'package:get/get.dart';

import '../controllers/redemption_show_controller.dart';

class RedemptionShowBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RedemptionShowController>(
      () => RedemptionShowController(),
    );
  }
}
