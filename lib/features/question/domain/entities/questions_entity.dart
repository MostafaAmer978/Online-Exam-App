import 'package:online_exam_app/features/exams/domain/entities/exams_exntity.dart';
import 'package:online_exam_app/features/home/tabs/explore_tab/domain/entities/subjects_entity.dart';
import 'package:online_exam_app/features/question/domain/entities/answer_entity.dart';

class QuestionsEntity {
  List<AnswersEntity>? answers;
  String? type;

  String? id;
  String? question;
  String? correct;
  SubjectsEntity? subject;
  ExamsEntity? exam;

  QuestionsEntity({
    this.answers,
    this.type,
    this.id,
    this.question,
    this.correct,
    this.subject,
    this.exam,
  });
}
