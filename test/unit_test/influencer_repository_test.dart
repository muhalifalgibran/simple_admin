import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_admin/core/error/failure.dart';
import 'package:simple_admin/features/data/datasources/influencer_remote_data_source.dart';
import 'package:simple_admin/features/data/repositories/influencer_repository_impl.dart';
import 'package:simple_admin/features/domain/entities/influencer.dart';
import 'package:simple_admin/features/domain/repositories/influencer_repository.dart';
import 'package:mocktail/mocktail.dart';

import '../utility.dart';

class MockInfluencerRemoteDataSource extends Mock
    implements InfluencerRemoteDataSourceImpl {}

void main() {
  late InfluencerRemoteDataSourceImpl mockDataSource;
  late InfluencerRepository repo;

  setUpAll(() {
    mockDataSource = MockInfluencerRemoteDataSource();
    registerTestLazySingleton<InfluencerRemoteDataSource>(mockDataSource);
    repo = InfluencerRepositoryImpl();
  });

  test('should return failure when data source thrown an error', () async {
    // arrange
    when(() => mockDataSource.getUser(any()))
        .thenThrow(DioException(requestOptions: RequestOptions()));

    // act
    final api = await repo.getInfluencer(1);

    // verify
    verify(() => mockDataSource.getUser(any())).called(1);
    expect(api, equals(const Left(ServerFailure())));
  });

  test('should return data when call datasource is complete', () async {
    var data = const Influencer(
        page: 1, perPage: 6, total: 12, totalPages: 2, data: []);
    // arrange
    when(() => mockDataSource.getUser(any())).thenAnswer((_) async => data);

    // act
    final api = await repo.getInfluencer(1);

    // verify
    verify(() => mockDataSource.getUser(any())).called(1);
    expect(api, equals(Right(data)));
  });
}
