import 'package:json_annotation/json_annotation.dart';
import 'package:online_exam_app/features/home/tabs/explore_tab/domain/entities/subjects_entity.dart';

part 'subject_dto.g.dart';

@JsonSerializable()
class SubjectDTO {
  @JsonKey(name: "_id")
  final String? id;

  @JsonKey(name: "name")
  final String? name;

  @JsonKey(name: "icon")
  final String? icon;

  @JsonKey(name: "createdAt")
  final DateTime? createdAt;

  SubjectDTO({
    this.id,
    this.name,
    this.icon,
    this.createdAt,
  });

  factory SubjectDTO.fromJson(
    Map<String, dynamic> json,
  ) => _$SubjectDTOFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SubjectDTOToJson(this);
  SubjectsEntity toSubjectsEntity() => SubjectsEntity(
    id: id ?? '',
    name: name ?? '',
    icon: icon ?? '',
  );
}
