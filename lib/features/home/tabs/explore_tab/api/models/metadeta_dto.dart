import 'package:json_annotation/json_annotation.dart';
part 'metadeta_dto.g.dart';

@JsonSerializable()
class MetadataDTO {
  @JsonKey(name: "currentPage")
  final int? currentPage;

  @JsonKey(name: "numberOfPages")
  final int? numberOfPages;

  @JsonKey(name: "limit")
  final int? limit;

  MetadataDTO({
    this.currentPage,
    this.numberOfPages,
    this.limit,
  });

  factory MetadataDTO.fromJson(
    Map<String, dynamic> json,
  ) => _$MetadataDTOFromJson(json);

  Map<String, dynamic> toJson() =>
      _$MetadataDTOToJson(this);
}
