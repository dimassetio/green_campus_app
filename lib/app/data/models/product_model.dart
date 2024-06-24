import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:green_campus_app/app/data/helpers/database.dart';
import 'package:nb_utils/nb_utils.dart';

class ProductModel extends Database {
  static const String COLLECTION_NAME = "products";

  static const String ID = "ID";
  static const String TITLE = "TITLE";
  static const String STORE = "STORE";
  static const String PRICE = "PRICE";
  static const String IS_AVAILABLE = "IS_AVAILABLE";
  static const String DESCRIPTION = "DESCRIPTION";
  static const String FOTO = "FOTO";
  static const String DATE_CREATED = "DATE_CREATED";

  String? id;
  String? title;
  String? store;
  int? price;
  bool? isAvailable;
  String? description;
  String? foto;
  DateTime? dateCreated;

  ProductModel({
    this.id,
    this.title,
    this.store,
    this.price,
    this.isAvailable,
    this.description,
    this.foto,
    this.dateCreated,
  }) : super(
          collectionReference: firestore.collection(COLLECTION_NAME),
          storageReference: storage.ref(COLLECTION_NAME),
        );

  ProductModel.fromSnapshot(DocumentSnapshot doc)
      : id = doc.id,
        super(
          collectionReference: firestore.collection(COLLECTION_NAME),
          storageReference: storage.ref(COLLECTION_NAME),
        ) {
    var json = doc.data() as Map<String, dynamic>?;
    title = json?[TITLE];
    store = json?[STORE];
    price = json?[PRICE];
    isAvailable = json?[IS_AVAILABLE];
    description = json?[DESCRIPTION];
    foto = json?[FOTO];
    dateCreated = (json?[DATE_CREATED] as Timestamp?)?.toDate();
  }

  Map<String, dynamic> toJson() {
    return {
      ID: id,
      TITLE: title,
      STORE: store,
      PRICE: price,
      IS_AVAILABLE: isAvailable,
      DESCRIPTION: description,
      FOTO: foto,
      DATE_CREATED: dateCreated,
    };
  }

  Future<ProductModel?> getById() async {
    if (id.isEmptyOrNull) return null;

    var doc = await super.collectionReference.doc(id).get();
    return ProductModel.fromSnapshot(doc);
  }

  Future<ProductModel> save({File? file}) async {
    if (id.isEmptyOrNull) {
      id = await super.add(toJson());
    } else {
      await super.edit(toJson());
    }

    if (file != null && !id.isEmptyOrNull) {
      foto = await super.upload(id: id!, file: file);
      await super.edit(toJson());
    }

    return this;
  }

  Stream<ProductModel> stream() {
    return super
        .collectionReference
        .doc(id)
        .snapshots()
        .map((event) => ProductModel.fromSnapshot(event));
  }
}
