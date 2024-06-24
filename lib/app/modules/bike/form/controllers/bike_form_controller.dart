import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_campus_app/app/data/models/bike_model.dart';
import 'package:green_campus_app/app/data/models/facility_model.dart';
import 'package:green_campus_app/app/data/widgets/form_foto.dart';

class BikeFormController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey();
  GCFormFoto formFoto = GCFormFoto();
  TextEditingController nameC = TextEditingController();
  TextEditingController descriptionC = TextEditingController();
  Rxn<String> selectedStatus = Rxn();
  Rxn<String> selectedType = Rxn();
  Rxn<FacilityModel> selectedStation = Rxn();

  Rxn<BikeModel> _bike = Rxn();
  BikeModel? get bike => this._bike.value;
  set bike(BikeModel? value) => this._bike.value = value;

  Rx<bool> _isLoading = false.obs;
  bool get isLoading => this._isLoading.value;
  set isLoading(bool value) => this._isLoading.value = value;

  Rx<bool> _isLoadingStations = false.obs;
  bool get isLoadingStations => this._isLoadingStations.value;
  set isLoadingStations(bool value) => this._isLoadingStations.value = value;

  loadController() {
    if (bike is BikeModel) {
      formFoto.oldPath = bike!.foto ?? formFoto.oldPath;
      nameC.text = bike!.name;
      descriptionC.text = bike!.description ?? '';
      selectedType.value = bike!.type;
      selectedStatus.value = bike!.status;
      selectedStation.value = bikeStations
          .firstWhereOrNull((element) => element.id == bike!.lastStation);
    }
  }

  Future<BikeModel?> save() async {
    try {
      isLoading = true;
      print("PRINT BIKE ID: ${bike?.id}");
      bike = BikeModel(
          id: bike?.id ?? '',
          description: descriptionC.text,
          name: nameC.text,
          foto: bike?.foto,
          type: selectedType.value ?? BikeType.other,
          lastStation: selectedStation.value?.id ?? '',
          dateCreated: bike?.dateCreated ?? DateTime.now(),
          status: selectedStatus.value ?? '');
      File? file;
      print("PRINT BIKE ID 2: ${bike?.id}");
      if (formFoto.newPath.isNotEmpty) {
        file = File(formFoto.newPath);
      }
      var res = await bike!.save(file: file);
      Get.back();
      return res;
    } on Exception catch (e) {
      Get.snackbar('error'.tr, e.toString());
      return null;
    } finally {
      isLoading = false;
    }
  }

  RxList<FacilityModel> bikeStations = RxList();

  Future<List<FacilityModel>> getStations() async {
    try {
      isLoadingStations = true;
      bikeStations.value = await FacilityModel.getCollection
          .where(FacilityModel.TYPE, isEqualTo: FacilityType.bikeStation)
          .get()
          .then((value) =>
              value.docs.map((e) => FacilityModel.fromSnapshot(e)).toList());
      selectedStation.value = bikeStations
          .firstWhereOrNull((element) => element.id == bike?.lastStation);
      return bikeStations;
    } catch (e) {
      printError(info: e.toString());
      return [];
    } finally {
      isLoadingStations = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is BikeModel) {
      bike = Get.arguments;
      loadController();
    }
    getStations();
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
