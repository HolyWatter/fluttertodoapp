import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/common/const/colors.dart';
import 'package:todoapp/common/dio/dio.dart';
import 'package:todoapp/common/layout/default_layout.dart';
import 'package:todoapp/common/widget/custom_text_field.dart';
import 'package:todoapp/todo/provider/todo_provider.dart';
import 'package:todoapp/todo/view/todo_screen.dart';

class TodoAddScreen extends ConsumerStatefulWidget {
  const TodoAddScreen({super.key});

  @override
  ConsumerState<TodoAddScreen> createState() => _TodoAddScreenState();
}

class _TodoAddScreenState extends ConsumerState<TodoAddScreen> {
  String todoTitle = '';

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: "오늘의 할일",
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomTextField(
            onChanged: (value){
                todoTitle = value;  
            },
            isPassword: false, 
            hintText: '오늘의 할일을 추가하세요'),
          ElevatedButton(
            onPressed: ()async{
              final dio = ref.read(dioProvider);

              await dio.post('http://localhost:4000/api/todo' ,options: Options(
                headers: {
                  'accessToken' : 'true'
                }
              ) ,
              data: {
                'title' :todoTitle,
                'completed' : false,
              }
              );
              ref.read(todoProvider.notifier).get();

              Navigator.of(context).push(MaterialPageRoute(builder: (_) => const TodoScreen()));
            },
           style: ElevatedButton.styleFrom(
            backgroundColor: PRIMARY_COLOR
           ), 
            child: const Text('작성하기'),
            ),
        ],
      ));
  }
}