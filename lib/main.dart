import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:green_campus_app/app/data/helpers/firebase_options.dart';
import 'package:green_campus_app/app/data/helpers/languages.dart';
import 'package:green_campus_app/app/data/helpers/themes.dart';
import 'package:green_campus_app/app/data/models/user_model.dart';
import 'package:green_campus_app/app/modules/auth/controllers/auth_controller.dart';
import 'package:green_campus_app/app/modules/home/controllers/theme_controller.dart';
import 'package:nb_utils/nb_utils.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  var authController = Get.put(AuthController(), permanent: true);
  var themeController = Get.put(ThemeController(), permanent: true);
  UserModel? user = await authController.getActiveUser();

  runApp(
    GetMaterialApp(
      title: "Green Campus",
      translations: Word(),
      locale: Get.locale ?? Word.localeEN,
      fallbackLocale: Word.localeID,
      debugShowCheckedModeBanner: false,
      initialRoute: (user?.id?.isEmptyOrNull ?? true)
          ? Routes.AUTH_SIGN_IN
          : (user!.hasRole(Role.rentalStaff))
              ? Routes.RENT_VERIFICATOR
              : Routes.HOME,
      getPages: AppPages.routes,
      themeMode: themeController.currentTheme,
      theme: mainTheme,
      darkTheme: darkTheme,
    ),
  );
}
