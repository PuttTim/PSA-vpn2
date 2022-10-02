import 'package:cloud_firestore/cloud_firestore.dart';

class EquipmentModel {
  String id;
  String model;
  String location;
  GeoPoint geoPoint;

  EquipmentModel({
    required this.id,
    required this.model,
    required this.location,
    required this.geoPoint,
  });

  EquipmentModel.fromDocument(DocumentSnapshot<Map<String, dynamic>> doc)
      : this(
          id: doc.id,
          model: doc["model"],
          location: doc["location"],
          geoPoint: doc["geopoint"],
        );

  Map<String, dynamic> toMap() {
    return {
      "model": model,
      "location": location,
      "geopoint": geoPoint,
    };
  }
}
