// abstract class LoginState {}
//
// class LoginInitialState extends LoginState {}
//
// class LoginErrorState extends LoginState {
//   String errorMessage;
//   LoginErrorState({required this.errorMessage});
// }
//
// class LoginSuccessState extends LoginState {}

 class LoginState {
  String? errorMessage;


  LoginState({this.errorMessage});

  factory LoginState.initial(){
    return LoginState();
  }

  LoginState copyWith({String? errorMessage}) {
    return LoginState(errorMessage: errorMessage ?? this.errorMessage);
  }
}
