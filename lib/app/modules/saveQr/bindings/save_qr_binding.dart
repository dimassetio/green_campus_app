import 'package:get/get.dart';

import '../controllers/save_qr_controller.dart';

class SaveQrBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SaveQrController>(
      () => SaveQrController(),
    );
  }
}
