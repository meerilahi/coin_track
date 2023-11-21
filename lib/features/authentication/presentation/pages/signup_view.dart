import 'package:coin_track/features/authentication/presentation/provider/auth_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final _formKey = GlobalKey<FormState>();

class SignupView extends StatelessWidget {
  SignupView({super.key});
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();

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
            controller: _emailController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              label: Text("Email"),
              prefixIcon: Icon(Icons.email),
            ),
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
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              label: Text("Password"),
              prefixIcon: Icon(Icons.lock),
            ),
            validator: (password) {
              if (password != null && password.length >= 6) {
                return null;
              }
              return "Password must be of at least 6 characters";
            },
          ),
          const Spacer(flex: 1),
          TextFormField(
            controller: _passwordConfirmController,
            obscureText: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              label: Text("Re-enter Password"),
              prefixIcon: Icon(Icons.lock),
            ),
            validator: (password) {
              if (password == _passwordController.text) {
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
                  await context.read<AuthProvider>().signUpWithEmailAndPassword(
                      _emailController.text, _passwordController.text);
                } catch (_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Sign up failed")),
                  );
                }
              }
            },
            child: Text("Sign up"),
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
