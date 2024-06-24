import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:green_campus_app/app/data/helpers/database.dart';
import 'package:green_campus_app/app/data/models/activity_model.dart';
import 'package:green_campus_app/app/data/models/user_model.dart';
import 'package:nb_utils/nb_utils.dart';

abstract class TransactionType {
  static const earn = 'Earn';
  static const spend = 'Spend';
  static const list = [earn, spend];
}

class GPTransactionModel extends Database {
  static const String COLLECTION_NAME = "gp_transaction";

  static const String ID = "ID";
  static const String USER_ID = "USER_ID";
  static const String REFERENCE_ID = "REFERENCE_ID";
  static const String POINTS = "POINTS";
  static const String POINTS_BEFORE = "POINTS_BEFORE";
  static const String TYPE = "TYPE";
  static const String DESCRIPTION = "DESCRIPTION";
  static const String DATE_CREATED = "DATE_CREATED";

  String? id;
  String userId;
  String referenceId;
  int points;
  int pointsBefore;
  DateTime dateCreated;
  String type;
  String? description;

  UserModel? userModel;
  Future<UserModel?> getUser() async {
    userModel = await UserModel(id: userId).getUser();
    return userModel;
  }

  ActivityModel? activityModel;
  Future<ActivityModel?> getActivity() async {
    activityModel =
        await ActivityModel(userId: userId, id: referenceId).getById();
    return activityModel;
  }

  static CollectionReference getCollectionReference(String userId) => firestore
      .collection(UserModel.COLLECTION_NAME)
      .doc(userId)
      .collection(COLLECTION_NAME);

  GPTransactionModel({
    required this.id,
    required this.userId,
    required this.referenceId,
    required this.points,
    required this.pointsBefore,
    required this.dateCreated,
    required this.type,
    this.description,
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

  factory GPTransactionModel.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return GPTransactionModel(
      id: doc.id,
      userId: data[USER_ID],
      referenceId: data[REFERENCE_ID],
      points: data[POINTS],
      pointsBefore: data[POINTS_BEFORE],
      dateCreated: (data[DATE_CREATED] as Timestamp).toDate(),
      type: data[TYPE],
      description: data[DESCRIPTION],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ID: id,
      USER_ID: userId,
      REFERENCE_ID: referenceId,
      POINTS: points,
      POINTS_BEFORE: pointsBefore,
      TYPE: type,
      DESCRIPTION: description,
      DATE_CREATED: dateCreated,
    };
  }

  Future<GPTransactionModel?> getById() async {
    return id.isEmptyOrNull
        ? null
        : await super
            .collectionReference
            .doc(id)
            .get()
            .then((value) => GPTransactionModel.fromSnapshot(value));
  }

  Future<GPTransactionModel> save({File? file, bool? isSet}) async {
    final transactionId = '${userId}_$referenceId';
    final docRef = super.collectionReference.doc(transactionId);

    // Check if the document already exists
    final docSnapshot = await docRef.get();

    if (!docSnapshot.exists) {
      // Set the transactionId in the transaction object
      id = transactionId;

      // Add the new transaction
      await docRef.set(toJson());
    } else {
      // Handle the case where the transaction already exists (e.g., notify the user)
      print('Transaction already exists for this challenge.');
      return this;
    }

    // id.isEmptyOrNull
    //     ? id = await super.add(toJson())
    //     : (isSet ?? false)
    //         ? super.collectionReference.doc(id).set(toJson())
    //         : await super.edit(toJson());
    int newPoint = type == TransactionType.earn
        ? (pointsBefore + points)
        : (pointsBefore - points);
    UserModel(id: userId).updatePoint(newPoint);
    return this;
  }

  Stream<GPTransactionModel> stream() {
    return super
        .collectionReference
        .doc(id)
        .snapshots()
        .map((event) => GPTransactionModel.fromSnapshot(event));
  }
}
