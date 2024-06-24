import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_campus_app/app/modules/auth/controllers/auth_controller.dart';
import 'package:green_campus_app/app/routes/app_pages.dart';
import 'package:nb_utils/nb_utils.dart';

class AuthSignUpController extends GetxController {
  final _isLoading = false.obs;
  set isLoading(value) => _isLoading.value = value;
  get isLoading => _isLoading.value;

  final _showPassword = false.obs;
  set showPassword(value) => _showPassword.value = value;
  get showPassword => _showPassword.value;

  TextEditingController nipnimC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  TextEditingController confirmPasswordC = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void togglePasword() {
    showPassword = !showPassword;
  }

  Future signUp() async {
    try {
      isLoading = true;
      var message = await authC.signUp(
          nipnim: nipnimC.text,
          name: nameC.text,
          email: emailC.text,
          password: passwordC.text);
      if (message.isEmptyOrNull) {
        Get.toNamed(Routes.AUTH_EMAIL_CONFIRMATION,
            arguments: [emailC.text, passwordC.text]);
      } else {
        Get.snackbar("Error", message!);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading = false;
    }
  }

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
}
