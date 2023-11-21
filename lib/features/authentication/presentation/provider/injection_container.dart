import 'package:coin_track/features/authentication/data/firebase_auth_repository.dart';
import 'package:coin_track/features/authentication/domain/auth_repository.dart';
import 'package:coin_track/features/authentication/domain/auth_use_cases.dart';
import 'package:get_it/get_it.dart';

final gt = GetIt.instance;

Future<void> initializeAuthDependencies() async {
  gt.registerSingleton<AuthRepository>(FirebaseAuthRepository());
  gt.registerSingleton<SignInUseCase>(SignInUseCase(gt()));
  gt.registerSingleton<SignUpUseCase>(SignUpUseCase(gt()));
  gt.registerSingleton<SignOutUseCase>(SignOutUseCase(gt()));
  gt.registerSingleton<SendVerificationEmailUseCase>(
      SendVerificationEmailUseCase(gt()));
  gt.registerSingleton<GetUserUseCase>(GetUserUseCase(gt()));
}
