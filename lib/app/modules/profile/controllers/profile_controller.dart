import 'dart:io';

import 'package:get/get.dart';
import 'package:green_campus_app/app/data/models/user_model.dart';
import 'package:green_campus_app/app/data/widgets/form_foto.dart';
import 'package:green_campus_app/app/modules/auth/controllers/auth_controller.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController

  UserModel get user => authC.user;

  var _isLoading = false.obs;
  bool get isLoading => this._isLoading.value;
  set isLoading(bool value) => this._isLoading.value = value;

  Future logout() async {
    try {
      isLoading = true;
      await authC.signOut();
    } catch (e) {
      Get.snackbar("Error", "$e");
    } finally {
      isLoading = false;
    }
  }

  GCFormFoto formFoto = GCFormFoto(
    oldPath: authC.user.foto ?? '',
    height: 120,
    width: 120,
  );

  Future save() async {
    try {
      isLoading = true;
      if (formFoto.newPath.isNotEmpty) {
        File file = File(formFoto.newPath);
        var user = authC.user;
        await user.save(file: file);
        Get.back();
        Get.snackbar('success'.tr, 'profilePictureChanged'.tr);
      }
    } on Exception catch (e) {
      Get.snackbar('error'.tr, e.toString());
    } finally {
      isLoading = false;
    }
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
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
