// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exams_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExamsResponse _$ExamsResponseFromJson(Map<String, dynamic> json) =>
    ExamsResponse(
      exams: (json['exams'] as List<dynamic>?)
          ?.map((e) => ExamsDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String?,
      metadata: json['metadata'] == null
          ? null
          : MetadataDTO.fromJson(json['metadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ExamsResponseToJson(ExamsResponse instance) =>
    <String, dynamic>{
      'exams': instance.exams,
      'metadata': instance.metadata,
      'message': instance.message,
    };
