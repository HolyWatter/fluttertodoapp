import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/common/const/colors.dart';
import 'package:todoapp/common/layout/default_layout.dart';
import 'package:todoapp/common/todo/model/todo_model.dart';
import 'package:todoapp/common/todo/provider/todo_provider.dart';

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
      title: '오늘의 할일',
      child: cp.data.isEmpty ? 
      const Center(child: Text('아직 오늘의 할 일이 없습니다.')) : 
      ListView(
       children:  cp.data.map((e) => CheckboxListTile(
          title : Text(e.title),
          value: e.completed, 
          onChanged: (value){})).toList(),
          )
      );
  }
}