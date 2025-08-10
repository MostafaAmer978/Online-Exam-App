import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_tab_state.dart';

class ProfileTabCubit extends Cubit<ProfileTabState> {
  ProfileTabCubit() : super(ProfileTabInitial());
}
