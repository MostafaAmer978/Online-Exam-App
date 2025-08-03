class LoginState {
  bool showDialogState;
  bool isLoggedState;
  bool rememberMeState;
  bool isLoadingState;

  LoginState({
    this.showDialogState = false,
    this.isLoggedState = false,
    this.rememberMeState = false,
    this.isLoadingState = false,
  });

  factory LoginState.initial() {
    return LoginState();
  }

  LoginState copyWith({
    bool? isLoggedState,
    bool? showDialogState,
    bool? rememberMeState,
    bool? isLoadingState,
  }) {
    return LoginState(
      showDialogState: showDialogState ?? this.showDialogState,
      isLoggedState: isLoggedState ?? this.isLoggedState,
      rememberMeState: rememberMeState ?? this.rememberMeState,
      isLoadingState: isLoadingState ?? this.isLoadingState,
    );
  }
}
