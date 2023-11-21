import 'package:coin_track/features/authentication/data/auth_user_model.dart';
import 'package:coin_track/features/authentication/domain/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthRepository implements AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<AuthUserModel?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return AuthUserModel.fromFirebaseUser(userCredential.user);
    } catch (_) {
      throw Exception();
    }
  }

  @override
  Future<AuthUserModel?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return AuthUserModel.fromFirebaseUser(userCredential.user);
    } catch (_) {
      throw Exception();
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (_) {
      throw Exception();
    }
  }

  @override
  Future<void> sendEmailVerification() async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception();
    }
    user.sendEmailVerification();
  }

  @override
  AuthUserModel? get currentUser =>
      AuthUserModel.fromFirebaseUser(_auth.currentUser);

}
