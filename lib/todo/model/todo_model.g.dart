// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodoModel _$TodoModelFromJson(Map<String, dynamic> json) => TodoModel(
      id: json['id'] as String,
      title: json['title'] as String,
      completed: json['completed'] as bool,
      createdDate: json['createdDate'] as String,
      createdById: json['createdById'] as String,
      createdBy: UserModel.fromJson(json['createdBy'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TodoModelToJson(TodoModel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'completed': instance.completed,
      'createdDate': instance.createdDate,
      'createdById': instance.createdById,
      'createdBy': instance.createdBy,
    };

TodoModelList _$TodoModelListFromJson(Map<String, dynamic> json) =>
    TodoModelList(
      data: (json['data'] as List<dynamic>)
          .map((e) => TodoModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TodoModelListToJson(TodoModelList instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
