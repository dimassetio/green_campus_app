import 'package:get/get.dart';

import '../controllers/activity_show_controller.dart';

class ActivityShowBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ActivityShowController>(
      () => ActivityShowController(),
    );
  }
}
