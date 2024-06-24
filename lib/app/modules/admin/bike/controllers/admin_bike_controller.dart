import 'package:get/get.dart';
import 'package:green_campus_app/app/data/models/bike_model.dart';

class AdminBikeController extends GetxController {
  RxList<BikeModel> bikes = RxList();

  Stream<List<BikeModel>> streamBikes() {
    return BikeModel.getCollection
        .orderBy(BikeModel.DATECREATED, descending: true)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => BikeModel.fromSnapshot(e)).toList());
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();

    bikes.bindStream(streamBikes());
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
