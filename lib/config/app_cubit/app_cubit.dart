import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/core/cache/storage_source.dart';

part 'app_state.dart';

@injectable
class AppCubit extends Cubit<AppState> {
  final SecureStorageService secureStorageService;

  AppCubit(this.secureStorageService) : super(AppState.initial());

  /// Loads the authentication token from the secure storage and
  /// updates the cubit's state accordingly. If the token is not
  /// found, it emits a state with [isAuthenticated] set to false.

  Future<void> loadToken() async {
    final savedToken = await secureStorageService.readToken();

    if (savedToken != null && savedToken.isNotEmpty) {
      emit(AppState(isAuthenticated: true, token: savedToken));
      print('token: $savedToken');
    } else {
      emit(AppState(isAuthenticated: false));
    }
  }

  // Future<void> saveToken(String token) async {
  //   await secureStorageService.saveToken(token);
  //   emit(AppState(isAuthenticated: true, token: token));
  // }

  Future<void> logout() async {
    await secureStorageService.deleteToken();
    emit(AppState(isAuthenticated: false));
  }
}
