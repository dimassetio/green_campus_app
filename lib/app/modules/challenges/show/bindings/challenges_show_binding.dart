import 'package:get/get.dart';

import '../controllers/challenges_show_controller.dart';

class ChallengesShowBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChallengesShowController>(
      () => ChallengesShowController(),
    );
  }
}
