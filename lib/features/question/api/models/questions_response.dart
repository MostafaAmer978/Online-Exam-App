import 'package:json_annotation/json_annotation.dart';
import 'package:online_exam_app/features/question/api/models/question_dto.dart';

part 'questions_response.g.dart';

@JsonSerializable()
class QuestionsResponse {
  String? message;
  List<QuestionsDTO>? questions;

  QuestionsResponse({this.message, this.questions});
  factory QuestionsResponse.fromJson(
    Map<String, dynamic> json,
  ) => _$QuestionsResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$QuestionsResponseToJson(this);
}
