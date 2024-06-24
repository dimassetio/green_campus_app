import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:green_campus_app/app/data/helpers/database.dart';
import 'package:nb_utils/nb_utils.dart';

FacilityModel dummyFacilities = FacilityModel(
  id: 'id',
  name: 'name',
  location: GeoPoint(-7.9635179, 112.6191717),
  type: FacilityType.drinkingFountain,
  building: 'building',
  description: 'description',
  dateCreated: DateTime.now(),
);

abstract class FacilityType {
  static const String drinkingFountain = 'Drinking Fountain';
  static const String recycleCenter = 'Recycle Center';
  static const String compostingFacility = 'Composting Facility';
  static const String bikeStation = 'Bike Station';
  static const String greenPark = 'Green Park';
  static const String wasteProcessingSite = 'Waste Processing Site';
  static const String others = 'Others';
  static const List<String> list = [
    drinkingFountain,
    recycleCenter,
    compostingFacility,
    bikeStation,
    greenPark,
    wasteProcessingSite,
    others
  ];
}

class FacilityModel extends Database {
  static const String COLLECTION_NAME = "greenFacilities";

  static const String ID = "ID";
  static const String NAME = "NAME";
  static const String LOCATION = "LOCATION";
  static const String BUILDING = "BUILDING";
  static const String TYPE = "TYPE";
  static const String DESCRIPTION = "DESCRIPTION";
  static const String FOTO = "FOTO";
  static const String DATE_CREATED = "DATE_CREATED";

  String id;
  String name;
  GeoPoint location;
  String type;
  String? building;
  String description;
  String? foto;
  DateTime dateCreated;

  FacilityModel({
    required this.id,
    required this.name,
    required this.location,
    required this.type,
    this.building,
    required this.description,
    this.foto,
    required this.dateCreated,
  }) : super(
          collectionReference: firestore.collection(COLLECTION_NAME),
          storageReference: storage.ref(COLLECTION_NAME),
        );

  static CollectionReference get getCollection =>
      firestore.collection(COLLECTION_NAME);

  factory FacilityModel.fromSnapshot(DocumentSnapshot doc) {
    var json = doc.data() as Map<String, dynamic>?;
    return FacilityModel(
      id: doc.id,
      name: json?[NAME],
      location: json?[LOCATION],
      type: json?[TYPE],
      building: json?[BUILDING],
      description: json?[DESCRIPTION],
      foto: json?[FOTO],
      dateCreated: (json?[DATE_CREATED] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ID: id,
      NAME: name,
      LOCATION: location,
      BUILDING: building,
      TYPE: type,
      DESCRIPTION: description,
      FOTO: foto,
      DATE_CREATED: dateCreated,
    };
  }

  Future<FacilityModel?> getById() async {
    return id.isEmptyOrNull
        ? null
        : await super
            .collectionReference
            .doc(id)
            .get()
            .then((value) => FacilityModel.fromSnapshot(value));
  }

  Future<FacilityModel> save({File? file, bool? isSet}) async {
    id.isEmptyOrNull
        ? id = await super.add(toJson()) ?? id
        : (isSet ?? false)
            ? super.collectionReference.doc(id).set(toJson())
            : await super.edit(toJson());
    if (file != null && !id.isEmptyOrNull) {
      foto = await super.upload(id: id, file: file);
      await super.edit(toJson());
    }
    return this;
  }

  Stream<FacilityModel> stream() {
    return super
        .collectionReference
        .doc(id)
        .snapshots()
        .map((event) => FacilityModel.fromSnapshot(event));
  }
}
