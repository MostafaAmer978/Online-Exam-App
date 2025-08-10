part of 'explore_tab_cubit.dart';

abstract class ExploreTabState {}

class ExploreTabInitial extends ExploreTabState {}

class GetSubjectsLoading extends ExploreTabState {}

class GetSubjectsLoaded extends ExploreTabState {
  final List<SubjectsEntity>? subjects;
  GetSubjectsLoaded(this.subjects);
}

class GetSubjectsError extends ExploreTabState {
  final String? message;
  GetSubjectsError(this.message);
}
