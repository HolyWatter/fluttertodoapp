import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  final Color ? backgroundColor;
  final Widget child;
  final String ? title;

  const DefaultLayout({super.key, this.backgroundColor, required this.child, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.white,
      appBar: renderAppbar(),
      body : Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: child)
    );
  }
  AppBar ? renderAppbar(){
  if(title == null){
    return null;
  }
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    title : Text(title! , style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black),)
  );
}
}

