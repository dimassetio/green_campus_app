import 'package:get/get.dart';

import '../controllers/admin_challenges_controller.dart';

class AdminChallengesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminChallengesController>(
      () => AdminChallengesController(),
    );
  }
}
