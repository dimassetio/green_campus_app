import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_campus_app/app/data/helpers/assets.dart';
import 'package:green_campus_app/app/data/widgets/app_bar.dart';
import 'package:green_campus_app/app/data/widgets/button.dart';
import 'package:green_campus_app/app/data/widgets/card_column.dart';
import 'package:green_campus_app/app/data/widgets/dropdown_menu.dart';
import 'package:green_campus_app/app/data/widgets/main_container.dart';
import 'package:green_campus_app/app/data/widgets/text_field.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/product_form_controller.dart';

class ProductsFormView extends GetView<ProductsFormController> {
  const ProductsFormView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: controller.formKey,
        child: GCMainContainer(scrollable: true, children: [
          GCAppBar(
            label: 'addProduct'.tr,
            svgIcon: svg_logo,
            showNotification: false,
          ),
          16.height,
          controller.formFoto,
          16.height,
          GCCardColumn(
            children: [
              GCTextfield(
                controller: controller.titleC,
                label: 'title'.tr,
                icon: Icon(Icons.card_giftcard_rounded),
                isValidationRequired: true,
              ),
              16.height,
              GCTextfield(
                controller: controller.priceC,
                label: 'price'.tr,
                icon: Icon(Icons.attach_money_rounded),
                isValidationRequired: true,
                digitsOnly: true,
                textFieldType: TextFieldType.NUMBER,
              ),
              16.height,
              GCTextfield(
                controller: controller.storeC,
                label: 'store'.tr,
                icon: Icon(Icons.store_rounded),
                isValidationRequired: true,
              ),
              16.height,
              GCTextfield(
                controller: controller.descriptionC,
                label: 'description'.tr,
                icon: Icon(Icons.info_outline_rounded),
                isValidationRequired: true,
                textFieldType: TextFieldType.MULTILINE,
              ),
            ],
          ),
          16.height,
          GCCardColumn(
            children: [
              GCDropdown(
                icon: Icon(Icons.check_circle_outline_rounded),
                label: 'status'.tr,
                initValue: controller.isAvailable.value,
                listValue: [true, false],
                titleFunction: (value) =>
                    value ? 'available'.tr : 'notAvailable'.tr,
                onChanged: (value) => controller.isAvailable.value = value,
              ),
            ],
          ),
          16.height,
          Obx(() => GCButton(
                icon: controller.isLoading
                    ? Expanded(child: LinearProgressIndicator())
                    : null,
                title: controller.isLoading ? '' : 'submit'.tr,
                onPressed: controller.isLoading
                    ? null
                    : () {
                        if (controller.formKey.currentState?.validate() ??
                            false) {
                          controller.save();
                        }
                      },
              )),
          16.height,
        ]),
      ),
    );
  }
}
