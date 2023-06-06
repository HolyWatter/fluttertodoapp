import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/common/todo/model/todo_model.dart';
import 'package:todoapp/common/todo/repository/todo_repository.dart';

final todoProvider = StateNotifierProvider<TodoStateNotifier, GetTodoStatusModel>((ref){
  final repository = ref.watch(todoRepositoryProvider);

  final notifier = TodoStateNotifier(repository: repository);

  return notifier;
});

class TodoStateNotifier extends StateNotifier<GetTodoStatusModel> {
  final TodoRepository repository;

  TodoStateNotifier({
    required this.repository
  }) : super(GetTodoStatusModelLoading()){
    get();
  }

  void get()async{
    try{
      final data = await repository.getTodo();
      state = data;
    }
    catch(e){
      state = GetTodoStatusModelError(message: e.toString());
    }
  }
}