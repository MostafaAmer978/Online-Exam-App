// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionsDTO _$QuestionsDTOFromJson(Map<String, dynamic> json) => QuestionsDTO(
  answers: (json['answers'] as List<dynamic>?)
      ?.map((e) => AnswersDTO.fromJson(e as Map<String, dynamic>))
      .toList(),
  type: json['type'] as String?,
  id: json['_id'] as String?,
  question: json['question'] as String?,
  correct: json['correct'] as String?,
  subject: json['subject'] == null
      ? null
      : SubjectDTO.fromJson(json['subject'] as Map<String, dynamic>),
  exam: json['exam'] == null
      ? null
      : ExamsDTO.fromJson(json['exam'] as Map<String, dynamic>),
);

Map<String, dynamic> _$QuestionsDTOToJson(QuestionsDTO instance) =>
    <String, dynamic>{
      'answers': instance.answers,
      'type': instance.type,
      '_id': instance.id,
      'question': instance.question,
      'correct': instance.correct,
      'subject': instance.subject,
      'exam': instance.exam,
    };
