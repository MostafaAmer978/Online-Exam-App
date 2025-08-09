// import 'package:bloc_test/bloc_test.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'package:online_exam_app/features/login/api/models/user_dto.dart';
// import 'package:online_exam_app/features/login/domain/entities/user_model.dart';
// import 'package:online_exam_app/features/question/domain/usecases/get_questions_use_case.dart';
// import 'package:online_exam_app/features/register/presentation/cubit/register_cubit.dart';
// import 'package:online_exam_app/features/register/presentation/cubit/register_state.dart';

// @GenerateMocks([GetQuestionsUseCase])
// void main() {
//   late RegisterCubit registerCubit;
//   late MockRegisterUseCase mockRegisterUseCase;

//   setUp(() {
//     mockRegisterUseCase = MockRegisterUseCase();
//     registerCubit = RegisterCubit(mockRegisterUseCase);
//   });

//   final userData = (
//     name: 'lbar',
//     email: 'lbar@example.com',
//     password: 'securePassword',
//   );

//   final successResponse = ApiSuccessResult<UserDTO>();
//   final failureResponse = ApiFailureResult('Email already exists');

//   blocTest<RegisterCubit, RegisterState>(
//     'emits [RegisterLoading, RegisterSuccess] when registration succeeds',
//     build: () {
//       when(
//         mockRegisterUseCase.call(userData),
//       ).thenAnswer((_) async => successResponse);
//       return registerCubit;
//     },
//     act: (cubit) => cubit.register(userData),
//     expect: () => [RegisterLoading(), RegisterSuccess(successResponse.data)],
//   );

//   blocTest<RegisterCubit, RegisterState>(
//     'emits [RegisterLoading, RegisterFailure] when registration fails',
//     build: () {
//       when(
//         mockRegisterUseCase.call(userData),
//       ).thenAnswer((_) async => failureResponse);
//       return registerCubit;
//     },
//     act: (cubit) => cubit.register(any),
//     expect: () => [RegisterLoading(), RegisterFailure(failureResponse.message)],
//   );
// }
