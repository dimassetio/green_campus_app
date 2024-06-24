import 'package:get/get.dart';

import '../controllers/challenges_index_controller.dart';

class ChallengesIndexBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChallengesIndexController>(
      () => ChallengesIndexController(),
    );
  }
}
