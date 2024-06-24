import 'package:get/get.dart';
import 'package:green_campus_app/app/data/models/gpTransaction_model.dart';
import 'package:green_campus_app/app/modules/auth/controllers/auth_controller.dart';

class TransactionsController extends GetxController {
  RxList<GPTransactionModel> transactions = RxList();
  Stream<List<GPTransactionModel>> streamTransactions() {
    return GPTransactionModel.getCollectionReference(authC.user.id!)
        .orderBy(GPTransactionModel.DATE_CREATED, descending: true)
        .snapshots()
        .map(
          (event) => event.docs
              .map((e) => GPTransactionModel.fromSnapshot(e))
              .toList(),
        );
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    transactions.bindStream(streamTransactions());
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
