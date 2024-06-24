import 'package:get/get.dart';
import 'package:green_campus_app/app/data/helpers/assets.dart';
import 'package:green_campus_app/app/data/models/banner_model.dart';
import 'package:green_campus_app/app/data/models/challenge_model.dart';
import 'package:green_campus_app/app/data/models/product_model.dart';

class HomeController extends GetxController {
  RxList<String> carousel = [
    img_carousel_1,
    img_carousel_2,
    img_carousel_3,
    img_carousel_4,
    img_carousel_5,
    img_carousel_6,
  ].obs;

  RxList<BannerModel> banners = RxList();

  Stream<List<BannerModel>> streamBanner() {
    return BannerModel()
        .collectionReference
        .orderBy(BannerModel.INDEX)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => BannerModel.fromSnapshot(e)).toList());
  }

  RxList<ProductModel> products = RxList();

  Stream<List<ProductModel>> streamProducts() {
    return ProductModel()
        .collectionReference
        .where(ProductModel.IS_AVAILABLE, isEqualTo: true)
        .orderBy(ProductModel.DATE_CREATED, descending: true)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => ProductModel.fromSnapshot(e)).toList());
  }

  RxList<ChallengeModel> challenges = RxList();

  Future<List<ChallengeModel>> getHighestRewardChallenge() async {
    try {
      isLoading = true;
      challenges.value = await ChallengeModel()
          .collectionReference
          .where(ChallengeModel.IS_ACTIVE, isEqualTo: true)
          .orderBy(ChallengeModel.REWARDS, descending: true)
          .limit(5)
          .get()
          .then((event) =>
              event.docs.map((e) => ChallengeModel.fromSnapshot(e)).toList());
      return challenges;
    } finally {
      isLoading = false;
    }
  }

  var _isLoading = false.obs;
  bool get isLoading => this._isLoading.value;
  set isLoading(value) => this._isLoading.value = value;

  @override
  void onInit() {
    super.onInit();
    products.bindStream(streamProducts());
    banners.bindStream(streamBanner());
    getHighestRewardChallenge();
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
