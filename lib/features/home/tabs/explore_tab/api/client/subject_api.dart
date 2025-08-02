import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';
import 'package:online_exam_app/core/values/api_end_points.dart';
import 'package:online_exam_app/features/home/tabs/explore_tab/api/models/subject_response.dart';
import 'package:retrofit/retrofit.dart';

part 'subject_api.g.dart';

@injectable
@RestApi()
abstract class SubjectApi {
  @factoryMethod
  factory SubjectApi(Dio dio) = _SubjectApi;

  @GET(AppEndpoints.subjectUrl)
  Future<SubjectResponse> getSubjects();
}
