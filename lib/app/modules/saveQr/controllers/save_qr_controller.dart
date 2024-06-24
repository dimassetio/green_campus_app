import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:green_campus_app/app/data/models/bike_model.dart';
import 'package:green_campus_app/app/data/models/facility_model.dart';
import 'dart:ui' as ui;

import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class SaveQrController extends GetxController {
  Rx<String> _data = ''.obs;
  String get data => this._data.value;
  set data(String value) => this._data.value = value;

  Rxn<BikeModel> _bike = Rxn();
  BikeModel? get bike => this._bike.value;
  set bike(BikeModel? value) => this._bike.value = value;

  Rxn<FacilityModel> _facility = Rxn();
  FacilityModel? get facility => this._facility.value;
  set facility(FacilityModel? value) => this._facility.value = value;

  var _isLoading = false.obs;
  bool get isLoading => this._isLoading.value;
  set isLoading(bool value) => this._isLoading.value = value;

  loadBikeData(BikeModel bike) {
    data = "${BikeModel.COLLECTION_NAME}_${bike.id}";
  }

  loadFacility(FacilityModel value) {
    facility = value;
    data = "${FacilityModel.COLLECTION_NAME}_${value.id}";
  }

  GlobalKey globalKey = GlobalKey();

  Future<void> saveQrCode() async {
    try {
      isLoading = true;
      RenderRepaintBoundary boundary =
          globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 10.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      // Save image to gallery
      await _saveImageToGallery(pngBytes);
      Get.snackbar('Success', 'QR code saved to gallery!',
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
    }
  }

  Future<void> _saveImageToGallery(Uint8List image) async {
    await [Permission.storage].request();

    final result = await ImageGallerySaver.saveImage(
      image,
      quality: 60,
      name: 'qr_code_image',
    );

    print(result);
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is BikeModel) {
      loadBikeData(Get.arguments);
      bike = Get.arguments;
    }
    if (Get.arguments is FacilityModel) {
      loadFacility(Get.arguments);
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
