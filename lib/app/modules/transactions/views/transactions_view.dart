import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:green_campus_app/app/data/helpers/assets.dart';
import 'package:green_campus_app/app/data/helpers/formatter.dart';
import 'package:green_campus_app/app/data/helpers/themes.dart';
import 'package:green_campus_app/app/data/models/gpTransaction_model.dart';
import 'package:green_campus_app/app/data/widgets/app_bar.dart';
import 'package:green_campus_app/app/data/widgets/card_column.dart';
import 'package:green_campus_app/app/data/widgets/main_container.dart';
import 'package:green_campus_app/app/data/widgets/notif_drawer.dart';
import 'package:green_campus_app/app/routes/app_pages.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/transactions_controller.dart';

class TransactionsView extends GetView<TransactionsController> {
  const TransactionsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        endDrawer: NotifDrawer(),
        body: GCMainContainer(
          scrollable: true,
          children: [
            GCAppBar(label: 'transactionGP'.tr, svgIcon: svg_gp),
            16.height,
            Obx(() => ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: controller.transactions.length,
                itemBuilder: (context, index) {
                  var data = controller.transactions[index];
                  return GCCardColumn(
                    onPressed: () {
                      if (data.type == TransactionType.spend) {
                        Get.toNamed(Routes.REDEMPTION_SHOW, arguments: data);
                      }
                      if (data.type == TransactionType.earn) {
                        Get.toNamed(Routes.ACTIVITY_SHOW, arguments: data);
                      }
                    },
                    margin: EdgeInsets.only(bottom: 16),
                    padding: 16,
                    children: [
                      Text(
                        data.description ?? '',
                        maxLines: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            dateTimeFormatter(data.dateCreated),
                            style: textTheme(context)
                                .labelMedium
                                ?.copyWith(color: secondTextColor),
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(
                                svg_gp,
                                width: 24,
                              ),
                              8.width,
                              Text(
                                "${decimalFormatter(data.points)} ${'gp'.tr}${data.type == TransactionType.earn ? '+' : '-'}",
                                style: textTheme(context).bodyMedium?.copyWith(
                                    color: data.type == TransactionType.earn
                                        ? primaryColor(context)
                                        : theme(context).colorScheme.error,
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  );
                }))
          ],
        ));
  }
}
