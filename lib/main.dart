import 'package:flutter/material.dart';
import 'package:todoapp/user/view/login_screen.dart';

void main() {
  runApp(const _App());
}

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme : ThemeData(
        fontFamily: 'SCDream',
      ),
      home: const LoginScreen(),
    );
  }
}