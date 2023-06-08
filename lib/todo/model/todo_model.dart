import 'package:json_annotation/json_annotation.dart';
import 'package:todoapp/user/model/user_model.dart';

part 'todo_model.g.dart';

abstract class GetTodoStatusModel {}

class GetTodoStatusModelError extends GetTodoStatusModel {
  final String message;

  GetTodoStatusModelError({
    required this.message
  });
}

class GetTodoStatusModelLoading extends GetTodoStatusModel {}

@JsonSerializable()
class TodoModel extends GetTodoStatusModel{
  final String id;
  final String title;
  final bool completed;
  final String createdDate;
  final String createdById;
  final UserModel createdBy;

  TodoModel({
    required this.id,
    required this.title,
    required this.completed,
    required this.createdDate,
    required this.createdById,
    required this.createdBy});

     factory TodoModel.fromJson(Map<String, dynamic> json)
    => _$TodoModelFromJson(json);
}

@JsonSerializable()
class TodoModelList extends GetTodoStatusModel{
  final List<TodoModel> data;

  TodoModelList({
    required this.data
  });

   factory TodoModelList.fromJson(Map<String, dynamic> json)
    => _$TodoModelListFromJson(json);
}