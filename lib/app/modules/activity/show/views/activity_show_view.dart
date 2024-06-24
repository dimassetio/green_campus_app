import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:green_campus_app/app/data/helpers/assets.dart';
import 'package:green_campus_app/app/data/helpers/formatter.dart';
import 'package:green_campus_app/app/data/helpers/themes.dart';
import 'package:green_campus_app/app/data/models/activity_model.dart';
import 'package:green_campus_app/app/data/widgets/app_bar.dart';
import 'package:green_campus_app/app/data/widgets/card_column.dart';
import 'package:green_campus_app/app/data/widgets/error.dart';
import 'package:green_campus_app/app/data/widgets/form_foto.dart';
import 'package:green_campus_app/app/data/widgets/main_container.dart';
import 'package:green_campus_app/app/data/widgets/tile.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/activity_show_controller.dart';

class ActivityShowView extends GetView<ActivityShowController> {
  const ActivityShowView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => controller.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : controller.model.id == null
                ? GCErrorWidget(
                    message: 'failedLoadData'.trParams({'data': 'activity'.tr}))
                : GCMainContainer(
                    scrollable: true,
                    children: [
                      GCAppBar(
                          label: 'activityDetail'.tr,
                          showNotification: false,
                          svgIcon: svg_ic_challenge_a),
                      16.height,
                      GCCardColumn(
                        children: [
                          GCFormFoto(
                            showButton: false,
                            oldPath: controller.model.foto ?? '',
                          ),
                        ],
                      ),
                      16.height,
                      GCCardColumn(
                        children: [
                          GCTile(
                            leading: Icon(
                              Icons.military_tech_outlined,
                              color: primaryColor(context),
                            ),
                            label: 'greenChallenges'.tr,
                            value: controller.model.title ?? '',
                          ),
                          8.height,
                          GCTile(
                            leading: Icon(
                              Icons.access_time_outlined,
                              color: primaryColor(context),
                            ),
                            label: 'activityTime'.tr,
                            value: dateTimeFormatter(controller.model.time),
                          ),
                          8.height,
                          FutureBuilder(
                            future: getAddress(geo: controller.model.location),
                            builder: (context, snapshot) => GCTile(
                                leading: Icon(
                                  Icons.location_on_outlined,
                                  color: primaryColor(context),
                                ),
                                label: 'location'.tr,
                                value: snapshot.data ??
                                    writeCoordinate(
                                        geo: controller.model.location)),
                          ),
                        ],
                      ),
                      16.height,
                      GCCardColumn(
                        children: [
                          GCTile(
                            label: 'status'.tr,
                            value: controller.model.status ?? '',
                            leading: Icon(
                              Icons.approval_outlined,
                              color: primaryColor(context),
                            ),
                            trailing: controller.isAdmin &&
                                    controller.model.status !=
                                        StatusActivity.approved
                                ? Row(
                                    children: [
                                      if (controller.model.status !=
                                          StatusActivity.rejected)
                                        IconButton(
                                          onPressed: () {
                                            controller.changeStatus(
                                                context: context,
                                                status:
                                                    StatusActivity.rejected);
                                          },
                                          color:
                                              theme(context).colorScheme.error,
                                          icon: Icon(Icons.cancel_outlined),
                                        ),
                                      IconButton(
                                        onPressed: () {
                                          controller.changeStatus(
                                              context: context,
                                              status: StatusActivity.approved);
                                        },
                                        color: primaryColor(context),
                                        icon: Icon(
                                            Icons.check_circle_outline_rounded),
                                      )
                                    ],
                                  )
                                : null,
                          ),
                          8.height,
                          GCTile(
                              leading: SvgPicture.asset(svg_gp),
                              label: 'rewards'.tr,
                              value:
                                  "${decimalFormatter(controller.model.rewards)} ${'gp'.tr}")
                        ],
                      ),
                      8.height,
                    ],
                  ),
      ),
    );
  }
}
