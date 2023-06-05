import 'package:flutter/material.dart';
import 'package:todoapp/user/widget/auth_layout.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
  

    return const AuthLayout(isSignup: false);
  }
}