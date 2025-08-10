// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubjectDTO _$SubjectDTOFromJson(Map<String, dynamic> json) => SubjectDTO(
  id: json['_id'] as String?,
  name: json['name'] as String?,
  icon: json['icon'] as String?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$SubjectDTOToJson(SubjectDTO instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'icon': instance.icon,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
