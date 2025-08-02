import 'package:json_annotation/json_annotation.dart';
import 'package:online_exam_app/features/exams/api/models/exams_dto.dart';
import 'package:online_exam_app/features/home/tabs/explore_tab/api/models/metadeta_dto.dart';

part 'exams_response.g.dart';

@JsonSerializable()
class ExamsResponse {
  List<ExamsDTO>? exams;
  MetadataDTO? metadata;
  String? message;

  ExamsResponse({
    this.exams,
    this.message,
    this.metadata,
  });

  factory ExamsResponse.fromJson(
    Map<String, dynamic> json,
  ) => _$ExamsResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ExamsResponseToJson(this);

  // ExamsResponseEntity toExamsResponseEntity (){
  //   return ExamsResponseEntity(
  //       exams: exams?.map((exam) => exam.toExamsEntity(),).toList(),
  //       message: message,
  //       metadata: metadata?.toMetadataEntity()

  //   );
  // }
}
