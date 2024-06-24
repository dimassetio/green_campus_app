import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_campus_app/app/data/models/facility_model.dart';
import 'package:green_campus_app/app/data/widgets/form_foto.dart';
import 'package:nb_utils/nb_utils.dart';

class FacilitiesFormController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey();
  GCFormFoto formFoto = GCFormFoto();
  TextEditingController nameC = TextEditingController();
  TextEditingController latC = TextEditingController();
  TextEditingController longC = TextEditingController();
  TextEditingController buildingC = TextEditingController();
  TextEditingController descriptionC = TextEditingController();
  Rxn<String> _selectedType = Rxn();
  String? get selectedType => this._selectedType.value;
  set selectedType(String? value) => this._selectedType.value = value;

  Rxn<FacilityModel> _facility = Rxn();
  FacilityModel? get facility => this._facility.value;
  set facility(FacilityModel? value) => this._facility.value = value;

  Rx<bool> _isLoading = false.obs;
  bool get isLoading => this._isLoading.value;
  set isLoading(bool value) => this._isLoading.value = value;

  loadController() {
    if (facility is FacilityModel) {
      formFoto.oldPath = facility!.foto ?? formFoto.oldPath;
      nameC.text = facility!.name;
      latC.text = facility!.location.latitude.toString();
      longC.text = facility!.location.longitude.toString();
      buildingC.text = facility!.building ?? buildingC.text;
      descriptionC.text = facility!.description;
      selectedType = facility!.type;
    }
  }

  Future<FacilityModel?> save() async {
    try {
      isLoading = true;
      facility = FacilityModel(
        id: facility?.id ?? '',
        building: buildingC.text,
        dateCreated: facility?.dateCreated ?? DateTime.now(),
        description: descriptionC.text,
        location: GeoPoint(latC.text.toDouble(), longC.text.toDouble()),
        name: nameC.text,
        foto: facility?.foto,
        type: selectedType ?? FacilityType.others,
      );
      File? file;
      if (formFoto.newPath.isNotEmpty) {
        file = File(formFoto.newPath);
      }
      var res = await facility!.save(file: file);
      Get.back();
      return res;
    } on Exception catch (e) {
      Get.snackbar('error'.tr, e.toString());
      return null;
    } finally {
      isLoading = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is FacilityModel) {
      facility = Get.arguments;
      loadController();
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
