import 'package:get/get.dart';
import 'package:green_campus_app/app/data/helpers/database.dart';
import 'package:green_campus_app/app/data/models/activity_model.dart';

class AdminActivitiesController extends GetxController {
  //TODO: Implement AdminActivitiesController

  RxList<ActivityModel> activities = RxList();

  Stream<List<ActivityModel>> streamActivities() {
    return Database.collectionGroup(ActivityModel.COLLECTION_NAME)
        .orderBy(ActivityModel.TIME, descending: true)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => ActivityModel.fromSnapshot(e)).toList());
  }

  @override
  void onInit() {
    super.onInit();
    activities.bindStream(streamActivities());
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
