import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:online_exam_app/features/register/api/data_source_impl/register_remote_data_source_impl.dart';
import 'package:online_exam_app/features/register/data/repos_impl/register_repo_impl.dart';
import 'package:online_exam_app/features/register/domain/entities/user_entity.dart';
import 'package:test/test.dart';

import 'package:online_exam_app/core/api_rasult/api_result.dart';

import 'register_repo_impl_test.mocks.dart';

@GenerateMocks([RegisterRemoteDataSourceImpl])
void main() {
  late MockRegisterRemoteDataSourceImpl mockRegisterRemoteDataSourceimpl;
  late RegisterRepoImpl registerRepoImpl;

  setUp(() {
    mockRegisterRemoteDataSourceimpl = MockRegisterRemoteDataSourceImpl();
    registerRepoImpl = RegisterRepoImpl(mockRegisterRemoteDataSourceimpl);
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

  group('RegisterRepoImpl', () {
    const mockUsername = 'testUser';
    const mockFirstName = 'John';
    const mockLastName = 'Doe';
    const mockEmail = 'john@example.com';
    const mockPassword = 'password123';
    const mockRePassword = 'password123';
    const mockPhone = '1234567890';

    final mockRegisterEntity = RegisterEntity(
      email: mockEmail,
      username: mockUsername,
      firstName: '',
      lastName: '',
      phone: '',
    );

    test(
      'should return ApiSuccessResult<RegisterEntity> when registration succeeds',
      () async {
        // arrange
        when(
          mockRegisterRemoteDataSourceimpl.register(
            mockUsername,
            mockFirstName,
            mockLastName,
            mockEmail,
            mockPassword,
            mockRePassword,
            mockPhone,
          ),
        ).thenAnswer((_) async => ApiSuccessResult(mockRegisterEntity));

        // act
        final result = await registerRepoImpl.register(
          mockUsername,
          mockFirstName,
          mockLastName,
          mockEmail,
          mockPassword,
          mockRePassword,
          mockPhone,
        );

        // assert
        expect(result, isA<ApiSuccessResult<RegisterEntity>>());
        result as ApiSuccessResult<RegisterEntity>;
        expect(result.data.username, mockUsername);
      },
    );

    test(
      'should return ApiErrorResult<RegisterEntity> when registration fails',
      () async {
        // arrange
        const mockError = 'Registration failed';
        when(
          mockRegisterRemoteDataSourceimpl.register(
            any,
            any,
            any,
            any,
            any,
            any,
            any,
          ),
        ).thenAnswer((_) async => ApiErrorResult(mockError));

        // act
        final result = await registerRepoImpl.register(
          mockUsername,
          mockFirstName,
          mockLastName,
          mockEmail,
          mockPassword,
          mockRePassword,
          mockPhone,
        );

        // assert
        expect(result, isA<ApiErrorResult<RegisterEntity>>());
        result as ApiErrorResult<RegisterEntity>;
        expect(result.errorMessage, mockError);
      },
    );
  });
}
