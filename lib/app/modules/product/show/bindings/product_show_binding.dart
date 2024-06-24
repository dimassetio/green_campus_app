import 'package:get/get.dart';

import '../controllers/product_show_controller.dart';

class ProductsShowBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductsShowController>(
      () => ProductsShowController(),
    );
  }
}
