import 'package:json_annotation/json_annotation.dart';
import 'package:online_exam_app/features/exams/domain/entities/exams_exntity.dart';

part 'exams_dto.g.dart';

@JsonSerializable()
class ExamsDTO {
  @JsonKey(name: '_id')
  String? id;
  String? title;
  int? duration;
  String? subjectId;
  int? numberOfQuestions;
  bool? active;

  ExamsDTO({
    this.id,
    this.title,
    this.duration,
    this.subjectId,
    this.numberOfQuestions,
    this.active,
  });

  factory ExamsDTO.fromJson(Map<String, dynamic> json) =>
      _$ExamsDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ExamsDTOToJson(this);

  ExamsEntity toExamsEntity() {
    return ExamsEntity(
      id: id,
      title: title,
      duration: duration,
      subjectId: subjectId,
      numberOfQuestions: numberOfQuestions,
      active: active,
    );
  }
}
