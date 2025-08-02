import 'package:json_annotation/json_annotation.dart';
import 'package:online_exam_app/features/question/domain/entities/answer_entity.dart';

part 'answars_dto.g.dart';

@JsonSerializable()
class AnswersDTO {
  String? answer;
  String? key;
  AnswersDTO({this.answer, this.key});
  factory AnswersDTO.fromJson(
    Map<String, dynamic> json,
  ) => _$AnswersDTOFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AnswersDTOToJson(this);

  AnswersEntity toAnswersEntity() {
    return AnswersEntity(answer: answer, key: key);
  }
}
