import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:green_campus_app/app/data/helpers/assets.dart';
import 'package:green_campus_app/app/data/helpers/formatter.dart';
import 'package:green_campus_app/app/data/helpers/themes.dart';
import 'package:green_campus_app/app/data/widgets/app_bar.dart';
import 'package:green_campus_app/app/data/widgets/button.dart';
import 'package:green_campus_app/app/data/widgets/card_column.dart';
import 'package:green_campus_app/app/data/widgets/form_foto.dart';
import 'package:green_campus_app/app/data/widgets/main_container.dart';
import 'package:green_campus_app/app/data/widgets/tile.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/product_show_controller.dart';

class ProductsShowView extends GetView<ProductsShowController> {
  const ProductsShowView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GCMainContainer(
      scrollable: true,
      children: [
        GCAppBar(
          label: 'detailProduct'.tr,
          svgIcon: svg_logo,
          showNotification: false,
        ),
        16.height,
        GCFormFoto(
          showFrame: true,
          defaultPath: img_logo,
          oldPath: controller.product.foto ?? '',
          showButton: false,
        ),
        16.height,
        GCCardColumn(
          children: [
            GCTile(
              leading: Icon(
                Icons.card_giftcard_outlined,
                color: primaryColor(context),
              ),
              label: 'title'.tr,
              value: controller.product.title ?? '',
            ),
            GCTile(
              leading: Icon(
                Icons.store_mall_directory_outlined,
                color: primaryColor(context),
              ),
              label: 'store'.tr,
              value: controller.product.store ?? '',
            ),
            GCTile(
              leading: SvgPicture.asset(svg_gp),
              label: 'price'.tr,
              value: "${decimalFormatter(controller.product.price)} ${'gp'.tr}",
            ),
            GCTile(
              verticalAlignment: CrossAxisAlignment.start,
              leading: Icon(
                Icons.info,
                color: primaryColor(context),
              ),
              label: 'description'.tr,
              value: controller.product.description ?? '',
            ),
          ],
        ),
        16.height,
        GCButton(
          title: 'redeem'.tr,
          onPressed: () {
            controller.redeem(context);
          },
        ),
      ],
    ));
  }
}
