import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/common/const/colors.dart';
import 'package:todoapp/common/layout/default_layout.dart';
import 'package:todoapp/common/secure_storage/secure_storage_provider.dart';
import 'package:todoapp/todo/view/todo_screen.dart';
import 'package:todoapp/user/view/auth_screen.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();

    checkToken();
  }

  void checkToken () async {
    final storage = ref.read(secureStorageProvider);

    final dio = Dio();

    final refreshToken = await storage.read(key: 'refreshToken');
    if(refreshToken == null){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_)=> const AuthScreen()), (route) => false);
    }
    else{
try {
      print(1);
      final res = await dio.post('http://localhost:4000/api/auth/token', options: Options(
        headers: {
          'authorization' : refreshToken
        }
      ));
      final accessToken = res.data['accessToken'];
      await storage.write(key: 'accessToken', value: accessToken);

      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_)=> const TodoScreen()), (route) => false);
    }
    catch(e){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_)=> const AuthScreen()), (route) => false);
    }   
    }
  }

  @override
  Widget build(BuildContext context) {

    return DefaultLayout(
      backgroundColor : PRIMARY_COLOR,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: const [
        Center(
          child: Text("Today's Todo", 
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700, color: Colors.white),)),
        CircularProgressIndicator(color: Colors.white,)
      ],));
  }
}