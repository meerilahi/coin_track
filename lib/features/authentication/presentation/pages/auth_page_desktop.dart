import 'package:coin_track/features/authentication/presentation/pages/email_verfication_view.dart';
import 'package:coin_track/features/authentication/presentation/pages/signin_view.dart';
import 'package:coin_track/features/authentication/presentation/pages/signup_view.dart';
import 'package:coin_track/features/authentication/presentation/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthPageDesktop extends StatelessWidget {
  const AuthPageDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: RadialGradient(colors: [
            Colors.cyanAccent.shade100,
            Colors.cyanAccent,
            Colors.cyan.shade600,
          ], radius: 0.8)),
          child: Center(
            child: Card(
              elevation: 10,
              child: Container(
                width:
                    size.width < 1300 ? (size.width * 0.7) : (size.width * 0.5),
                height: size.height * 0.7,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                          color: Colors.cyan,
                          borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(10)),
                        ),
                        child: const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Welcome to Coin Track",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 36),
                              ),
                              Text(
                                "Track your personal Expenses",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 22),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
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
            ),
          ),
        ),
      ),
    );
  }
}
