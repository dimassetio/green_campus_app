import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:green_campus_app/app/data/helpers/database.dart';
import 'package:green_campus_app/app/data/helpers/formatter.dart';
import 'package:green_campus_app/app/data/models/bike_model.dart';
import 'package:green_campus_app/app/data/models/user_model.dart';

abstract class RentStatus {
  static const String active = 'Active';
  static const String needVerification = 'Need Verification';
  static const String done = 'Done';
}

class RentModel extends Database {
  static const String COLLECTION_NAME = "rents";

  static const String ID = "ID";
  static const String USER_ID = "USER_ID";
  static const String VERIFICATOR_ID = "VERIFICATOR_ID";
  static const String BIKE_ID = "BIKE_ID";
  static const String BIKE_NAME = "BIKE_NAME";
  static const String FACILITY_ID = "FACILITY_ID";
  static const String DATE_START = "DATE_START";
  static const String DATE_FINISH = "DATE_FINISH";
  static const String POSITION = "POSITION";

  String? id;
  String? verificatorId;
  String userId;
  String bikeId;
  String bikeName;
  String facilityId;
  DateTime dateStart;
  DateTime? dateFinish;
  bool get isActive => dateFinish == null;
  bool get needVerification => getStatus() == RentStatus.needVerification;

  GeoPoint? position;

  BikeModel? bikeModel;
  UserModel? userModel;

  String getStatus() {
    if (dateFinish == null) {
      return RentStatus.active;
    } else if (verificatorId == null) {
      return RentStatus.needVerification;
    } else if (dateFinish is DateTime && verificatorId is String) {
      return RentStatus.done;
    }
    return '';
  }

  Future<UserModel?> getUser() async {
    userModel = await UserModel(id: userId).getUser();
    return userModel;
  }

  Future<UserModel?> getVerificator() async {
    userModel = await UserModel(id: verificatorId).getUser();
    return userModel;
  }

  Future<BikeModel?> getBike() async {
    bikeModel = await BikeModel.getById(bikeId);
    return bikeModel;
  }

  static CollectionReference getCollectionReference(String userId) => firestore
      .collection(UserModel.COLLECTION_NAME)
      .doc(userId)
      .collection(COLLECTION_NAME);

  static Query getCollectionGroup() =>
      firestore.collectionGroup(COLLECTION_NAME);

  StreamSubscription<Position>? positionStream;

  Future cancelSubscription() async {
    if (positionStream != null) {
      positionStream?.cancel();
    }
    position = null;
    this.save();
  }

  void startLocationStream() {
    positionStream = Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 0,
      ),
    ).listen((Position value) {
      _savePosition(value);
    });
  }

  void _savePosition(Position value) {
    position = posToGeo(value);
    this.save();
  }

  RentModel({
    required this.id,
    required this.userId,
    required this.bikeId,
    required this.bikeName,
    required this.facilityId,
    required this.dateStart,
    this.verificatorId,
    this.position,
    this.dateFinish,
    this.bikeModel,
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

  factory RentModel.fromSnapshot(DocumentSnapshot doc, {BikeModel? bike}) {
    final data = doc.data() as Map<String, dynamic>;
    return RentModel(
      id: doc.id,
      userId: data[USER_ID],
      verificatorId: data[VERIFICATOR_ID],
      bikeId: data[BIKE_ID],
      bikeName: data[BIKE_NAME],
      facilityId: data[FACILITY_ID],
      position: data[POSITION],
      dateStart: (data[DATE_START] as Timestamp).toDate(),
      dateFinish: data[DATE_FINISH] != null
          ? (data[DATE_FINISH] as Timestamp).toDate()
          : null,
      bikeModel: bike,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ID: id,
      USER_ID: userId,
      VERIFICATOR_ID: verificatorId,
      BIKE_ID: bikeId,
      BIKE_NAME: bikeName,
      FACILITY_ID: facilityId,
      DATE_START: dateStart,
      DATE_FINISH: dateFinish,
      POSITION: position,
    };
  }

  static Future<RentModel?> getById(
      {required String userId, required String id}) async {
    return getCollectionReference(userId)
        .doc(id)
        .get()
        .then((value) => RentModel.fromSnapshot(value));
  }

  Future<RentModel> save({File? file, bool? isSet}) async {
    try {
      final docRef = super.collectionReference.doc(id);
      final rentId = docRef.id;
      id = rentId;
      await docRef.set(toJson());
      return this;
    } catch (e) {
      print('Error Saving: $e');
      rethrow;
    }
  }

  Stream<RentModel> stream() {
    return super
        .collectionReference
        .doc(id)
        .snapshots()
        .map((event) => RentModel.fromSnapshot(event, bike: bikeModel));
  }
}
