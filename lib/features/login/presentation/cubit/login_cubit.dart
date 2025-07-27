import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/features/login/domain/usecases/login_usecase.dart';
import 'package:online_exam_app/features/login/presentation/cubit/login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  LoginUseCase loginUseCase;

  LoginCubit({required this.loginUseCase}) : super(LoginState.initial());

  Future<void> login({String? email, String? password}) async {
    await loginUseCase.call(email: email, password: password);
  }
}
