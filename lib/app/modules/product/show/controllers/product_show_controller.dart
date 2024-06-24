import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_campus_app/app/data/models/product_model.dart';
import 'package:green_campus_app/app/data/models/redemption_model.dart';
import 'package:green_campus_app/app/data/widgets/dialog.dart';
import 'package:green_campus_app/app/modules/auth/controllers/auth_controller.dart';
import 'package:green_campus_app/app/routes/app_pages.dart';

class ProductsShowController extends GetxController {
  Rx<ProductModel> _product = ProductModel().obs;
  ProductModel get product => this._product.value;
  set product(ProductModel value) => this._product.value = value;

  var _isLoading = false.obs;
  bool get isLoading => this._isLoading.value;
  set isLoading(bool value) => this._isLoading.value = value;

  Future redeem(BuildContext context) async {
    try {
      if ((authC.user.gp ?? 0) < product.price!) {
        await showDialog(
          context: context,
          builder: (context) => GCDialog(
              title: 'notEnoughGP'.tr, subtitle: 'notEnoughGPMessage'.tr),
        );
        return;
      }
      await showDialog(
        context: context,
        builder: (context) => Obx(
          () => GCDialog(
            title: 'redeemConfirmation'.tr,
            subtitle: 'redeemConfirmMessage'.tr,
            negativeText: 'cancel'.tr,
            confirmText: isLoading ? 'wait'.tr : null,
            onConfirm: isLoading
                ? () {}
                : () async {
                    isLoading = true;

                    RedemptionModel model = RedemptionModel(
                        id: '',
                        userId: authC.user.id!,
                        productModel: product,
                        productId: product.id!,
                        pointsRedeemed: product.price!,
                        code: '',
                        dateCreated: DateTime.now());
                    await model.save();
                    Get.offNamed(Routes.REDEMPTION_SHOW, arguments: model);
                  },
          ),
        ),
      );
    } on Exception catch (e) {
      Get.snackbar("error".tr, e.toString());
    } finally {
      isLoading = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is ProductModel) {
      product = Get.arguments;
    }
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
