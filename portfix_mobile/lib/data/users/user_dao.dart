import 'package:portfix_mobile/data/users/UserModal.dart';

abstract class UserDao {
  Future<UserModal> getUser(String id);
}
