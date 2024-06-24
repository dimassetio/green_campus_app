import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:green_campus_app/app/data/helpers/database.dart';
import 'package:nb_utils/nb_utils.dart';

class UserModel extends Database {
  static const String COLLECTION_NAME = "users";

  static const String ID = "ID";
  static const String NUMBER_ID = "NUMBER_ID";
  static const String ROLE = "ROLE";
  static const String NAME = "NAME";
  static const String PHONE = "PHONE";
  static const String EMAIL = "EMAIL";
  static const String FACULTY = "FACULTY";
  static const String GP = "GP";
  static const String FOTO = "FOTO";
  static const String IS_ACTIVE = "IS_ACTIVE";

  String? id;
  String? numberId;
  String? role;
  String? email;
  String? name;
  String? phone;
  String? faculty;
  int? gp;
  String? foto;
  bool? isActive;

  UserModel({
    this.id,
    this.numberId,
    this.role,
    this.email,
    this.name,
    this.phone,
    this.faculty,
    this.gp,
    this.foto,
    this.isActive,
  }) : super(
          collectionReference: firestore.collection(COLLECTION_NAME),
          storageReference: storage.ref(COLLECTION_NAME),
        );

  // UserModel.fromSnapshot(String? id, Map<String, dynamic> json)
  UserModel.fromSnapshot(DocumentSnapshot doc)
      : id = doc.id,
        super(
            collectionReference: firestore.collection(COLLECTION_NAME),
            storageReference: storage.ref(COLLECTION_NAME)) {
    var json = doc.data() as Map<String, dynamic>?;
    role = json?[ROLE];
    email = json?[EMAIL];
    name = json?[NAME];
    phone = json?[PHONE];
    faculty = json?[FACULTY];
    gp = json?[GP];
    foto = json?[FOTO];
    isActive = json?[IS_ACTIVE];
    numberId = json?[NUMBER_ID];
  }

  Map<String, dynamic> toJson() {
    return {
      ID: id,
      NUMBER_ID: numberId,
      ROLE: role,
      EMAIL: email,
      NAME: name,
      PHONE: phone,
      FACULTY: faculty,
      GP: gp,
      FOTO: foto,
      IS_ACTIVE: isActive,
    };
  }

  bool hasRole(String value) => role == value;

  bool hasRoles(List<String> value) => value.contains(role);

  Future<UserModel> save({File? file, bool? isSet}) async {
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

  Future updatePoint(int point) async {
    return await super.edit({ID: id, GP: point});
  }

  Future<UserModel?> getUser() async {
    return id.isEmptyOrNull
        ? null
        : UserModel.fromSnapshot(await super.getID(id!));
  }

  Stream<UserModel> stream() {
    return super
        .collectionReference
        .doc(id)
        .snapshots()
        .map((event) => UserModel.fromSnapshot(event));
  }

  Stream<UserModel> streamByUid(pUid) {
    return super
        .collectionReference
        .doc(pUid)
        .snapshots()
        .map((event) => UserModel.fromSnapshot(event));
  }
}

abstract class Role {
  static const administrator = 'Administrator';
  static const user = 'User';
  static const rentalStaff = 'Rental Staff';
  static const storeStaff = 'Store Staff';
  // static const hrd = 'HRD';
  // static const employee = 'Employee';

  static const list = [administrator, user];
  // static const list = [magang, administrator, mentor, hrd, employee];
}
