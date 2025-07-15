part of 'register_cubit.dart';

class RegisterState {
  bool? registerLoadingState;
  String? registerErrorState;

  RegisterState({this.registerErrorState, this.registerLoadingState});

  RegisterState copyWith({
    bool? registerLoadingState,
    String? registerErrorState,
  }) {
    return RegisterState(
      registerErrorState: registerErrorState ?? this.registerErrorState,
      registerLoadingState: registerLoadingState ?? this.registerLoadingState,
    );
  }
}
