import 'package:coin_track/features/authentication/presentation/provider/auth_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final _formKey = GlobalKey<FormState>();

class SigninView extends StatelessWidget {
  SigninView({super.key});
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 8),
          Text(
            "Sign in",
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
              if (password != null && password.isNotEmpty) {
                return null;
              }
              return "Please enter password";
            },
          ),
          const Spacer(flex: 1),
          Align(
            alignment: Alignment.centerRight,
            child: RichText(
              text: TextSpan(
                text: "Forgot Password ?",
                style: const TextStyle(color: Colors.red),
                recognizer: TapGestureRecognizer()..onTap = () {},
              ),
            ),
          ),
          const Spacer(flex: 1),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                try {
                  await context.read<AuthProvider>().signInWithEmailAndPassword(
                      _emailController.text, _passwordController.text);
                } catch (_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Sign in failed")),
                  );
                }
              }
            },
            child: Text("Sign in"),
          ),
          const Spacer(flex: 2),
          RichText(
            text: TextSpan(
              text: "Don't have an account ? ",
              style: TextStyle(color: Colors.black),
              children: [
                TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      context
                          .read<AuthProvider>()
                          .changeView(AuthPageState.signupView);
                    },
                  text: "Sign up",
                  style: TextStyle(
                    color: Colors.cyan.shade900,
                    fontWeight: FontWeight.bold,
                  ),
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
