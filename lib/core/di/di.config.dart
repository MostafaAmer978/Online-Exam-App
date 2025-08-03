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

import '../../features/login/api/client/login_api_client.dart' as _i313;
import '../../features/login/api/datasources_impl/login_local_datasource_impl.dart'
    as _i835;
import '../../features/login/api/datasources_impl/login_remote_datasource_impl.dart'
    as _i884;
import '../../features/login/data/datasources/login_local_datasource.dart'
    as _i301;
import '../../features/login/data/datasources/login_remote_datasource.dart'
    as _i1033;
import '../../features/login/data/repos_impl/login_repo_impl.dart' as _i998;
import '../../features/login/domain/repos/login_repo.dart' as _i184;
import '../../features/login/domain/usecases/login_usecase.dart' as _i420;
import '../../features/login/presentation/cubit/login_cubit.dart' as _i147;
import 'dio_module.dart' as _i1045;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final dioModule = _$DioModule();
    gh.singleton<_i361.Dio>(() => dioModule.dio);
    gh.factory<_i313.LoginApiClient>(
      () => _i313.LoginApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i301.LoginLocalDataSource>(
      () => _i835.LoginLocalDataSourceImpl(
        loginApiClient: gh<_i313.LoginApiClient>(),
      ),
    );
    gh.factory<_i1033.LoginRemoteDataSource>(
      () => _i884.LoginRemoteDataSourceImpl(gh<_i313.LoginApiClient>()),
    );
    gh.factory<_i184.LoginRepoContract>(
      () => _i998.LoginRepoImpl(
        loginRemoteDataSource: gh<_i1033.LoginRemoteDataSource>(),
        loginLocalDataSource: gh<_i301.LoginLocalDataSource>(),
      ),
    );
    gh.factory<_i420.LoginUseCase>(
      () =>
          _i420.LoginUseCase(loginRepoContract: gh<_i184.LoginRepoContract>()),
    );
    gh.factory<_i147.LoginCubit>(
      () => _i147.LoginCubit(loginUseCase: gh<_i420.LoginUseCase>()),
    );
    return this;
  }
}

class _$DioModule extends _i1045.DioModule {}
