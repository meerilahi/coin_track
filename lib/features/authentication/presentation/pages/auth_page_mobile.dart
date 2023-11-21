import 'package:coin_track/features/authentication/presentation/pages/email_verfication_view.dart';
import 'package:coin_track/features/authentication/presentation/pages/signin_view.dart';
import 'package:coin_track/features/authentication/presentation/pages/signup_view.dart';
import 'package:coin_track/features/authentication/presentation/provider/auth_provider.dart';
import 'package:coin_track/features/authentication/presentation/widgets/custom_painter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthPageMobile extends StatelessWidget {
  const AuthPageMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: 0,
              child: CustomPaint(
                size: Size(size.width, size.height * 0.1),
                painter: AuthMobilePagePainter1(),
              ),
            ),
            Positioned(
              bottom: 0,
              child: CustomPaint(
                size: Size(size.width, size.height * 0.1),
                painter: AuthMobilePagePainter2(),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Consumer<AuthProvider>(
                  builder: (context, value, child) {
                    switch (value.pageState) {
                      case AuthPageState.signinView:
                        return SigninView();
                      case AuthPageState.signupView:
                        return SignupView();
                      case AuthPageState.emailVerificationView:
                        return const EmailVerficationView();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
