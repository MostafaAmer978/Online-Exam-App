import 'package:json_annotation/json_annotation.dart';
import 'package:online_exam_app/features/home/tabs/explore_tab/api/models/metadeta_dto.dart';
import 'package:online_exam_app/features/home/tabs/explore_tab/api/models/subject_dto.dart';

part 'subject_response.g.dart';

@JsonSerializable()
class SubjectResponse {
  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "metadata")
  final MetadataDTO? metadata;

  @JsonKey(name: "subjects")
  final List<SubjectDTO>? subjects;

  SubjectResponse({
    this.message,
    this.metadata,
    this.subjects,
  });

  factory SubjectResponse.fromJson(
    Map<String, dynamic> json,
  ) => _$SubjectResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SubjectResponseToJson(this);
}
