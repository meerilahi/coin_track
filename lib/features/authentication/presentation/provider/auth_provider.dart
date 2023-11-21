// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:coin_track/features/authentication/domain/auth_use_cases.dart';
import 'package:coin_track/features/authentication/domain/auth_user_entity.dart';

enum AuthPageState {
  signinView,
  signupView,
  emailVerificationView,
}

class AuthProvider extends ChangeNotifier {
  final SignInUseCase _signInUseCase;
  final SignUpUseCase _signUpUseCase;
  final SignOutUseCase _signOutUseCase;
  final SendVerificationEmailUseCase _sendVerificationEmailUseCase;
  final GetUserUseCase _getUserUseCase;

  AuthProvider(
    this._signInUseCase,
    this._signUpUseCase,
    this._signOutUseCase,
    this._sendVerificationEmailUseCase,
    this._getUserUseCase,
  ) {
    _user = _getUserUseCase();
  }

  AuthPageState _pageState = AuthPageState.signinView;
  AuthUserEntity? _user;

  AuthPageState get pageState => _pageState;
  AuthUserEntity? get user => _user;

  set user(newUser) {
    _user = newUser;
    if (user != null && !user!.isEmailVerified) {
      _pageState = AuthPageState.emailVerificationView;
    }
    notifyListeners();
  }

  void changeView(AuthPageState view) {
    _pageState = view;
    notifyListeners();
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    user = await _signInUseCase(email, password);
  }

  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    user = await _signUpUseCase(email, password);
    await sendVerificationEmail();
  }

  Future<void> singOut() async {
    await _signOutUseCase();
    user = null;
  }

  Future<void> sendVerificationEmail() async {
    await _sendVerificationEmailUseCase();
  }
}
