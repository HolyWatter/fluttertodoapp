import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String id;
  final String email;
  final String password;
  final String createdDate;

  UserModel({
    required this.email,
    required this.id,
    required this.password,
    required this.createdDate
  });

  factory UserModel.fromJson(Map<String, dynamic> json)
  => _$UserModelFromJson(json);
}