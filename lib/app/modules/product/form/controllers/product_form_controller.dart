import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_campus_app/app/data/models/product_model.dart';
import 'package:green_campus_app/app/data/widgets/form_foto.dart';
import 'package:nb_utils/nb_utils.dart';

class ProductsFormController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey();

  GCFormFoto formFoto = GCFormFoto();
  TextEditingController titleC = TextEditingController();
  TextEditingController storeC = TextEditingController();
  TextEditingController priceC = TextEditingController();
  TextEditingController descriptionC = TextEditingController();

  Rxn<bool> isAvailable = Rxn();

  var _isLoading = false.obs;
  get isLoading => this._isLoading.value;
  set isLoading(value) => this._isLoading.value = value;

  Rxn<ProductModel> _model = Rxn();
  ProductModel? get model => this._model.value;
  set model(ProductModel? value) => this._model.value = value;

  Future save() async {
    try {
      isLoading = true;

      model = model ?? ProductModel();

      model!.title = titleC.text;
      model!.price = (priceC.text).toInt();
      model!.store = storeC.text;
      model!.description = descriptionC.text;
      model!.isAvailable = isAvailable.value;
      model!.dateCreated =
          model!.id.isEmptyOrNull ? DateTime.now() : model!.dateCreated;

      File? file;
      if (formFoto.newPath.isNotEmpty) {
        file = File(formFoto.newPath);
      }

      model = await model!.save(file: file);
      Get.back();
      Get.snackbar("Success", "Product saved successfully");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading = false;
    }
  }

  void loadProduct() {
    if (model is ProductModel) {
      formFoto.oldPath = model?.foto ?? '';
      titleC.text = model?.title ?? '';
      descriptionC.text = model?.description ?? '';
      priceC.text = model?.price?.toString() ?? '';
      storeC.text = model?.store ?? '';
      isAvailable.value = model?.isAvailable;
    }
  }

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is ProductModel) {
      model = Get.arguments;
      loadProduct();
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
