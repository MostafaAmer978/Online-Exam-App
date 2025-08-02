import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/features/home/tabs/explore_tab/presentation/pages/explore_tab.dart';
import 'package:online_exam_app/features/home/tabs/profile_tab/presentation/pages/profile_tab.dart';
import 'package:online_exam_app/features/home/tabs/results_tab/presentation/pages/results_tab.dart';

part 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(ExploreTabState());

  int currentIndex = 0;

  List<Widget> tabs = [
    const ExploreTab(),
    const ResultsTab(),
    const ProfileTab(),
  ];
  void onTabClicked(int tabIndex) {
    if (currentIndex != tabIndex) {
      currentIndex = tabIndex;
      if (tabIndex == 0) {
        emit(ExploreTabState());
      } else if (tabIndex == 1) {
        emit(ResultTabState());
      } else if (tabIndex == 2) {
        emit(ProfileTabState());
      }
    }
  }
}
