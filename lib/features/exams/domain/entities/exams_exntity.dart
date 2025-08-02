class ExamsEntity {
  String? id;
  String? title;
  int? duration;
  String? subjectId;
  int? numberOfQuestions;
  bool? active;

  ExamsEntity({
    this.id,
    this.title,
    this.duration,
    this.subjectId,
    this.numberOfQuestions,
    this.active,
  });
}
