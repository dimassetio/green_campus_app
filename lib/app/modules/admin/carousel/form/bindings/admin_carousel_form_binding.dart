import 'package:get/get.dart';

import '../controllers/admin_carousel_form_controller.dart';

class AdminCarouselFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminCarouselFormController>(
      () => AdminCarouselFormController(),
    );
  }
}
