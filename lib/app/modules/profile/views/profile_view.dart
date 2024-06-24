import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:green_campus_app/app/data/helpers/assets.dart';
import 'package:green_campus_app/app/data/helpers/languages.dart';
import 'package:green_campus_app/app/data/helpers/themes.dart';
import 'package:green_campus_app/app/data/models/user_model.dart';
import 'package:green_campus_app/app/data/widgets/app_bar.dart';
import 'package:green_campus_app/app/data/widgets/bottom_bar.dart';
import 'package:green_campus_app/app/data/widgets/button.dart';
import 'package:green_campus_app/app/data/widgets/card_column.dart';
import 'package:green_campus_app/app/data/widgets/circle_container.dart';
import 'package:green_campus_app/app/data/widgets/dialog.dart';
import 'package:green_campus_app/app/data/widgets/main_container.dart';
import 'package:green_campus_app/app/data/widgets/notif_drawer.dart';
import 'package:green_campus_app/app/data/widgets/tile.dart';
import 'package:green_campus_app/app/modules/auth/controllers/auth_controller.dart';
import 'package:green_campus_app/app/modules/home/controllers/theme_controller.dart';
import 'package:green_campus_app/app/routes/app_pages.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GCBottomBar(selectedIndex: 4),
      endDrawer: NotifDrawer(),
      body: GCMainContainer(
        scrollable: true,
        children: [
          GCAppBar(label: 'profile'.tr, svgIcon: svg_ic_profile_a),
          16.height,
          Stack(
            children: [
              Column(children: [
                60.height,
                GCCardColumn(
                  crossAxis: CrossAxisAlignment.center,
                  children: [
                    60.height,
                    Center(
                      child: Text(
                        controller.user.name ?? 'name'.tr,
                        style: textTheme(context).titleMedium,
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      height: 8,
                    ),
                    Center(
                      child: Text(
                        controller.user.email ?? 'email'.tr,
                        style: textTheme(context)
                            .titleSmall
                            ?.copyWith(color: primaryColor(context)),
                      ),
                    ),
                  ],
                )
              ]),
              Align(
                alignment: Alignment.topCenter,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Obx(
                      () => CircleAvatar(
                        radius: 60,
                        backgroundColor: lightColor,
                        child: Icon(
                          Icons.person_2_rounded,
                          size: 60,
                          color: primaryColor(context),
                        ),
                        foregroundImage: controller.user.foto is String
                            ? CachedNetworkImageProvider(controller.user.foto!)
                            : null,
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomRight,
                      height: 120,
                      width: 120,
                      child: IconButton(
                        color: primaryColor(context),
                        onPressed: () {
                          Get.dialog(Dialog(
                            surfaceTintColor: Colors.grey,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            insetPadding: EdgeInsets.all(8),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                16.height,
                                controller.formFoto,
                                16.height,
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Obx(
                                      () => GCButton(
                                          title: controller.isLoading
                                              ? 'wait'.tr
                                              : 'submit'.tr,
                                          onPressed: controller.isLoading
                                              ? null
                                              : () async {
                                                  await controller.save();
                                                }),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ));
                        },
                        icon: CircleContainer(
                          padding: EdgeInsets.all(4),
                          child: Icon(Icons.camera_alt_outlined),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          16.height,
          GCCardColumn(
            children: [
              GCTile(
                  leading: Icon(Icons.local_library_outlined,
                      color: primaryColor(context)),
                  label: 'nipnim'.tr,
                  value: controller.user.numberId ?? ''),
            ],
          ),
          16.height,
          GCCardColumn(
            children: [
              GCCardColumn(
                padding: 8,
                elevation: 0,
                onPressed: () {
                  Get.dialog(
                    Dialog(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          RadioListTile<Locale>(
                              selectedTileColor: primaryColor(context),
                              value: Word.localeEN,
                              groupValue: Get.locale,
                              title: Text('english'.tr),
                              onChanged: (value) {
                                if (value is Locale) {
                                  Get.updateLocale(value);
                                }
                                Get.back();
                              }),
                          RadioListTile<Locale>(
                              selectedTileColor: primaryColor(context),
                              value: Word.localeID,
                              groupValue: Get.locale,
                              title: Text('indonesian'.tr),
                              onChanged: (value) {
                                if (value is Locale) {
                                  Get.updateLocale(value);
                                }
                                Get.back();
                              })
                        ],
                      ),
                    ),
                  );
                },
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.language,
                        color: primaryColor(context),
                      ),
                      12.width,
                      Expanded(
                        child: Text(
                          'language'.tr,
                          style: textTheme(context).bodyMedium,
                        ),
                      ),
                      Text(
                        Get.locale == Word.localeEN
                            ? 'english'.tr
                            : 'indonesian'.tr,
                        style: textTheme(context)
                            .bodyMedium
                            ?.copyWith(color: primaryColor(context)),
                      ),
                      Icon(
                        Icons.chevron_right_rounded,
                        color: primaryColor(context),
                      ),
                    ],
                  ),
                ],
              ),
              8.height,
              GCCardColumn(
                padding: 8,
                elevation: 0,
                onPressed: () {
                  Get.dialog(Dialog(
                    child: Obx(
                      () => Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          RadioListTile<ThemeMode>(
                              selectedTileColor: primaryColor(context),
                              value: ThemeMode.light,
                              groupValue: themeC.currentTheme,
                              title: Text('light'.tr),
                              onChanged: (value) {
                                themeC
                                    .switchTheme(value ?? themeC.currentTheme);
                                Get.back();
                              }),
                          RadioListTile<ThemeMode>(
                              selectedTileColor: primaryColor(context),
                              value: ThemeMode.dark,
                              title: Text('dark'.tr),
                              groupValue: themeC.currentTheme,
                              onChanged: (value) {
                                themeC
                                    .switchTheme(value ?? themeC.currentTheme);
                                Get.back();
                              })
                        ],
                      ),
                    ),
                  ));
                },
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.light_mode_rounded,
                        color: primaryColor(context),
                      ),
                      12.width,
                      Expanded(
                        child: Text(
                          'theme'.tr,
                          style: textTheme(context).bodyMedium,
                        ),
                      ),
                      Obx(
                        () => Text(
                          themeC.currentTheme == ThemeMode.light
                              ? 'light'.tr
                              : 'dark'.tr,
                          style: textTheme(context)
                              .bodyMedium
                              ?.copyWith(color: primaryColor(context)),
                        ),
                      ),
                      Icon(
                        Icons.chevron_right_rounded,
                        color: primaryColor(context),
                      ),
                    ],
                  ),
                ],
              ),
              8.height,
              GCCardColumn(
                padding: 8,
                elevation: 0,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.file_download_rounded,
                        color: primaryColor(context),
                      ),
                      12.width,
                      Expanded(
                        child: Text(
                          'appVersion'.tr,
                          style: textTheme(context).bodyMedium,
                        ),
                      ),
                      VersionInfoWidget(
                        textStyle: textTheme(context).bodyMedium?.copyWith(
                              color: primaryColor(context),
                            ),
                      ),
                      24.width,
                    ],
                  ),
                ],
              ),
              8.height,
              GCCardColumn(
                padding: 8,
                elevation: 0,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return GCDialog(
                          title: 'confirmation'.tr,
                          subtitle: 'logoutConfirmation'.tr,
                          negativeText: 'cancel'.tr,
                          onConfirm: controller.isLoading
                              ? null
                              : () => controller.logout(),
                        );
                      });
                },
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.logout_outlined,
                        color: primaryColor(context),
                      ),
                      12.width,
                      Expanded(
                        child: Text(
                          'logout'.tr,
                          style: textTheme(context).bodyMedium,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right_rounded,
                        color: primaryColor(context),
                      )
                    ],
                  ),
                ],
              ),
              if (authC.user.hasRole(Role.administrator))
                GCCardColumn(
                  margin: EdgeInsets.only(top: 8),
                  padding: 8,
                  elevation: 0,
                  onPressed: () => Get.toNamed(Routes.ADMIN),
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.dashboard,
                          color: primaryColor(context),
                        ),
                        12.width,
                        Expanded(
                          child: Text(
                            'adminDashboard'.tr,
                            style: textTheme(context).bodyMedium,
                          ),
                        ),
                        Icon(
                          Icons.chevron_right_rounded,
                          color: primaryColor(context),
                        )
                      ],
                    ),
                  ],
                ),
            ],
          ),
          80.height,
        ],
      ),
    );
  }
}
