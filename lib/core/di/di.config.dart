// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../config/app_cubit/app_cubit.dart' as _i203;
import '../../features/exams/api/client/exams_api.dart' as _i991;
import '../../features/exams/api/data_source_impl/get_exams_data_source_impl.dart'
    as _i410;
import '../../features/exams/data/datasources/get_exams_remote_data_source.dart'
    as _i360;
import '../../features/exams/data/repos_impl/get_exams_repo_impl.dart' as _i309;
import '../../features/exams/domain/repos/get_exams_repo.dart' as _i161;
import '../../features/exams/domain/usecases/get_exams_user_case.dart' as _i447;
import '../../features/exams/presentation/cubit/exams_cubit.dart' as _i833;
import '../../features/home/home_cubit/home_cubit.dart' as _i405;
import '../../features/home/tabs/explore_tab/api/client/subject_api.dart'
    as _i152;
import '../../features/home/tabs/explore_tab/api/data_source_impl/get_subjects_remote_data_impl.dart'
    as _i151;
import '../../features/home/tabs/explore_tab/data/datasources/get_subject_remote_data_source.dart'
    as _i894;
import '../../features/home/tabs/explore_tab/data/repos_impl/get_subject_repo_impl.dart'
    as _i972;
import '../../features/home/tabs/explore_tab/domain/repos/get_subject_repo.dart'
    as _i284;
import '../../features/home/tabs/explore_tab/domain/usecases/get_subjects_user_case.dart'
    as _i638;
import '../../features/home/tabs/explore_tab/presentation/cubit/explore_tab_cubit.dart'
    as _i466;
import '../../features/question/api/client/question_api.dart' as _i807;
import '../../features/question/api/data_source_impl/get_questions_data_source_impl.dart'
    as _i830;
import '../../features/question/data/datasources/get_questions_data_source.dart'
    as _i275;
import '../../features/question/data/repos_impl/get_questions_repo_impl.dart'
    as _i855;
import '../../features/question/domain/repos/get_questions_repo.dart' as _i575;
import '../../features/question/domain/usecases/get_questions_use_case.dart'
    as _i756;
import '../../features/question/presentation/cubit/questions_view_model/questions_cubit.dart'
    as _i5;
import '../../features/register/api/client/register_api.dart' as _i45;
import '../../features/register/api/data_source_impl/register_remote_data_source_impl.dart'
    as _i318;
import '../../features/register/data/datasources/register_remate_data_source.dart'
    as _i542;
import '../../features/register/data/repos_impl/register_repo_impl.dart'
    as _i17;
import '../../features/register/domain/repos/register_repo.dart' as _i146;
import '../../features/register/domain/usecases/register_user_case.dart'
    as _i1037;
import '../../features/register/presentation/cubit/register_cubit.dart'
    as _i266;
import '../cache/shared_preferences.dart' as _i254;
import '../cache/storage_source.dart' as _i1052;
import '../dio_module/dio_module.dart' as _i773;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final dioModule = _$DioModule();
    gh.factory<_i405.HomeCubit>(() => _i405.HomeCubit());
    gh.singleton<_i254.SharedPreferencesHelper>(
      () => _i254.SharedPreferencesHelper(),
    );
    gh.lazySingleton<_i1052.SecureStorageService>(
      () => _i1052.SecureStorageServiceImpl(),
    );
    gh.lazySingleton<_i361.Dio>(
      () => dioModule.dio(gh<_i1052.SecureStorageService>()),
    );
    gh.factory<_i203.AppCubit>(
      () => _i203.AppCubit(gh<_i1052.SecureStorageService>()),
    );
    gh.factory<_i991.ExamsApi>(() => _i991.ExamsApi(gh<_i361.Dio>()));
    gh.factory<_i152.SubjectApi>(() => _i152.SubjectApi(gh<_i361.Dio>()));
    gh.factory<_i807.QuestionApi>(() => _i807.QuestionApi(gh<_i361.Dio>()));
    gh.factory<_i45.RegisterApi>(() => _i45.RegisterApi(gh<_i361.Dio>()));
    gh.factory<_i275.GetQuestionsDataSource>(
      () => _i830.GetQuestionsDataSourceImpl(gh<_i807.QuestionApi>()),
    );
    gh.factory<_i542.RegisterRemoteDataSource>(
      () => _i318.RegisterRemoteDataSourceImpl(
        gh<_i45.RegisterApi>(),
        gh<_i1052.SecureStorageService>(),
      ),
    );
    gh.factory<_i575.GetQuestionsRepo>(
      () => _i855.GetQuestionsRepoImpl(gh<_i275.GetQuestionsDataSource>()),
    );
    gh.factory<_i360.GetExamsRemoteDataSource>(
      () => _i410.GetExamsDataSourceImpl(gh<_i991.ExamsApi>()),
    );
    gh.factory<_i894.GetSubjectRemoteDataSource>(
      () => _i151.GetSubjectsRemoteDataImpl(gh<_i152.SubjectApi>()),
    );
    gh.factory<_i756.GetQuestionsUseCase>(
      () => _i756.GetQuestionsUseCase(gh<_i575.GetQuestionsRepo>()),
    );
    gh.factory<_i161.GetExamsRepo>(
      () => _i309.GetExamsRepoImpl(gh<_i360.GetExamsRemoteDataSource>()),
    );
    gh.factory<_i284.GetSubjectRepo>(
      () => _i972.GetSubjectRepoImpl(gh<_i894.GetSubjectRemoteDataSource>()),
    );
    gh.factory<_i146.RegisterRepo>(
      () => _i17.RegisterRepoImpl(gh<_i542.RegisterRemoteDataSource>()),
    );
    gh.factory<_i5.QuestionsCubit>(
      () => _i5.QuestionsCubit(gh<_i756.GetQuestionsUseCase>()),
    );
    gh.factory<_i447.GetExamsUseCase>(
      () => _i447.GetExamsUseCase(gh<_i161.GetExamsRepo>()),
    );
    gh.factory<_i638.GetSubjectsUserCase>(
      () => _i638.GetSubjectsUserCase(gh<_i284.GetSubjectRepo>()),
    );
    gh.factory<_i833.ExamsCubit>(
      () => _i833.ExamsCubit(gh<_i447.GetExamsUseCase>()),
    );
    gh.factory<_i1037.RegisterUserCase>(
      () => _i1037.RegisterUserCase(gh<_i146.RegisterRepo>()),
    );
    gh.factory<_i466.ExploreTabCubit>(
      () => _i466.ExploreTabCubit(gh<_i638.GetSubjectsUserCase>()),
    );
    gh.factory<_i266.RegisterCubit>(
      () => _i266.RegisterCubit(gh<_i1037.RegisterUserCase>()),
    );
    return this;
  }
}

class _$DioModule extends _i773.DioModule {}
