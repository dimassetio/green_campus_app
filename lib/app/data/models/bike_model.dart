import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:green_campus_app/app/data/helpers/database.dart';
import 'package:nb_utils/nb_utils.dart';

abstract class BikeType {
  static const urbanBike = "Urban Bike";
  static const mountainBike = "Mountain Bike";
  static const electricBike = "Electric Bike";
  static const other = "Others";

  static const list = [urbanBike, mountainBike, electricBike, other];
}

abstract class BikeStatus {
  static const available = "Available";
  static const inUse = "In Use";
  static const nonactive = "Non Active";

  static const list = [available, inUse, nonactive];
}

class BikeModel extends Database {
  static const String COLLECTION_NAME = "bikes";

  static const String ID = "ID";
  static const String NAME = 'NAME';
  static const String TYPE = 'TYPE';
  static const String DESCRIPTION = 'DESCRIPTION';
  static const String STATUS = 'STATUS';
  static const String LASTSTATION = 'LAST_STATION';
  static const String FOTO = 'FOTO';
  static const String DATECREATED = 'DATE_CREATED';

  String id;
  String name;
  String type;
  String? description;
  String status;
  String lastStation;
  String? foto;
  DateTime dateCreated;

  BikeModel({
    required this.id,
    required this.name,
    required this.type,
    required this.description,
    required this.status,
    required this.lastStation,
    required this.foto,
    required this.dateCreated,
  }) : super(
          collectionReference: firestore.collection(COLLECTION_NAME),
          storageReference: storage.ref(COLLECTION_NAME),
        );

  static CollectionReference get getCollection =>
      firestore.collection(COLLECTION_NAME);

  factory BikeModel.fromSnapshot(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return BikeModel(
      id: doc.id,
      name: data[NAME] ?? '',
      type: data[TYPE] ?? '',
      description: data[DESCRIPTION] ?? '',
      status: data[STATUS] ?? BikeStatus.nonactive,
      lastStation: data[LASTSTATION] ?? '',
      foto: data[FOTO] ?? '',
      dateCreated: (data[DATECREATED] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ID: id,
      NAME: name,
      TYPE: type,
      DESCRIPTION: description,
      STATUS: status,
      LASTSTATION: lastStation,
      FOTO: foto,
      DATECREATED: dateCreated,
    };
  }

  static Future<BikeModel?> getById(String idValue) async {
    return await getCollection
        .doc(idValue)
        .get()
        .then((value) => BikeModel.fromSnapshot(value));
  }

  Future<BikeModel> save({File? file, bool? isSet}) async {
    print("ID : $id");
    id.isEmptyOrNull
        ? id = await super.add(toJson()) ?? id
        : (isSet ?? false)
            ? super.collectionReference.doc(id).set(toJson())
            : await super.edit(toJson());

    print("ID 4: $id");
    if (file != null && !id.isEmptyOrNull) {
      foto = await super.upload(id: id, file: file);
      await super.edit(toJson());
    }
    return this;
  }

  static Stream<int> streamCountAtStation(String stationId) {
    return getCollection
        .where(LASTSTATION, isEqualTo: stationId)
        .where(STATUS, isEqualTo: BikeStatus.available)
        .snapshots()
        .map((value) => value.docs.length);
  }

  static Future updateStatus(String bikeId, String bikeStatus) async {
    return await getCollection.doc(bikeId).update({STATUS: bikeStatus});
  }

  static Future updateStation(String bikeId, String stationId) async {
    return await getCollection.doc(bikeId).update({LASTSTATION: stationId});
  }

  Stream<BikeModel> stream() {
    return super
        .collectionReference
        .doc(id)
        .snapshots()
        .map((event) => BikeModel.fromSnapshot(event));
  }
}
