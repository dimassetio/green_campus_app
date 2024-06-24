import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:green_campus_app/app/data/helpers/assets.dart';
import 'package:green_campus_app/app/data/helpers/formatter.dart';
import 'package:green_campus_app/app/data/helpers/themes.dart';
import 'package:green_campus_app/app/data/models/product_model.dart';
import 'package:green_campus_app/app/routes/app_pages.dart';
import 'package:nb_utils/nb_utils.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
  });

  final ProductModel product;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap ??
            () {
              Get.toNamed(Routes.PRODUCTS_SHOW, arguments: product);
            },
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(8),
                ),
                child: product.foto is String
                    ? CachedNetworkImage(
                        imageUrl: product.foto!,
                        fit: BoxFit.cover,
                      )
                    : SvgPicture.asset(svg_logo, fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title ?? '',
                    style: textTheme(context).titleSmall,
                    maxLines: 2,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.store_mall_directory_outlined,
                        color: secondTextColor,
                      ),
                      8.width,
                      Expanded(
                        child: Text(
                          "${product.store}",
                          maxLines: 1,
                          style: textTheme(context)
                              .bodyMedium
                              ?.copyWith(color: secondTextColor),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SvgPicture.asset(
                        svg_gp,
                        height: 24,
                      ),
                      8.width,
                      Text(
                        decimalFormatter(product.price),
                        style: textTheme(context)
                            .labelLarge
                            ?.copyWith(color: primaryColor(context)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
