import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:online_exam_app/core/cache/storage_source.dart';
import 'package:online_exam_app/features/register/api/data_source_impl/register_remote_data_source_impl.dart';
import 'package:online_exam_app/features/register/api/model/user_dto.dart';
import 'package:test/test.dart';
import 'package:dio/dio.dart';
import 'package:online_exam_app/core/api_rasult/api_result.dart';
import 'package:online_exam_app/features/register/api/client/register_api.dart';
import 'package:online_exam_app/features/register/api/model/register_response.dart';
import 'package:online_exam_app/features/register/domain/entities/user_entity.dart';

import 'register_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([RegisterApi, SecureStorageService])
void main() {
  late MockRegisterApi mockRegisterApi;
  late RegisterRemoteDataSourceImpl dataSource;
  late MockSecureStorageService mockStorage;
  setUp(() {
    mockRegisterApi = MockRegisterApi();
    mockStorage = MockSecureStorageService();
    dataSource = RegisterRemoteDataSourceImpl(mockRegisterApi, mockStorage);
  });

  group('RegisterRemoteDataSourceImpl', () {
    test('returns ApiSuccessResult when registration is successful', () async {
      // arrange
      final mockResponse = RegisterResponse(
        user: UserDTO(
          id: '1',
          username: 'user1',
          firstName: 'first',
          lastName: 'last',
          email: 'user1@mail.com',
        ),
        token: 'mock_token',
      );

      when(
        mockRegisterApi.register(body: anyNamed('body')),
      ).thenAnswer((_) async => mockResponse);

      when(
        mockStorage.saveToken('mock_token'),
      ).thenAnswer((_) async => Future.value());

      // act
      final result = await dataSource.register(
        'user1',
        'first',
        'last',
        'user1@mail.com',
        '12345678',
        '12345678',
        '123456789',
      );

      // assert
      expect(result, isA<ApiSuccessResult<RegisterEntity>>());
      final user = (result as ApiSuccessResult<RegisterEntity>).data;
      expect(user.username, 'user1');

      verify(mockRegisterApi.register(body: anyNamed('body'))).called(1);
      //  verify(mockStorage.saveToken('mock_token')).called(1);
    });

    test(
      'returns ApiErrorResult when DioException is thrown with message',
      () async {
        // arrange
        final String mockErrorMessage = 'some thing went wrong';
        final DioException mockDioException = DioException(
          requestOptions: RequestOptions(path: ''),
          message: mockErrorMessage,
        );

        when(
          mockRegisterApi.register(body: anyNamed('body')),
        ).thenThrow(mockDioException);

        // act
        final result = await dataSource.register(
          'user1',
          'first',
          'last',
          'user1@mail.com',
          '12345678',
          '12345678',
          '123456789',
        );

        // assert
        expect(result, isA<ApiErrorResult<RegisterEntity>>());
        result as ApiErrorResult<RegisterEntity>;
        expect(result.errorMessage, mockErrorMessage);
      },
    );
  });
}
