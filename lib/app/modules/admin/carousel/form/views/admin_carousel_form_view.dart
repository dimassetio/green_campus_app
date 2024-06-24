import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:green_campus_app/app/data/helpers/assets.dart';
import 'package:green_campus_app/app/data/widgets/app_bar.dart';
import 'package:green_campus_app/app/data/widgets/card_column.dart';
import 'package:green_campus_app/app/data/widgets/main_container.dart';
import 'package:green_campus_app/app/data/widgets/text_field.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/admin_carousel_form_controller.dart';

class AdminCarouselFormView extends GetView<AdminCarouselFormController> {
  const AdminCarouselFormView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GCMainContainer(scrollable: false, children: [
        GCAppBar(
          label: 'bannerForm'.tr,
          svgIcon: svg_logo,
          showNotification: false,
        ),
        16.height,
        16.height,
        controller.formFoto,
        GCCardColumn(
          children: [
            GCTextfield(
              icon: Icon(Icons.numbers),
              label: "Index",
              controller: controller.indexC,
              textFieldType: TextFieldType.NUMBER,
              digitsOnly: true,
            ),
            16.height,
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (controller.formFoto.newPath.isEmpty ||
                          controller.indexC.text.isEmpty) {
                        Get.snackbar(
                            "Validation Error", "Fill all field first");
                      } else {
                        controller.save();
                      }
                    },
                    child: Text("Submit"),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        )
      ]),
    );
  }
}
