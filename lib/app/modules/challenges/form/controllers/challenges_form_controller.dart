import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_campus_app/app/data/helpers/formatter.dart';
import 'package:green_campus_app/app/data/models/challenge_model.dart';
import 'package:green_campus_app/app/data/widgets/form_foto.dart';
import 'package:nb_utils/nb_utils.dart';

class ChallengesFormController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey();

  GCFormFoto formFoto = GCFormFoto();
  TextEditingController titleC = TextEditingController();
  TextEditingController rewardC = TextEditingController();
  TextEditingController descriptionC = TextEditingController();
  TextEditingController startDateC = TextEditingController();
  TextEditingController endDateC = TextEditingController();

  Rxn<bool> isActive = Rxn();
  Rxn<DateTime> startDate = Rxn();
  Rxn<DateTime> endDate = Rxn();

  Future<DateTime?> pickDate(BuildContext context) async {
    return await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(DateTime.now().year + 10),
    );
  }

  var _isLoading = false.obs;
  get isLoading => this._isLoading.value;
  set isLoading(value) => this._isLoading.value = value;

  Rxn<ChallengeModel> _model = Rxn();
  ChallengeModel? get model => this._model.value;
  set model(ChallengeModel? value) => this._model.value = value;

  Future save() async {
    try {
      isLoading = true;

      model = model ?? ChallengeModel();

      model!.title = titleC.text;
      model!.rewards = rewardC.text.toInt();
      model!.description = descriptionC.text;
      model!.startDate = startDate.value;
      model!.endDate = endDate.value;
      model!.isActive = isActive.value;

      File? file;
      if (formFoto.newPath.isNotEmpty) {
        file = File(formFoto.newPath);
      }
      if (model!.id.isEmptyOrNull) {
        model?.dateCreated = DateTime.now();
      }
      model = await model!.save(file: file);
      Get.back();
      Get.snackbar("Success", "Date created successfully");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading = false;
    }
  }

  void loadChallenge() {
    if (model is ChallengeModel) {
      formFoto.oldPath = model?.foto ?? '';
      titleC.text = model?.title ?? '';
      descriptionC.text = model?.description ?? '';
      rewardC.text = model?.rewards?.toString() ?? '';
      isActive.value = model?.isActive;
      startDate.value = model?.startDate;
      endDate.value = model?.endDate;
      startDateC.text = dateFormatter(model!.startDate);
      endDateC.text = dateFormatter(model!.endDate);
    }
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is ChallengeModel) {
      model = Get.arguments;
      loadChallenge();
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

  void increment() => count.value++;
}
