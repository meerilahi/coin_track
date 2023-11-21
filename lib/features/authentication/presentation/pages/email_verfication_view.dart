import 'package:coin_track/features/authentication/presentation/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmailVerficationView extends StatelessWidget {
  const EmailVerficationView({super.key});

  @override
  Widget build(BuildContext context) {
    final email = context.watch<AuthProvider>().user!.email;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(flex: 7),
        Text(
          "Verify Your Email !",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.cyan.shade900,
            fontSize: 34,
          ),
        ),
        const Spacer(flex: 2),
        Text(
          "Verification email has been send to you $email. Please verify you email by clicking at link in email and sign in again.",
          textAlign: TextAlign.center,
          style: const TextStyle(),
        ),
        const Spacer(flex: 1),
        const Text(
          "If you don't recieve email, click to resend .",
        ),
        const Spacer(flex: 1),
        ElevatedButton(
            onPressed: () async {
              await context.read<AuthProvider>().sendVerificationEmail();
            },
            child: Text("Resend")),
        const Spacer(flex: 1),
        TextButton(
          onPressed: () {
            context.read<AuthProvider>().changeView(AuthPageState.signinView);
          },
          child: Text("Sign in"),
        ),
        const Spacer(flex: 8),
      ],
    );
  }
}
