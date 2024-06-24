import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:green_campus_app/app/data/helpers/assets.dart';
import 'package:green_campus_app/app/data/helpers/const.dart';
import 'package:green_campus_app/app/data/helpers/themes.dart';
import 'package:green_campus_app/app/data/models/facility_model.dart';
import 'package:green_campus_app/app/data/widgets/app_bar.dart';
import 'package:green_campus_app/app/data/widgets/button.dart';
import 'package:green_campus_app/app/data/widgets/card_column.dart';
import 'package:green_campus_app/app/data/widgets/dropdown_menu.dart';
import 'package:green_campus_app/app/data/widgets/main_container.dart';
import 'package:green_campus_app/app/data/widgets/text_field.dart';
import 'package:green_campus_app/app/routes/app_pages.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/facilities_form_controller.dart';

class FacilitiesFormView extends GetView<FacilitiesFormController> {
  const FacilitiesFormView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: controller.formKey,
        child: GCMainContainer(scrollable: true, children: [
          GCAppBar(
            label: 'facilitiesForm'.tr,
            svgIcon: svg_ic_map_a,
            showNotification: false,
          ),
          16.height,
          controller.formFoto,
          16.height,
          GCCardColumn(
            children: [
              GCDropdown(
                icon: Icon(Icons.check_circle_outline_rounded),
                label: 'type'.tr,
                initValue: controller.selectedType,
                listValue: FacilityType.list,
                isValidationRequired: true,
                onChanged: (value) => controller.selectedType = value,
              ),
              16.height,
              GCTextfield(
                controller: controller.nameC,
                label: 'name'.tr,
                icon: Icon(Icons.eco_outlined),
                isValidationRequired: true,
              ),
              16.height,
              GCTextfield(
                controller: controller.buildingC,
                label: 'building'.tr,
                icon: Icon(Icons.location_city_outlined),
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
              16.height,
              GCButton(
                title: 'pickLocation',
                icon: Icon(Icons.pin_drop_outlined),
                onPressed: () async {
                  var res = await showDialog(
                      context: context,
                      builder: (context) => PickLocationWidget());
                  if (res is LatLng) {
                    controller.latC.text = res.latitude.toString();
                    controller.longC.text = res.longitude.toString();
                  }
                },
                backgroundColor: theme(context).colorScheme.secondary,
                foregroundColor: theme(context).colorScheme.onSecondary,
              ),
              16.height,
              GCTextfield(
                controller: controller.latC,
                icon: Icon(Icons.location_on_outlined),
                label: 'latitude'.tr,
                textFieldType: TextFieldType.NUMBER,
                validator: (value) => double.tryParse(value ?? 'x') is double
                    ? null
                    : 'isNotValidNumberType',
              ),
              16.height,
              GCTextfield(
                controller: controller.longC,
                icon: Icon(Icons.location_on_outlined),
                label: 'longitude'.tr,
                textFieldType: TextFieldType.NUMBER,
                validator: (value) => double.tryParse(value ?? 'x') is double
                    ? null
                    : 'isNotValidNumberType',
              ),
            ],
          ),
          16.height,
          Obx(() => Row(
                children: [
                  if (controller.facility is FacilityModel &&
                      controller.facility?.type ==
                          FacilityType.bikeStation) ...[
                    GCButton(
                        icon: Icon(Icons.qr_code_2_rounded),
                        title: 'showQr'.tr,
                        onPressed: () {
                          Get.toNamed(Routes.SAVE_QR,
                              arguments: controller.facility!);
                        }),
                    16.width,
                  ],
                  Expanded(
                    child: GCButton(
                      icon: controller.isLoading
                          ? Expanded(child: LinearProgressIndicator())
                          : null,
                      title: controller.isLoading ? '' : 'submit'.tr,
                      onPressed: controller.isLoading
                          ? null
                          : () {
                              if (controller.formKey.currentState?.validate() ??
                                  false) controller.save();
                            },
                    ),
                  ),
                ],
              )),
          16.height,
        ]),
      ),
    );
  }
}

class PickLocationWidget extends GetView<FacilitiesFormController> {
  PickLocationWidget({
    super.key,
  });

  final Rxn<Marker> _marker = Rxn();

  void _onTap(LatLng value) {
    _marker.value = Marker(
      markerId: MarkerId('pickedLocation'),
      position: value,
      draggable: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: EdgeInsets.all(16),
        child: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: Get.height / 2,
                child: GoogleMap(
                  initialCameraPosition:
                      CameraPosition(target: coordinatUM, zoom: 17),
                  onTap: _onTap,
                  markers: _marker.value == null ? {} : {_marker.value!},
                ),
              ),
              16.height,
              Text(
                '${'pickedLocatioin'.tr}: ${_marker.value == null ? '' : ' ${_marker.value!.position.latitude}, ${_marker.value!.position.longitude}'}',
              ),
              GCButton(
                  title: _marker.value == null ? 'cancel'.tr : 'set'.tr,
                  onPressed: () {
                    Get.back(result: _marker.value?.position);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
