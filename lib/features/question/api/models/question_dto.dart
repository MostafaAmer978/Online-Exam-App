import 'package:json_annotation/json_annotation.dart';
import 'package:online_exam_app/features/exams/api/models/exams_dto.dart';
import 'package:online_exam_app/features/home/tabs/explore_tab/api/models/subject_dto.dart';
import 'package:online_exam_app/features/question/api/models/answars_dto.dart';
import 'package:online_exam_app/features/question/domain/entities/questions_entity.dart';

part 'question_dto.g.dart';

@JsonSerializable()
class QuestionsDTO {
  List<AnswersDTO>? answers;
  String? type;
  @JsonKey(name: '_id')
  String? id;
  String? question;
  String? correct;
  SubjectDTO? subject;
  ExamsDTO? exam;

  QuestionsDTO({
    this.answers,
    this.type,
    this.id,
    this.question,
    this.correct,
    this.subject,
    this.exam,
  });
  factory QuestionsDTO.fromJson(
    Map<String, dynamic> json,
  ) => _$QuestionsDTOFromJson(json);
  Map<String, dynamic> toJson() =>
      _$QuestionsDTOToJson(this);
  QuestionsEntity toQuestionsEntity() {
    return QuestionsEntity(
      id: id,
      answers: answers
          ?.map((e) => e.toAnswersEntity())
          .toList(),
      correct: correct,
      exam: exam?.toExamsEntity(),
      question: question,
      subject: subject?.toSubjectsEntity(),
      type: type,
    );
  }
}
