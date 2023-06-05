import 'package:flutter/src/widgets/framework.dart';
import 'package:todoapp/user/widget/auth_layout.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AuthLayout(isSignup: true);
  }
}