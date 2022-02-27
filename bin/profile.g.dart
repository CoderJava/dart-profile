// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile(
      id: json['id'] as int?,
      createdAt: json['created_at'] as String?,
      fullName: json['full_name'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phone_number'] as String?,
      birthDate: json['birth_date'] as String?,
    );

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt,
      'full_name': instance.fullName,
      'email': instance.email,
      'phone_number': instance.phoneNumber,
      'birth_date': instance.birthDate,
    };
