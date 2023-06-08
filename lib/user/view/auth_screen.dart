import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/common/const/colors.dart';
import 'package:todoapp/common/layout/default_layout.dart';
import 'package:todoapp/common/secure_storage/secure_storage_provider.dart';
import 'package:todoapp/common/widget/custom_text_field.dart';
import 'package:todoapp/todo/view/todo_screen.dart';

class AuthScreen extends ConsumerStatefulWidget {

  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final dio = Dio();

  String email = '';
  String password = '';
  bool isSignup = false;

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
           CustomTextField(
            onChanged: (value) {
              email = value;
            },
            isPassword: false, 
            hintText: '이메일을 입력해주세요'),
          const SizedBox(
            height: 20.0,
          ),
          CustomTextField(
            onChanged: (value){
              password = value;
            },
            isPassword: true, 
            hintText: '패스워드를 입력해주세요'),
          const SizedBox(
            height: 20.0,
          ),
          ElevatedButton(onPressed: ()async {
            if(isSignup){
              final res = dio.post('http://localhost:4000/api/auth/signup' , data: {
                'email' : email,
                'password' : password,
              });
                setState(() {
                  isSignup = false;});

            }else{
              final res = await dio.post('http://localhost:4000/api/auth/login' , data: {
                'email' : email,
                'password' : password,
              });
              final accessToken = res.data['accessToken'];
              final refreshToken = res.data['refreshToken'];

              final storage = ref.read(secureStorageProvider);

              await storage.write(key: 'accessToken', value: accessToken);
              await storage.write(key: 'refreshToken', value: refreshToken);

              Navigator.of(context).push(MaterialPageRoute(builder: (_) => const TodoScreen()));
            }
          },
          style: ElevatedButton.styleFrom(
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
              onPressed: (){
                setState(() {
                  isSignup = !isSignup;
                });
              }, 
              child: Text(isSignup ? "로그인" : "회원가입", 
              style: const TextStyle(color: BDOY_TEXT_COLOR),),),
          ],)
        ],
      ),
    );
  }
}