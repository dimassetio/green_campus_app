import 'package:get/get.dart';
import 'package:green_campus_app/app/data/models/product_model.dart';

class AdminProductsController extends GetxController {
  RxList<ProductModel> products = RxList();

  Stream<List<ProductModel>> streamProducts() {
    return ProductModel()
        .collectionReference
        .orderBy(ProductModel.DATE_CREATED, descending: true)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => ProductModel.fromSnapshot(e)).toList());
  }

  @override
  void onInit() {
    super.onInit();

    products.bindStream(streamProducts());
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
