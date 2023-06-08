import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/common/const/colors.dart';
import 'package:todoapp/common/dio/dio.dart';
import 'package:todoapp/common/layout/default_layout.dart';
import 'package:todoapp/common/secure_storage/secure_storage_provider.dart';
import 'package:todoapp/common/view/splash_screen.dart';
import 'package:todoapp/todo/model/todo_model.dart';
import 'package:todoapp/todo/provider/todo_provider.dart';
import 'package:todoapp/todo/view/todo_add_screen.dart';

class TodoScreen extends ConsumerStatefulWidget {
  const TodoScreen({super.key});

  @override
  ConsumerState<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends ConsumerState<TodoScreen> {
  @override
  Widget build(BuildContext context) {
    final data = ref.watch(todoProvider);

    if(data is GetTodoStatusModelLoading){
      return const DefaultLayout(child: Center(child: CircularProgressIndicator(color: PRIMARY_COLOR,),));
    }

    if(data is GetTodoStatusModelError){
      return DefaultLayout(child: Center(child: Text(data.toString()),));
    }
    
   final cp = data as TodoModelList;

    return DefaultLayout(
      actions: [PopupMenuButton(itemBuilder: (_){
        return [
          PopupMenuItem(child: const Text('로그아웃'), onTap: () async {
          final storage = ref.read(secureStorageProvider);

          await storage.delete(key: 'accessToken');
          await storage.delete(key: 'refreshToken');

          Navigator.of(context).push(MaterialPageRoute(builder: (_)=> const SplashScreen()));
        },),
          
        ];
      },
      child: const Icon(Icons.more),)],
      title: '오늘의 할일',
       floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (_)=> const TodoAddScreen()));
        },
        backgroundColor: PRIMARY_COLOR, 
        child: const Icon(Icons.add_rounded),),
      child: cp.data.isEmpty ? 
      const Center(child: Text('아직 오늘의 할 일이 없습니다.')) : 
      ListView(
        children: cp.data.map((e) => CheckboxListTile(
          title : Text(e.title),
          value: e.completed, 
          onChanged: (value)async {
           try{
             final dio = ref.watch(dioProvider);
            await dio.patch('http://localhost:4000/api/todo/${e.id}' ,options: Options(
              headers: {
                'accessToken' : 'true',
              }
            ),
            data: {
              'title' : e.title,
              'completed' : !e.completed
            },
            );
            ref.read(todoProvider.notifier).get();
           }
           catch(e){
            print(e);
           }
          }
          )).toList(),
       ),
       );
  }
}