import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:portfix_mobile/data/users/UserModal.dart';
import 'package:portfix_mobile/data/users/user_dao.dart';

class UserDaoImpl implements UserDao {
  UserDaoImpl._();
  static final UserDaoImpl _impl = UserDaoImpl._();
  factory UserDaoImpl.getInstance() => _impl;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collectionPath = "users";

  @override
  Future<UserModal> getUser(String id) async {
    var userDocument = await _firestore
        .collection(
          collectionPath,
        )
        .doc(id)
        .get();
    if (!userDocument.exists ||
        userDocument.data() == null ||
        userDocument.data()?.containsKey("email") == false ||
        userDocument.data()?.containsKey("name") == false) {
      return Future.error(
        "Your account has not been added yet."
        "Please check with your superiors if you still cannot access this application by a day.",
      );
    }
    return UserModal.fromDocument(userDocument);
  }
}
