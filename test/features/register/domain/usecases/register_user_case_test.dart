import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:online_exam_app/core/api_rasult/api_result.dart';
import 'package:online_exam_app/features/register/domain/entities/user_entity.dart';
import 'package:online_exam_app/features/register/domain/repos/register_repo.dart';
import 'package:online_exam_app/features/register/domain/usecases/register_user_case.dart';
import 'package:test/test.dart';

import 'register_user_case_test.mocks.dart';

@GenerateMocks([RegisterRepo])
void main() {
  late RegisterUserCase registerUserCase;
  late MockRegisterRepo mockRegisterRepo;
  setUp(() {
    mockRegisterRepo = MockRegisterRepo();
    registerUserCase = RegisterUserCase(mockRegisterRepo);
    provideDummy<ApiResult<RegisterEntity>>(
      ApiSuccessResult<RegisterEntity>(
        RegisterEntity(
          email: '',
          username: '',
          firstName: '',
          lastName: '',
          phone: '',
        ),
      ),
    );
  });
  group(('test registerUserCase'), () {
    test('test success case', () async {
      final mockRegisterEntity = RegisterEntity(
        email: '',
        username: '',
        firstName: '',
        lastName: '',
        phone: '',
      );
      // arrange
      when(
        mockRegisterRepo.register(any, any, any, any, any, any, any),
      ).thenAnswer(
        (_) async => ApiSuccessResult<RegisterEntity>(mockRegisterEntity),
      );
      // act
      final result = await registerUserCase.call('', '', '', '', '', '', '');
      // assert
      expect(result, isA<ApiSuccessResult<RegisterEntity>>());
    });

    test('test use case error', () async {
      // arrange
      const mockError = 'Registration failed';
      when(
        mockRegisterRepo.register(any, any, any, any, any, any, any),
      ).thenAnswer((_) async => ApiErrorResult<RegisterEntity>(mockError));
      // act
      final result = await registerUserCase.call('', '', '', '', '', '', '');
      // assert
      expect(result, isA<ApiErrorResult<RegisterEntity>>());
      result as ApiErrorResult<RegisterEntity>;
      expect(result.errorMessage, mockError);
    });
  });
}
