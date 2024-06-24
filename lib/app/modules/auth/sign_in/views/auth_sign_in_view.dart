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

import '../controllers/auth_sign_in_controller.dart';

class AuthSignInView extends GetResponsiveView<AuthSignInController> {
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
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(20),
                    child: SvgPicture.asset(svg_logo),
                  ),
                ),
                SingleChildScrollView(
                  child: Form(
                    key: controller.formKey,
                    child: Card(
                      color: theme(context).colorScheme.surface,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20))),
                      child: Container(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                "login".tr,
                                style: textTheme(context)
                                    .headlineSmall
                                    ?.copyWith(color: primaryColor(context)),
                              ),
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
                            TextButton(
                              onPressed: () {
                                Get.toNamed(Routes.AUTH_FORGET_PASSWORD);
                              },
                              child: Text('forgetPassword'.tr),
                            ),
                            Obx(
                              () => GCButton(
                                onPressed: controller.isLoading
                                    ? null
                                    : () {
                                        if (controller.formKey.currentState
                                                ?.validate() ??
                                            false) {
                                          controller.signIn();
                                        }
                                      },
                                title: 'login'.tr,
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: TextButton(
                                onPressed: () {
                                  Get.toNamed(Routes.AUTH_SIGN_UP);
                                },
                                child: Text(
                                  'goRegister'.tr,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            8.height,
                            // GCButton(
                            //   backgroundColor:
                            //       theme(context).scaffoldBackgroundColor,
                            //   foregroundColor:
                            //       theme(context).colorScheme.onBackground,
                            //   onPressed: () {
                            //     controller.googleSignIn();
                            //   },
                            //   icon:
                            //       SvgPicture.asset(svg_logo_google, height: 24),
                            //   title: 'continueWGoogle'.tr,
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
