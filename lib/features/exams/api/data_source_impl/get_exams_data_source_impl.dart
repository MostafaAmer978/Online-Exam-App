import 'package:injectable/injectable.dart';
import 'package:online_exam_app/core/api_rasult/api_result.dart';
import 'package:online_exam_app/features/exams/api/client/exams_api.dart';
import 'package:online_exam_app/features/exams/api/models/exams_response.dart';
import 'package:online_exam_app/features/exams/data/datasources/get_exams_remote_data_source.dart';
import 'package:online_exam_app/features/exams/domain/entities/exams_exntity.dart';
import 'package:dio/dio.dart';

@Injectable(as: GetExamsRemoteDataSource)
class GetExamsDataSourceImpl
    implements GetExamsRemoteDataSource {
  ExamsApi examsApi;

  GetExamsDataSourceImpl(this.examsApi);

  @override
  Future<ApiResult<List<ExamsEntity>>> getExamsBySubject(
    String subjectId,
  ) async {
    try {
      ExamsResponse examsResponse = await examsApi
          .getExamsBySubject(subjectId);
      return ApiSuccessResult<List<ExamsEntity>>(
        examsResponse.exams!
            .map((e) => e.toExamsEntity())
            .toList(),
      );
    } catch (e) {
      if (e is DioException) {
        final responseData = e.response?.data;
        if (responseData != null &&
            responseData is Map<String, dynamic>) {
          final message =
              responseData["message"] ?? "Unknown error";
          return ApiErrorResult<List<ExamsEntity>>(
            message.toString(),
          );
        }
        return ApiErrorResult<List<ExamsEntity>>(
          e.message ?? e.toString(),
        );
      }
      return ApiErrorResult<List<ExamsEntity>>(
        e.toString(),
      );
    }
  }
}
