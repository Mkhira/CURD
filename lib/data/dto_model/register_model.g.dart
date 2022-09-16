// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterModel _$RegisterModelFromJson(Map<String, dynamic> json) =>
    RegisterModel(
      email: json['email'] as String?,
      name: json['name'] == null
          ? null
          : Name.fromJson(json['name'] as Map<String, dynamic>),
      password: json['password'] as String?,
      confirmPassword: json['confirmPassword'] as String?,
      role: $enumDecodeNullable(_$UserTypeEnumMap, json['role']),
    );

Map<String, dynamic> _$RegisterModelToJson(RegisterModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'name': instance.name?.toJson(),
      'password': instance.password,
      'confirmPassword': instance.confirmPassword,
      'role': _$UserTypeEnumMap[instance.role],
    };

const _$UserTypeEnumMap = {
  UserType.user: 'user',
  UserType.admin: 'admin',
};

Name _$NameFromJson(Map<String, dynamic> json) => Name(
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
    );

Map<String, dynamic> _$NameToJson(Name instance) => <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
    };
