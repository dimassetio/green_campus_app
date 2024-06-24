import 'package:get/get.dart';

import '../controllers/challenges_form_controller.dart';

class ChallengesFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChallengesFormController>(
      () => ChallengesFormController(),
    );
  }
}
