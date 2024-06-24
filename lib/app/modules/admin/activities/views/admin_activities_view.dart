import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:green_campus_app/app/data/helpers/assets.dart';
import 'package:green_campus_app/app/data/helpers/formatter.dart';
import 'package:green_campus_app/app/data/helpers/themes.dart';
import 'package:green_campus_app/app/data/models/activity_model.dart';
import 'package:green_campus_app/app/data/models/user_model.dart';
import 'package:green_campus_app/app/data/widgets/app_bar.dart';
import 'package:green_campus_app/app/data/widgets/circle_container.dart';
import 'package:green_campus_app/app/data/widgets/form_foto.dart';
import 'package:green_campus_app/app/data/widgets/main_container.dart';
import 'package:green_campus_app/app/routes/app_pages.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/admin_activities_controller.dart';

class AdminActivitiesView extends GetView<AdminActivitiesController> {
  const AdminActivitiesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GCMainContainer(scrollable: true, children: [
      GCAppBar(
        label: 'activities'.tr,
        svgIcon: svg_ic_challenge_a,
        showNotification: false,
      ),
      16.height,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'allActivities'.tr,
            style: textTheme(context)
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
          CircleContainer(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
              child: Text('filter'.tr))
        ],
      ),
      16.height,
      Obx(() => ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: controller.activities.length,
            itemBuilder: (context, index) => AdminActivityCard(
              activity: controller.activities[index],
            ),
          )),
    ]));
  }
}

class AdminActivityCard extends StatelessWidget {
  const AdminActivityCard({
    super.key,
    required this.activity,
  });

  final ActivityModel activity;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          Get.toNamed(Routes.ACTIVITY_SHOW, arguments: activity);
        },
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              GCFormFoto(
                oldPath: activity.foto ?? '',
                defaultPath: img_green_challenge,
                height: 60,
                width: 60,
                showButton: false,
              ),
              16.width,
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FutureBuilder<UserModel?>(
                      future: activity.getUser(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return LinearProgressIndicator();
                        }
                        if (snapshot.data?.name is String) {
                          return Text(
                            snapshot.data!.name!,
                            style: textTheme(context)
                                .titleSmall
                                ?.copyWith(fontWeight: FontWeight.w600),
                          );
                        }
                        return SizedBox();
                      },
                    ),
                    Text(
                      activity.title ?? "",
                    ),
                    4.height,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(svg_gp, width: 24),
                        Text(
                            "  ${decimalFormatter(activity.rewards ?? 0)} ${'gp'.tr}"),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              CircleContainer(
                                padding: EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 8),
                                color: secondaryColor,
                                margin: EdgeInsets.only(bottom: 4),
                                child: Text((activity.status ?? '').tr),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  dateTimeFormatter(activity.time),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
