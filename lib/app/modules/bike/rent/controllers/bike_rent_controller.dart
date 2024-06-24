import 'dart:async';

import 'package:get/get.dart';
import 'package:green_campus_app/app/data/models/bike_model.dart';
import 'package:green_campus_app/app/data/models/facility_model.dart';
import 'package:green_campus_app/app/data/models/rent_model.dart';
import 'package:green_campus_app/app/data/widgets/dialog.dart';
import 'package:green_campus_app/app/modules/auth/controllers/auth_controller.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class BikeRentController extends GetxController {
  List<String> instructions = [
    'goToBikeStation'.tr,
    'askStaffForBike'.tr,
    'scanBikeQR'.tr,
    'makeSureSuccessNotification'.tr,
    'enjoyBike'.tr
  ];

  List<String> finishInstructions = [
    'goToBikeStation'.tr,
    'putBikeAtLocation'.tr,
    'scanStation'.tr,
    'makeSureSuccessNotification'.tr,
    'youreDone'.tr
  ];

  final MobileScannerController controller = MobileScannerController();

  handleBarcode(BarcodeCapture data) {
    if (data.barcodes.isNotEmpty) {
      var barcode = data.barcodes.first;
      if (barcode.rawValue is String) {
        controller.stop();
        if (rentModel is RentModel &&
            barcode.rawValue!.startsWith(FacilityModel.COLLECTION_NAME)) {
          finishRent(barcode.rawValue!);
        } else if (rentModel == null &&
            barcode.rawValue!.startsWith(BikeModel.COLLECTION_NAME)) {
          rent(barcode.rawValue!);
        } else {
          Get.dialog(GCDialog(
              title: 'invalidQR'.tr, subtitle: 'invalidQRMessageBike'.tr));
        }
      }
    }
  }

  Future rent(String qrValue) async {
    try {
      isLoading = true;
      String bikeId = qrValue.substring('${BikeModel.COLLECTION_NAME}_'.length);
      var bike = await BikeModel.getById(bikeId);
      if (bike == null) {
        throw Exception('failedToLoadBike'.tr);
      }
      if (bike.status != BikeStatus.available) {
        throw Exception('bikeStatusUnavailable'.tr);
      }
      RentModel rent = RentModel(
          id: null,
          userId: authC.user.id!,
          bikeId: bikeId,
          bikeName: bike.name,
          facilityId: bike.lastStation,
          dateStart: DateTime.now());

      var res = await rent.save();
      if (res.id is String) {
        BikeModel.updateStatus(bikeId, BikeStatus.inUse);
        // res.startLocationStream();
      }
      Get.back(closeOverlays: true);
      Get.snackbar("success".tr, 'successFinishRent'.tr);
    } on Exception catch (e) {
      printError(info: e.toString());
      Get.back();
      Get.snackbar('error'.tr, '$e');
      return null;
    } finally {
      isLoading = false;
    }
  }

  Future finishRent(String qrValue) async {
    try {
      isLoading = true;
      if (rentModel == null) {
        throw Exception('failedToLoadRentData');
      }
      String stationId =
          qrValue.substring('${FacilityModel.COLLECTION_NAME}_'.length);

      var bike = await BikeModel.getById(rentModel!.bikeId);
      if (bike == null) {
        throw Exception('failedToLoadBike'.tr);
      }

      rentModel!.dateFinish = DateTime.now();
      rentModel!.facilityId = stationId;
      var res = await rentModel!.save();
      if (res.id is String) {
        BikeModel.updateStatus(bike.id, BikeStatus.available);
        BikeModel.updateStation(bike.id, stationId);
      }
      Get.back(closeOverlays: true);
      Get.snackbar("success".tr, 'successRentABike'.tr);
    } on Exception catch (e) {
      printError(info: e.toString());
      Get.snackbar('error'.tr, '$e');
      return null;
    } finally {
      isLoading = false;
    }
  }

  var _isLoading = false.obs;
  bool get isLoading => this._isLoading.value;
  set isLoading(bool value) => this._isLoading.value = value;

  Rxn<RentModel> _rentModel = Rxn();
  RentModel? get rentModel => this._rentModel.value;
  set rentModel(value) => this._rentModel.value = value;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is RentModel) {
      rentModel = Get.arguments;
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
