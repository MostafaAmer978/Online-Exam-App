import 'package:injectable/injectable.dart';
import 'package:online_exam_app/core/api_rasult/api_result.dart';
import 'package:online_exam_app/features/home/tabs/explore_tab/api/client/subject_api.dart';
import 'package:online_exam_app/features/home/tabs/explore_tab/api/models/subject_response.dart';
import 'package:online_exam_app/features/home/tabs/explore_tab/data/datasources/get_subject_remote_data_source.dart';
import 'package:online_exam_app/features/home/tabs/explore_tab/domain/entities/subjects_entity.dart';
import 'package:dio/dio.dart';

@Injectable(as: GetSubjectRemoteDataSource)
class GetSubjectsRemoteDataImpl
    implements GetSubjectRemoteDataSource {
  SubjectApi subjectApi;

  GetSubjectsRemoteDataImpl(this.subjectApi);
  @override
  Future<ApiResult<List<SubjectsEntity>>>
  getSubjects() async {
    try {
      SubjectResponse subjectResponse = await subjectApi
          .getSubjects();
      return ApiSuccessResult<List<SubjectsEntity>>(
        subjectResponse.subjects!
            .map((e) => e.toSubjectsEntity())
            .toList(),
      );
    } catch (e) {
      if (e is DioException) {
        final responseData = e.response?.data;
        if (responseData != null &&
            responseData is Map<String, dynamic>) {
          final message =
              responseData["message"] ?? "Unknown error";
          return ApiErrorResult<List<SubjectsEntity>>(
            message.toString(),
          );
        }
        return ApiErrorResult<List<SubjectsEntity>>(
          e.message ?? e.toString(),
        );
      }
      return ApiErrorResult<List<SubjectsEntity>>(
        e.toString(),
      );
    }
  }
}
