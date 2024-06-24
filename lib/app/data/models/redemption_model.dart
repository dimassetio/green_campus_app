import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:green_campus_app/app/data/helpers/database.dart';
import 'package:green_campus_app/app/data/models/gpTransaction_model.dart';
import 'package:green_campus_app/app/data/models/product_model.dart';
import 'package:green_campus_app/app/data/models/user_model.dart';

class RedemptionModel extends Database {
  static const String COLLECTION_NAME = "redemptions";

  static const String ID = "ID";
  static const String USER_ID = "USER_ID";
  static const String PRODUCT_ID = "PRODUCT_ID";
  static const String POINTS_REDEEMED = "POINTS_REDEEMED";
  static const String CODE = "CODE";
  static const String REDEEMED = "REDEEMED";
  static const String DATE_CREATED = "DATE_CREATED";

  String? id;
  String userId;
  String productId;
  ProductModel? productModel;
  int pointsRedeemed;
  String code;
  DateTime? redeemed;
  DateTime dateCreated;

  UserModel? userModel;
  Future<UserModel?> getUser() async {
    userModel = await UserModel(id: userId).getUser();
    return userModel;
  }

  Future<ProductModel?> getProduct() async {
    productModel = await ProductModel(id: productId).getById();
    return productModel;
  }

  bool get isRedeemed => redeemed != null;

  static CollectionReference getCollectionReference(String userId) => firestore
      .collection(UserModel.COLLECTION_NAME)
      .doc(userId)
      .collection(COLLECTION_NAME);

  static Query getCollectionGroup() => firestore
      .collectionGroup(COLLECTION_NAME)
      .orderBy(DATE_CREATED, descending: true);

  RedemptionModel({
    required this.id,
    required this.userId,
    required this.productId,
    required this.pointsRedeemed,
    required this.code,
    this.redeemed,
    this.productModel,
    required this.dateCreated,
  }) : super(
          collectionReference: firestore
              .collection(UserModel.COLLECTION_NAME)
              .doc(userId)
              .collection(COLLECTION_NAME),
          storageReference: storage
              .ref(UserModel.COLLECTION_NAME)
              .child(userId)
              .child(COLLECTION_NAME),
        );

  factory RedemptionModel.fromSnapshot(DocumentSnapshot doc,
      {ProductModel? product}) {
    final data = doc.data() as Map<String, dynamic>;
    return RedemptionModel(
      id: doc.id,
      userId: data[USER_ID],
      productId: data[PRODUCT_ID],
      productModel: product,
      pointsRedeemed: data[POINTS_REDEEMED],
      code: data[CODE],
      redeemed: data[REDEEMED] != null
          ? (data[REDEEMED] as Timestamp).toDate()
          : null,
      dateCreated: (data[DATE_CREATED] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ID: id,
      USER_ID: userId,
      PRODUCT_ID: productId,
      POINTS_REDEEMED: pointsRedeemed,
      CODE: code,
      REDEEMED: redeemed != null ? Timestamp.fromDate(redeemed!) : null,
      DATE_CREATED: dateCreated,
    };
  }

  static Future<RedemptionModel?> getById(
      {required String userId, required String id}) async {
    return getCollectionReference(userId)
        .doc(id)
        .get()
        .then((value) => RedemptionModel.fromSnapshot(value));
  }

  Future<RedemptionModel?> confirmRedeem(DateTime value) async {
    redeemed = value;
    if (id?.isEmpty ?? true) {
      return null;
    } else {
      await super.collectionReference.doc(id).update({REDEEMED: redeemed});
      return this;
    }
  }

  Future<RedemptionModel> save({File? file, bool? isSet}) async {
    try {
      final docRef = super
          .collectionReference
          .doc(); // Firestore will generate a unique ID

      // Calculate the total points required for this redemption
      int totalPointsRequired = pointsRedeemed;

      // Verify if the user has enough points for this redemption
      int userPoints =
          await UserModel(id: userId).getUser().then((value) => value?.gp ?? 0);
      if (userPoints < totalPointsRequired) {
        throw Exception('Not enough Green Points');
      }

      // Create the redemption model
      final redemptionId = docRef.id; // Get the auto-generated redemption ID
      id = redemptionId; // Set the redemption ID in the redemption object
      code = "${userId}_${productId}_$id";
      // Add the new redemption to Firestore
      await docRef.set(toJson());

      // Generate a transaction record
      final transactionModel = GPTransactionModel(
        id: '${userId}_${redemptionId}_${DateTime.now().millisecondsSinceEpoch}',
        userId: userId,
        referenceId: redemptionId,
        points: pointsRedeemed,
        pointsBefore: userPoints,
        dateCreated: DateTime.now(),
        type: TransactionType.spend,
        description:
            'Redemption for product ${productModel?.title ?? productId}',
      );

      // Save the transaction record
      await transactionModel.save();

      // Update the user's points
      int newPoints = userPoints - totalPointsRequired;
      await UserModel(id: userId).updatePoint(newPoints);

      // Return the redemption model
      return this;
    } catch (e) {
      // Handle errors here
      print('Redemption failed: $e');
      rethrow; // Rethrow the error to handle it at the calling place
    }
  }

  Stream<RedemptionModel> stream() {
    return super.collectionReference.doc(id).snapshots().map(
        (event) => RedemptionModel.fromSnapshot(event, product: productModel));
  }
}
