import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:green_campus_app/app/data/helpers/formatter.dart';
import 'package:green_campus_app/app/data/helpers/location_service.dart';
import 'package:green_campus_app/app/data/models/activity_model.dart';
import 'package:green_campus_app/app/data/models/challenge_model.dart';
import 'package:green_campus_app/app/data/widgets/form_foto.dart';
import 'package:green_campus_app/app/modules/auth/controllers/auth_controller.dart';
import 'package:nb_utils/nb_utils.dart';

class ActivityFormController extends GetxController {
  //TODO: Implement ActivityFormController

  GlobalKey<FormState> formKey = GlobalKey();

  GCFormFoto formFoto = GCFormFoto(
    forceCamera: true,
  );

  TextEditingController timeC = TextEditingController.fromValue(
      TextEditingValue(text: dateTimeFormatter(DateTime.now())));
  TextEditingController positionC = TextEditingController();
  Position? position;

  Rxn<ChallengeModel> _selectedChallenge = Rxn();
  ChallengeModel? get selectedChallenge => this._selectedChallenge.value;
  set selectedChallenge(value) => this._selectedChallenge.value = value;

  RxList<ChallengeModel> challenges = RxList();
  var loadingChallenge = false.obs;
  Future<List<ChallengeModel>> getChallenges() async {
    try {
      loadingChallenge.value = true;
      var result = await ChallengeModel()
          .collectionReference
          .where(ChallengeModel.IS_ACTIVE, isEqualTo: true)
          .orderBy(ChallengeModel.DATE_CREATED, descending: true)
          .get()
          .then((value) =>
              value.docs.map((e) => ChallengeModel.fromSnapshot(e)).toList());
      challenges.value = result;
      if (Get.arguments is ChallengeModel) {
        ChallengeModel argument = Get.arguments;
        selectedChallenge =
            challenges.firstWhereOrNull((element) => element.id == argument.id);
      }
      return result;
    } catch (e) {
      print(e.toString());
      return [];
    } finally {
      loadingChallenge.value = false;
    }
  }

  var _isLoading = false.obs;
  get isLoading => this._isLoading.value;
  set isLoading(value) => this._isLoading.value = value;

  Future loadLocation() async {
    try {
      isLoading = true;
      position = await getPosition();
      // List<Placemark> placemarks = await placemarkFromCoordinates(
      //     position!.latitude, position!.longitude);
      // if (placemarks.isNotEmpty) {
      //   Placemark place = placemarks.first;
      //   var alamat =
      //       "${place.name}, ${place.street}, ${place.subLocality}, ${place.locality}";
      //   positionC.text = alamat;
      // }
      positionC.text = await getAddress(position: position);
    } on Exception catch (e) {
      Get.snackbar("locationError".tr, e.toString());
      return null;
    } finally {
      isLoading = false;
    }
  }

  Rxn<ActivityModel> _model = Rxn();
  ActivityModel? get model => this._model.value;
  set model(ActivityModel? value) => this._model.value = value;

  Future save() async {
    try {
      isLoading = true;
      if (model == null) {
        if (authC.user.id.isEmptyOrNull) {
          throw Exception('unauthorizedUser'.tr);
        }
        model = ActivityModel(userId: authC.user.id!);
      }
      model!.challengeId = selectedChallenge?.id;
      model!.title = selectedChallenge?.title;
      model!.rewards = selectedChallenge?.rewards;
      if (position == null) {
        throw Exception('locationError'.tr);
      }
      model!.location = posToGeo(position!);
      model!.status = StatusActivity.pending;
      model!.time = DateTime.now();
      if (!model!.validate()) {
        throw Exception('activityValidationError'.tr);
      }
      if (formFoto.newPath.isEmptyOrNull) {
        throw Exception('pleaseAddPhoto');
      }
      File file = File(formFoto.newPath);
      await model!.save(file: file);
      Get.back();
      Get.snackbar('success'.tr, 'dataSaved'.tr);
    } on Exception catch (e) {
      Get.snackbar('error'.tr, '$e');
    } finally {
      isLoading = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    getChallenges();
    loadLocation();
    Timer.periodic(
      Duration(seconds: 1),
      (period) => timeC.text = dateTimeFormatter(
        DateTime.now(),
      ),
    );
    if (Get.arguments is ActivityModel) {
      model = Get.arguments;
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
