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

  final UserInputs _userInputs = UserInputs(
    email: "",
    password: "",
    confirmPassword: "",
  );
  set email(newEmail) {
    _userInputs.email = newEmail;
  }

  set password(newPasword) {
    _userInputs.password = newPasword;
  }

  set confirmPassword(newConfirmPassword) {
    _userInputs.confirmPassword = newConfirmPassword;
  }

  get email => _userInputs.email;
  get password => _userInputs.password;
  get confirmPassword => _userInputs.confirmPassword;

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
    email = "";
    password = "";
    confirmPassword = "";
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

class UserInputs {
  String email;
  String password;
  String confirmPassword;
  UserInputs({
    required this.email,
    required this.password,
    required this.confirmPassword,
  });
}
