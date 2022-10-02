import 'package:cloud_firestore/cloud_firestore.dart';

class EngineerModal {
  String id;
  String name;
  String email;

  EngineerModal({
    required this.id,
    required this.name,
    required this.email,
  });

  EngineerModal.fromDocument(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) : this(
          id: doc.id,
          name: doc["name"],
          email: doc["email"],
        );
}
