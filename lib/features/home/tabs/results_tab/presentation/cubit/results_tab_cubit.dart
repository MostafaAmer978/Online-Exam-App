import 'package:flutter_bloc/flutter_bloc.dart';

part 'results_tab_state.dart';

class ResultsTabCubit extends Cubit<ResultsTabState> {
  ResultsTabCubit() : super(ResultsTabInitial());
}
