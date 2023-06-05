import 'package:flutter/material.dart';
import 'package:todoapp/common/const/colors.dart';
import 'package:todoapp/common/layout/default_layout.dart';
import 'package:todoapp/common/widget/custom_text_field.dart';

class AuthLayout extends StatelessWidget {
  final bool isSignup;
  const AuthLayout({super.key, required this.isSignup});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: isSignup ? "회원가입" : "로그인",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 100,),
          const Center(child: Text("Today's Todo", style: TextStyle(color : PRIMARY_COLOR, fontSize: 30, fontWeight: FontWeight.w900),)),
          const SizedBox(height: 150,),
          const CustomTextField(isPassword: false, hintText: '이메일을 입력해주세요'),
          const SizedBox(
            height: 20.0,
          ),
          const CustomTextField(isPassword: true, hintText: '패스워드를 입력해주세요'),
          const SizedBox(
            height: 20.0,
          ),
          ElevatedButton(onPressed: (){
          },style: ElevatedButton.styleFrom(
            backgroundColor: PRIMARY_COLOR
          ), child: Text(isSignup ? "회원가입" : "로그인"),),
          const SizedBox(
            height: 20.0,
          ),
           Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             Text(isSignup ? "이미 회원이신가요?" : "아직 회원이 아니신가요?"),
             TextButton(
              onPressed: (){}, 
              child: Text(isSignup ? "로그인" : "회원가입", 
              style: const TextStyle(color: BDOY_TEXT_COLOR),),),
          ],)
        ],
      ),
    );
  }
}