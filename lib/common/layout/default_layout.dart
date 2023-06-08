import 'package:flutter/material.dart';
import 'package:todoapp/common/const/colors.dart';

class DefaultLayout extends StatelessWidget {
  final Color ? backgroundColor;
  final Widget child;
  final String ? title;
  final FloatingActionButton ? floatingActionButton;
  final List<Widget> ? actions;

  const DefaultLayout({super.key, this.backgroundColor, required this.child, this.title, this.floatingActionButton, this.actions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.white,
      appBar: renderAppbar(),
      body : Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: child),
        floatingActionButton: floatingActionButton,
    );
  }
  AppBar ? renderAppbar(){
  if(title == null){
    return null;
  }
  return AppBar(
    backgroundColor: Colors.white,
    actions: actions,
    elevation: 0,
    title : Text(title! , style: const TextStyle(fontWeight: FontWeight.w600, color: BDOY_TEXT_COLOR),)
  );
}
}

