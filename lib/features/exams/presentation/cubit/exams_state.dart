part of 'exams_cubit.dart';

abstract class ExamsState {}

class ExamsInitial extends ExamsState {}

class ExamsLoading extends ExamsState {}

class ExamsLoaded extends ExamsState {
  final List<ExamsEntity> exams;
  ExamsLoaded(this.exams);
}

class ExamsError extends ExamsState {
  final String errMessage;
  ExamsError(this.errMessage);
}
