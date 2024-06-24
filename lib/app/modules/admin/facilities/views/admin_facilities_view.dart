import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:green_campus_app/app/data/helpers/assets.dart';
import 'package:green_campus_app/app/data/helpers/themes.dart';
import 'package:green_campus_app/app/data/models/facility_model.dart';
import 'package:green_campus_app/app/data/widgets/app_bar.dart';
import 'package:green_campus_app/app/data/widgets/form_foto.dart';
import 'package:green_campus_app/app/data/widgets/main_container.dart';
import 'package:green_campus_app/app/routes/app_pages.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/admin_facilities_controller.dart';

class AdminFacilitiesView extends GetView<AdminFacilitiesController> {
  const AdminFacilitiesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add_rounded),
          onPressed: () {
            Get.toNamed(Routes.FACILITIES_FORM);
          }),
      body: GCMainContainer(
        scrollable: true,
        children: [
          GCAppBar(
            label: 'greenFacilities'.tr,
            svgIcon: svg_ic_map_a,
            showNotification: false,
          ),
          16.height,
          Obx(() => ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: controller.facilities.length,
                itemBuilder: (context, index) => FacilityCard(
                  facility: controller.facilities[index],
                  onTap: () => Get.toNamed(Routes.FACILITIES_FORM,
                      arguments: controller.facilities[index]),
                ),
              ))
        ],
      ),
    );
  }
}

class FacilityCard extends StatelessWidget {
  const FacilityCard({
    super.key,
    required this.facility,
    this.height,
    this.width,
    this.onTap,
  });

  final FacilityModel facility;
  final double? height;
  final double? width;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          width: width,
          height: height,
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              GCFormFoto(
                height: 60,
                width: 60,
                defaultPath: img_logo,
                oldPath: facility.foto ?? '',
                showButton: false,
              ),
              16.width,
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      facility.name,
                      style: textTheme(context)
                          .titleSmall
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    4.height,
                    Row(
                      children: [
                        SvgPicture.asset(
                          svg_ic_map_a,
                          width: 24,
                        ),
                        8.width,
                        Expanded(
                          child: Text(facility.type),
                        )
                      ],
                    ),
                    4.height,
                    Row(
                      children: [
                        Icon(
                          Icons.location_city_outlined,
                          color: primaryColor(context),
                        ),
                        8.width,
                        Expanded(
                          child: Text(facility.building ?? ''),
                        )
                      ],
                    ),
                    4.height,
                    // Text(
                    //   facility.description,
                    //   maxLines: 2,
                    //   overflow: TextOverflow.ellipsis,
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 20,
                          color: theme(context).colorScheme.error,
                        ),
                        8.width,
                        Expanded(
                          child: Text(
                            "${facility.location.latitude}, ${facility.location.longitude}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    )
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
