import 'package:cloud_firestore/cloud_firestore.dart';

class UserModal {
  String id;
  String email;
  String name;

  UserModal({
    required this.id,
    required this.email,
    required this.name,
  });

  UserModal.fromDocument(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : this(
          id: snapshot.id,
          email: snapshot["email"] ?? "",
          name: snapshot["name"] ?? "",
        );

  Map<String, String> toMap() {
    return {
      "email": email,
      "name": name,
    };
  }
}
