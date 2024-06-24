import 'package:get/get.dart';

import '../controllers/activity_form_controller.dart';

class ActivityFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ActivityFormController>(
      () => ActivityFormController(),
    );
  }
}
