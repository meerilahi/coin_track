import 'package:coin_track/features/authentication/presentation/provider/auth_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final _formKey = GlobalKey<FormState>();

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 8),
          Text(
            "Sign Up",
            style: TextStyle(
              fontSize: 34,
              color: Colors.cyan.shade900,
            ),
          ),
          const Spacer(flex: 3),
          TextFormField(
            initialValue: context.read<AuthProvider>().email,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              label: Text("Email"),
              prefixIcon: Icon(Icons.email),
            ),
            onChanged: (value) {
              context.read<AuthProvider>().email = value;
            },
            validator: (email) {
              if (email != null &&
                  email.contains("@gmail.com") &&
                  email.length >= 15) {
                return null;
              }
              return "Invalid email";
            },
          ),
          const Spacer(flex: 1),
          TextFormField(
            initialValue: context.read<AuthProvider>().password,
            obscureText: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              label: Text("Password"),
              prefixIcon: Icon(Icons.lock),
            ),
            onChanged: (value) {
              context.read<AuthProvider>().password = value;
            },
            validator: (password) {
              if (password != null && password.length >= 6) {
                return null;
              }
              return "Password must be of at least 6 characters";
            },
          ),
          const Spacer(flex: 1),
          TextFormField(
            initialValue: context.read<AuthProvider>().confirmPassword,
            obscureText: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              label: Text("Re-enter Password"),
              prefixIcon: Icon(Icons.lock),
            ),
            onChanged: (value) {
              context.read<AuthProvider>().confirmPassword = value;
            },
            validator: (password) {
              if (password == context.read<AuthProvider>().password) {
                return null;
              }
              return "Password not matched";
            },
          ),
          const Spacer(flex: 2),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                try {
                  final email = context.read<AuthProvider>().email;
                  final password = context.read<AuthProvider>().password;
                  await context
                      .read<AuthProvider>()
                      .signUpWithEmailAndPassword(email, password);
                } catch (_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Sign up failed")),
                  );
                }
              }
            },
            child: const Text("Sign up"),
          ),
          const Spacer(flex: 2),
          RichText(
            text: TextSpan(
              text: "Already have an account ? ",
              style: const TextStyle(color: Colors.black),
              children: [
                TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      context
                          .read<AuthProvider>()
                          .changeView(AuthPageState.signinView);
                    },
                  text: "Sign in",
                  style: TextStyle(
                      color: Colors.cyan.shade900, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          const Spacer(flex: 8),
        ],
      ),
    );
  }
}
