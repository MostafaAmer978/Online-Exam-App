part of 'home_cubit.dart';

sealed class HomeState {}

class ExploreTabState extends HomeState {}

class ResultTabState extends HomeState {
  final Map<String, dynamic>? resultData;
  ResultTabState({this.resultData});
}

class ProfileTabState extends HomeState {}
