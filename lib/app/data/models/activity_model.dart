import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:green_campus_app/app/data/helpers/database.dart';
import 'package:green_campus_app/app/data/models/user_model.dart';
import 'package:nb_utils/nb_utils.dart';

class Log {
  static const String DESCRIPTION = "DESCRIPTION";
  static const String DATE_CREATED = "DATE_CREATED";
  static const String USER_ID = "USER_ID";

  String description;
  String userId;
  DateTime dateCreated;

  Log({
    required this.description,
    required this.userId,
    required this.dateCreated,
  });

  Log.fromJson(Map<String, dynamic> value)
      : description = value[DESCRIPTION],
        userId = value[USER_ID],
        dateCreated = (value[DATE_CREATED] as Timestamp).toDate() {}

  Map<String, dynamic> toJson() => {
        DESCRIPTION: description,
        USER_ID: userId,
        DATE_CREATED: dateCreated,
      };
}

abstract class StatusActivity {
  static const pending = 'In Review';
  static const approved = 'Approved';
  static const rejected = 'Rejected';
}

class ActivityModel extends Database {
  static const String COLLECTION_NAME = "activity";

  static const String ID = "ID";
  static const String USER_ID = "USER_ID";
  static const String CHALLENGE_ID = "CHALLENGE_ID";
  static const String TITLE = "TITLE";
  static const String REWARDS = "REWARDS";
  static const String FOTO = "FOTO";
  static const String LOCATION = "LOCATION";
  static const String TIME = "TIME";
  static const String STATUS = "STATUS";
  static const String DATE_CREATED = "DATE_CREATED";
  static const String LOG = "LOG";

  String? id;
  String userId;
  String? challengeId;
  String? title;
  int? rewards;
  String? foto;
  GeoPoint? location;
  DateTime? time;
  String? status;
  DateTime? dateCreated;
  List<Log>? logs;

  UserModel? userModel;
  Future<UserModel?> getUser() async {
    userModel = await UserModel(id: userId).getUser();
    return userModel;
  }

  ActivityModel({
    this.id,
    required this.userId,
    this.challengeId,
    this.title,
    this.rewards,
    this.foto,
    this.location,
    this.time,
    this.status,
    this.dateCreated,
    this.logs,
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

  bool validate() {
    return !(this.challengeId == null ||
        this.title == null ||
        this.rewards == null ||
        this.location == null ||
        this.time == null ||
        this.status == null);
  }

  ActivityModel.fromSnapshot(DocumentSnapshot doc)
      : id = doc.id,
        userId = (doc.data() as Map<String, dynamic>?)?[USER_ID],
        super(
            collectionReference: firestore
                .collection(UserModel.COLLECTION_NAME)
                .doc((doc.data() as Map<String, dynamic>?)?[USER_ID])
                .collection(COLLECTION_NAME),
            storageReference: storage
                .ref(UserModel.COLLECTION_NAME)
                .child((doc.data() as Map<String, dynamic>?)?[USER_ID])
                .child(COLLECTION_NAME)) {
    var json = doc.data() as Map<String, dynamic>?;
    challengeId = json?[CHALLENGE_ID];
    title = json?[TITLE];
    rewards = json?[REWARDS];
    foto = json?[FOTO];
    location = json?[LOCATION];
    status = json?[STATUS];
    time = (json?[TIME] as Timestamp?)?.toDate();
    dateCreated = (json?[DATE_CREATED] as Timestamp?)?.toDate();
    logs =
        (json?[LOG] as List?)?.map((element) => Log.fromJson(element)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      ID: id,
      TITLE: title,
      REWARDS: rewards,
      FOTO: foto,
      USER_ID: userId,
      CHALLENGE_ID: challengeId,
      LOCATION: location,
      TIME: time,
      STATUS: status,
      LOG: logs?.map((e) => e.toJson()).toList(),
      DATE_CREATED: dateCreated,
    };
  }

  Future<ActivityModel?> getById() async {
    return id.isEmptyOrNull
        ? null
        : await super
            .collectionReference
            .doc(id)
            .get()
            .then((value) => ActivityModel.fromSnapshot(value));
  }

  Future<ActivityModel> save({File? file, bool? isSet}) async {
    id.isEmptyOrNull
        ? id = await super.add(toJson())
        : (isSet ?? false)
            ? super.collectionReference.doc(id).set(toJson())
            : await super.edit(toJson());
    if (file != null && !id.isEmptyOrNull) {
      foto = await super.upload(id: id!, file: file);
      await super.edit(toJson());
    }
    return this;
  }

  Stream<ActivityModel> stream() {
    return super
        .collectionReference
        .doc(id)
        .snapshots()
        .map((event) => ActivityModel.fromSnapshot(event));
  }
}
