import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:green_campus_app/app/data/helpers/assets.dart';
import 'package:green_campus_app/app/data/widgets/app_bar.dart';
import 'package:green_campus_app/app/data/widgets/main_container.dart';
import 'package:green_campus_app/app/modules/admin/products/views/product_card.dart';
import 'package:green_campus_app/app/routes/app_pages.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/admin_products_controller.dart';

class AdminProductsView extends GetView<AdminProductsController> {
  const AdminProductsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.PRODUCTS_FORM);
        },
        child: Icon(Icons.add_rounded),
      ),
      body: GCMainContainer(
        scrollable: true,
        children: [
          GCAppBar(
            label: 'rewardProduct',
            svgIcon: svg_logo,
            showNotification: false,
          ),
          16.height,
          Obx(
            () => GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  mainAxisExtent: 250,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                ),
                itemCount: controller.products.length,
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ProductCard(
                    onTap: () {
                      Get.toNamed(Routes.PRODUCTS_FORM,
                          arguments: controller.products[index]);
                    },
                    product: controller.products[index],
                  );
                }),
          ),
        ],
      ),
    );
  }
}
