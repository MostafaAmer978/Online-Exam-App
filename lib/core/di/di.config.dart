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
import '../dio_module/dio_module.dart' as _i773;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final dioModule = _$DioModule();
    gh.singleton<_i361.Dio>(() => dioModule.dio);
    gh.factory<_i45.RegisterApi>(() => _i45.RegisterApi(gh<_i361.Dio>()));
    gh.factory<_i542.RegisterRemoteDataSource>(
      () => _i318.RegisterRemoteDataSourceImpl(gh<_i45.RegisterApi>()),
    );
    gh.factory<_i146.RegisterRepo>(
      () => _i17.RegisterRepoImpl(gh<_i542.RegisterRemoteDataSource>()),
    );
    gh.factory<_i1037.RegisterUserCase>(
      () => _i1037.RegisterUserCase(gh<_i146.RegisterRepo>()),
    );
    gh.factory<_i266.RegisterCubit>(
      () => _i266.RegisterCubit(gh<_i1037.RegisterUserCase>()),
    );
    return this;
  }
}

class _$DioModule extends _i773.DioModule {}
