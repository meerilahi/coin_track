import 'package:coin_track/features/authentication/domain/auth_user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthUserModel extends AuthUserEntity {
  AuthUserModel({
    required super.isEmailVerified,
    required super.email,
    required super.userId,
  });
  static AuthUserModel? fromFirebaseUser(User? user) => user != null
      ? AuthUserModel(
          isEmailVerified: user.emailVerified,
          email: user.email,
          userId: user.uid,
        )
      : null;
}
