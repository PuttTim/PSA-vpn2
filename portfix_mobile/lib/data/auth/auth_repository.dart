import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  AuthRepository._();
  static final AuthRepository _authRepository = AuthRepository._();
  factory AuthRepository.getInstance() => _authRepository;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? getCurrentUser() => _firebaseAuth.currentUser;

  Stream<User?> getAuthStateChanges() {
    return _firebaseAuth.authStateChanges();
  }

  Future<UserCredential> login(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> sendPasswordResetLink(String email) {
    return _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> logOut() => _firebaseAuth.signOut();
}
