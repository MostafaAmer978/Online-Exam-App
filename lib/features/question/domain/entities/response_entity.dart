import 'package:online_exam_app/features/question/domain/entities/questions_entity.dart';

class QuestionsResponseEntity {
  String? message;
  List<QuestionsEntity>? questions;

  QuestionsResponseEntity({this.message, this.questions});
}
