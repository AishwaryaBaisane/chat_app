import 'package:chat_app/services/auth_aervices/auth_services.dart';
import 'package:chat_app/view/auth/Sign_in/sign_in.dart';
import 'package:chat_app/view/home/home_page.dart';
import 'package:flutter/material.dart';

class AuthManager extends StatelessWidget {
  const AuthManager({super.key});

  @override
  Widget build(BuildContext context) {
    return (AuthService.authService.getCurrentUser() == null)
        ? const SignIn()
        : const HomePage();
  }
}
