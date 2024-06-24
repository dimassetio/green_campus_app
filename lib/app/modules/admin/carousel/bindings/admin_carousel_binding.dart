import 'package:get/get.dart';

import '../controllers/admin_carousel_controller.dart';

class AdminCarouselBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminCarouselController>(
      () => AdminCarouselController(),
    );
  }
}
