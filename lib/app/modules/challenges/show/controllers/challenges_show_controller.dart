import 'package:get/get.dart';
import 'package:green_campus_app/app/data/models/challenge_model.dart';

class ChallengesShowController extends GetxController {
  Rx<ChallengeModel> _challenge = ChallengeModel().obs;
  ChallengeModel get challenge => this._challenge.value;
  set challenge(ChallengeModel value) => this._challenge.value = value;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is ChallengeModel) {
      challenge = Get.arguments;
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
