import 'package:get/get.dart';
import 'package:green_campus_app/app/data/models/product_model.dart';
import 'package:green_campus_app/app/data/models/redemption_model.dart';
import 'package:nb_utils/nb_utils.dart';

class AdminRedemptionController extends GetxController {
  RxList<RedemptionModel> redemptions = RxList();
  Stream<List<RedemptionModel>> streamRedemptions() {
    return RedemptionModel.getCollectionGroup().snapshots().map((event) =>
        event.docs.map((e) => RedemptionModel.fromSnapshot(e)).toList());
  }

  int get getTotalRedemption => redemptions
      .where((element) => element.isRedeemed)
      .sumBy((element) => element.pointsRedeemed);

  Future<Map<String, int>> totalRedemptionByStore() async {
    Map<String, int> result = {};
    List<ProductModel> products = [];
    for (var redemption in redemptions) {
      if (!redemption.isRedeemed) {
        continue;
      }
      ProductModel? product;
      if (products
          .where((element) => element.id == redemption.productId)
          .isNotEmpty) {
        product = products
            .firstWhere((element) => element.id == redemption.productId);
      } else {
        product = await redemption.getProduct();
        if (product is ProductModel) {
          products.add(product);
        } else {
          continue;
        }
      }
      var store = product.store;
      if (store != null) {
        result.update(store, (value) => value + redemption.pointsRedeemed,
            ifAbsent: () => redemption.pointsRedeemed);
      }
    }
    return result;
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    redemptions.bindStream(streamRedemptions());
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
