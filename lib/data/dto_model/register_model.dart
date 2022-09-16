import 'package:json_annotation/json_annotation.dart';

part 'register_model.g.dart';

@JsonSerializable(explicitToJson: true)
class RegisterModel {
  final String? email;
  final Name? name;
  final String? password;
  final String? confirmPassword;
  final UserType? role;

  RegisterModel({this.email, this.name, this.password, this.confirmPassword, this.role});
  factory RegisterModel.fromJson(Map<String, dynamic> json) => _$RegisterModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterModelToJson(this);
}

@JsonSerializable()
class Name {
  final String? firstName;
  final String? lastName;

  Name({this.firstName, this.lastName});
  factory Name.fromJson(Map<String, dynamic> json) => _$NameFromJson(json);

  Map<String, dynamic> toJson() => _$NameToJson(this);
}

enum UserType { user, admin }
