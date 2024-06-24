import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:green_campus_app/app/data/helpers/assets.dart';
import 'package:green_campus_app/app/data/helpers/themes.dart';
import 'package:green_campus_app/app/data/helpers/validator.dart';
import 'package:green_campus_app/app/data/widgets/button.dart';
import 'package:green_campus_app/app/data/widgets/text_field.dart';
import 'package:green_campus_app/app/routes/app_pages.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/auth_sign_up_controller.dart';

class AuthSignUpView extends GetResponsiveView<AuthSignUpController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SvgPicture.asset(
            svg_auth_bg,
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Container(
                height: Get.height,
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(20),
                        child: SvgPicture.asset(svg_logo),
                      ),
                    ),
                    Form(
                      key: controller.formKey,
                      child: Card(
                        color: theme(context).colorScheme.surface,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20))),
                        child: Container(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  "register".tr,
                                  style: textTheme(context)
                                      .headlineSmall
                                      ?.copyWith(color: primaryColor(context)),
                                ),
                              ),
                              16.height,
                              GCTextfield(
                                controller: controller.nipnimC,
                                label: 'nipnim'.tr,
                                icon: Icon(Icons.tag),
                                textFieldType: TextFieldType.NUMBER,
                                isValidationRequired: true,
                              ),
                              16.height,
                              GCTextfield(
                                controller: controller.nameC,
                                label: 'name'.tr,
                                icon: Icon(Icons.person_2_outlined),
                                textFieldType: TextFieldType.NAME,
                                isValidationRequired: true,
                              ),
                              16.height,
                              GCTextfield(
                                controller: controller.emailC,
                                label: 'email'.tr,
                                icon: Icon(Icons.email_outlined),
                                textFieldType: TextFieldType.EMAIL,
                                validator: emailValidator,
                              ),
                              16.height,
                              GCTextfield(
                                controller: controller.passwordC,
                                label: 'password'.tr,
                                icon: Icon(Icons.lock_outline_rounded),
                                textFieldType: TextFieldType.PASSWORD,
                              ),
                              16.height,
                              GCTextfield(
                                controller: controller.confirmPasswordC,
                                label: 'confirmPassword'.tr,
                                icon: Icon(Icons.lock_outline_rounded),
                                textFieldType: TextFieldType.PASSWORD,
                              ),
                              16.height,
                              Obx(
                                () => GCButton(
                                  onPressed: controller.isLoading
                                      ? null
                                      : () {
                                          if (controller.formKey.currentState
                                                  ?.validate() ??
                                              false) {
                                            controller.signUp();
                                          }
                                        },
                                  title: 'login'.tr,
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: TextButton(
                                  onPressed: () {
                                    Get.toNamed(Routes.AUTH_SIGN_IN);
                                  },
                                  child: Text(
                                    'goSignIn'.tr,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
