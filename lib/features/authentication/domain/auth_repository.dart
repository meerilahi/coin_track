import 'package:coin_track/features/authentication/domain/auth_user_entity.dart';

abstract class AuthRepository {
  Future<AuthUserEntity?> signInWithEmailAndPassword(
      String email, String password);
  Future<AuthUserEntity?> signUpWithEmailAndPassword(
      String email, String password);
  Future<void> signOut();
  Future<void> sendEmailVerification();
  AuthUserEntity? get currentUser;
}
