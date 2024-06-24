import 'package:get/get.dart';

import '../controllers/product_form_controller.dart';

class ProductsFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductsFormController>(
      () => ProductsFormController(),
    );
  }
}
