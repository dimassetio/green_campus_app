import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_campus_app/app/data/models/activity_model.dart';
import 'package:green_campus_app/app/data/models/gpTransaction_model.dart';
import 'package:green_campus_app/app/data/models/user_model.dart';
import 'package:green_campus_app/app/data/widgets/dialog.dart';
import 'package:green_campus_app/app/modules/auth/controllers/auth_controller.dart';

class ActivityShowController extends GetxController {
  //TODO: Implement ActivityShowController

  bool get isAdmin => authC.user.hasRole(Role.administrator);
  Rx<ActivityModel> _model = ActivityModel(userId: 'a').obs;
  ActivityModel get model => this._model.value;
  set model(ActivityModel value) => this._model.value = value;

  Future<ActivityModel?> getModel(String userId, String id) async {
    try {
      isLoading = true;
      print(userId + '__' + id);
      model = await ActivityModel(userId: userId, id: id).getById() ?? model;
      return model;
    } catch (e) {
      printError(info: e.toString());
      return null;
    } finally {
      isLoading = false;
    }
  }

  var _isLoading = false.obs;
  get isLoading => this._isLoading.value;
  set isLoading(value) => this._isLoading.value = value;

  Future addPoint() async {
    var user = await model.getUser();
    GPTransactionModel point = GPTransactionModel(
        id: null,
        userId: model.userId,
        referenceId: model.id!,
        points: model.rewards!,
        pointsBefore: user!.gp!,
        dateCreated: DateTime.now(),
        description: 'rewardsFrom'.trParams({'challenge': model.title!}),
        type: TransactionType.earn);
    await point.save();
  }

  Future changeStatus(
      {required BuildContext context, required String status}) async {
    await showDialog(
      context: context,
      builder: (context) => GCDialog(
        title: 'confirmation',
        subtitle: "${'changeStatusConfirmation'.tr} '$status'",
        negativeText: 'cancel'.tr,
        onConfirm: () async {
          model.status = status;
          model = await model.save();
          if (status == StatusActivity.approved) {
            await addPoint();
          }
          Get.back(closeOverlays: true);
          Get.back(closeOverlays: true);
          Get.snackbar('success'.tr, 'statusChanged'.tr);
        },
      ),
    );
  }

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is ActivityModel) {
      model = Get.arguments;
    } else if (Get.arguments is GPTransactionModel) {
      GPTransactionModel transaction = Get.arguments;
      getModel(transaction.userId, transaction.referenceId);
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
