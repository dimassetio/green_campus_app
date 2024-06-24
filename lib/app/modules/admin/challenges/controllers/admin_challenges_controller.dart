import 'package:get/get.dart';
import 'package:green_campus_app/app/data/models/challenge_model.dart';

class AdminChallengesController extends GetxController {
  RxList<ChallengeModel> challenges = RxList();

  Stream<List<ChallengeModel>> streamChallenges() {
    return ChallengeModel()
        .collectionReference
        .orderBy(ChallengeModel.DATE_CREATED, descending: true)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => ChallengeModel.fromSnapshot(e)).toList());
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();

    challenges.bindStream(streamChallenges());
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
