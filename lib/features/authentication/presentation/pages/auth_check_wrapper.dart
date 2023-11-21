import 'package:coin_track/features/authentication/presentation/pages/auth_page_desktop.dart';
import 'package:coin_track/features/authentication/presentation/pages/auth_page_mobile.dart';
import 'package:coin_track/features/expense_tracking/presentation/pages/desktop/home_page.dart';
import 'package:coin_track/features/expense_tracking/presentation/pages/mobile/home_page.dart';
import 'package:coin_track/features/authentication/presentation/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthCheckWrapper extends StatelessWidget {
  const AuthCheckWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final user = context.watch<AuthProvider>().user;
    return Builder(
      builder: (context) {
        if (user == null || !user.isEmailVerified) {
          return size.width <= 700
              ? const AuthPageMobile()
              : const AuthPageDesktop();
        } else {
          return size.width <= 700
              ? const HomePageMobile()
              : const HomePageDesktop();
        }
      },
    );
  }
}
