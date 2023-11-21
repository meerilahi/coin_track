import 'package:coin_track/features/authentication/domain/auth_repository.dart';
import 'package:coin_track/features/authentication/domain/auth_user_entity.dart';

class SignInUseCase {
  final AuthRepository _repository;
  SignInUseCase(this._repository);
  Future<AuthUserEntity?> call(String email, String password) async {
    return await _repository.signInWithEmailAndPassword(email, password);
  }
}

class SignUpUseCase {
  final AuthRepository _repository;
  SignUpUseCase(this._repository);
  Future<AuthUserEntity?> call(String email, String password) async {
    return await _repository.signUpWithEmailAndPassword(email, password);
  }
}

class SignOutUseCase {
  final AuthRepository _repository;
  SignOutUseCase(this._repository);
  Future<void> call() async {
    return await _repository.signOut();
  }
}

class SendVerificationEmailUseCase {
  final AuthRepository _repository;
  SendVerificationEmailUseCase(this._repository);
  Future<void> call() async {
    return await _repository.sendEmailVerification();
  }
}

class GetUserUseCase {
  final AuthRepository _repository;
  GetUserUseCase(this._repository);
  AuthUserEntity? call() => _repository.currentUser;
}
