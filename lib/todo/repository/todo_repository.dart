import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/common/dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:todoapp/todo/model/todo_model.dart';

part 'todo_repository.g.dart';

final todoRepositoryProvider = Provider<TodoRepository>((ref){
  final dio = ref.watch(dioProvider);

  final repository = TodoRepository(dio, baseUrl : 'http://localhost:4000/api/todo');

  return repository;
});

@RestApi()
abstract class TodoRepository{

  factory TodoRepository(Dio dio, {String baseUrl})
  = _TodoRepository;

  @GET('/')
  @Headers({
    'accessToken' : 'true'
  })
  Future<TodoModelList> getTodo();
}