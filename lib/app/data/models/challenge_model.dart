import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:green_campus_app/app/data/helpers/database.dart';
import 'package:nb_utils/nb_utils.dart';

ChallengeModel challengeDummy = ChallengeModel(
    id: 'sdau09qekcxz90uin',
    title: 'Bike to Campus',
    rewards: 100,
    startDate: DateTime(2024, 6, 1),
    endDate: DateTime(2030, 6, 1),
    isActive: true,
    description:
        """This challenge encourages you to rent a bike from our campus facilities and use it as your primary mode of transportation to and from campus. Not only will you reduce your carbon footprint, but you'll also enjoy the benefits of a healthier lifestyle and contribute to a greener campus environment. Here are the instruction for this challenges: 
  1. Rent a bike from Bike Rental Station.
  2. Follow the instructions on the bike rental station to rent a bike. Make sure to check the bike for any issues before starting your journey.
  3. Always wear a helmet, follow traffic rules, and use designated bike lanes for a safe and smooth ride.
  4. After reaching your destination, return the bike to the nearest rental station and make sure it's securely locked.""");

class ChallengeModel extends Database {
  static const String COLLECTION_NAME = "challenges";

  static const String ID = "ID";
  static const String TITLE = "TITLE";
  static const String REWARDS = "REWARDS";
  static const String START_DATE = "START_DATE";
  static const String END_DATE = "END_DATE";
  static const String IS_ACTIVE = "IS_ACTIVE";
  static const String DESCRIPTION = "DESCRIPTION";
  static const String FOTO = "FOTO";
  static const String DATE_CREATED = "DATE_CREATED";

  String? id;
  String? title;
  int? rewards;
  DateTime? startDate;
  DateTime? endDate;
  bool? isActive;
  String? description;
  String? foto;
  DateTime? dateCreated;

  ChallengeModel({
    this.id,
    this.title,
    this.rewards,
    this.startDate,
    this.endDate,
    this.isActive,
    this.description,
    this.foto,
    this.dateCreated,
  }) : super(
          collectionReference: firestore.collection(COLLECTION_NAME),
          storageReference: storage.ref(COLLECTION_NAME),
        );

  // UserModel.fromSnapshot(String? id, Map<String, dynamic> json)
  ChallengeModel.fromSnapshot(DocumentSnapshot doc)
      : id = doc.id,
        super(
            collectionReference: firestore.collection(COLLECTION_NAME),
            storageReference: storage.ref(COLLECTION_NAME)) {
    var json = doc.data() as Map<String, dynamic>?;
    this.title = json?[TITLE];
    this.rewards = json?[REWARDS];
    this.startDate = (json?[START_DATE] as Timestamp?)?.toDate();
    this.endDate = (json?[END_DATE] as Timestamp?)?.toDate();
    this.isActive = json?[IS_ACTIVE];
    this.description = json?[DESCRIPTION];
    this.foto = json?[FOTO];
    this.dateCreated = (json?[DATE_CREATED] as Timestamp?)?.toDate();
  }

  Map<String, dynamic> toJson() {
    return {
      ID: id,
      TITLE: title,
      REWARDS: rewards,
      START_DATE: startDate,
      END_DATE: endDate,
      IS_ACTIVE: isActive,
      DESCRIPTION: description,
      FOTO: foto,
      DATE_CREATED: dateCreated,
    };
  }

  Future<ChallengeModel?> getById() async {
    return id.isEmptyOrNull
        ? null
        : await super
            .collectionReference
            .doc(id)
            .get()
            .then((value) => ChallengeModel.fromSnapshot(value));
  }

  Future<ChallengeModel> save({File? file, bool? isSet}) async {
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

  Stream<ChallengeModel> stream() {
    return super
        .collectionReference
        .doc(id)
        .snapshots()
        .map((event) => ChallengeModel.fromSnapshot(event));
  }
}
