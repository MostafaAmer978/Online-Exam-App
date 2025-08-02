// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exams_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExamsDTO _$ExamsDTOFromJson(Map<String, dynamic> json) => ExamsDTO(
  id: json['_id'] as String?,
  title: json['title'] as String?,
  duration: (json['duration'] as num?)?.toInt(),
  subjectId: json['subjectId'] as String?,
  numberOfQuestions: (json['numberOfQuestions'] as num?)?.toInt(),
  active: json['active'] as bool?,
);

Map<String, dynamic> _$ExamsDTOToJson(ExamsDTO instance) => <String, dynamic>{
  '_id': instance.id,
  'title': instance.title,
  'duration': instance.duration,
  'subjectId': instance.subjectId,
  'numberOfQuestions': instance.numberOfQuestions,
  'active': instance.active,
};
