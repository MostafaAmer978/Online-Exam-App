part of 'app_cubit.dart';

class AppState {
  final bool isAuthenticated;
  final String? token;

  AppState({required this.isAuthenticated, this.token});

  factory AppState.initial() =>
      AppState(isAuthenticated: false);
}
