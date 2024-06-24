import 'package:get/get.dart';
import 'package:green_campus_app/app/data/models/gpTransaction_model.dart';
import 'package:green_campus_app/app/data/models/product_model.dart';
import 'package:green_campus_app/app/data/models/redemption_model.dart';

class RedemptionShowController extends GetxController {
  //TODO: Implement RedemptionShowController

  // GPTransactionModel? gpTransactionModel;
  Rxn<RedemptionModel> _redemptionModel = Rxn();
  RedemptionModel? get redemptionModel => this._redemptionModel.value;
  set redemptionModel(value) => this._redemptionModel.value = value;

  var _isLoading = false.obs;
  bool get isLoading => this._isLoading.value;
  set isLoading(value) => this._isLoading.value = value;

  Future<RedemptionModel?> getRedemption(
      GPTransactionModel? transaction) async {
    try {
      isLoading = true;
      if (transaction is GPTransactionModel) {
        redemptionModel = await RedemptionModel.getById(
            userId: transaction.userId, id: transaction.referenceId);
      }
      if (redemptionModel is RedemptionModel) {
        redemptionModel!.productModel =
            await ProductModel(id: redemptionModel!.productId).getById();
        _redemptionModel.bindStream(redemptionModel!.stream());
      }
      return redemptionModel;
    } catch (e) {
      printError(info: e.toString());
      return null;
    } finally {
      isLoading = false;
    }
  }

  List<String> instructions = [
    'goToStoreLocation'.tr,
    'askStaffToScan'.tr,
    'makeSureStatusIsChanged'.tr,
    'enjoyYourProduct'.tr,
  ];

  // Future<ProductModel?> getProduct()async{
  //   ProductModel(id: gpTransactionModel.)
  // }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is RedemptionModel) {
      redemptionModel = Get.arguments;
      getRedemption(null);
    }
    if (Get.arguments is GPTransactionModel) {
      var trans = Get.arguments;
      getRedemption(trans);
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
