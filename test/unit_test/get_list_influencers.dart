import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_admin/core/error/failure.dart';
import 'package:simple_admin/features/domain/entities/influencer.dart';
import 'package:simple_admin/features/domain/repositories/influencer_repository.dart';
import 'package:simple_admin/features/domain/usecases/get_list_influencers.dart';

import '../utility.dart';

class MockInfluencerRepository extends Mock implements InfluencerRepository {}

void main() {
  late InfluencerRepository mockRepository;
  late GetListInfluencer usecase;

  setUpAll(() {
    mockRepository = MockInfluencerRepository();

    registerTestLazySingleton(mockRepository);
    usecase = GetListInfluencer();
  });

  test('Should return Right(Influencer)', () async {
    var data = const Influencer(
        page: 1, perPage: 6, total: 12, totalPages: 2, data: []);
    // arrange
    when(() => mockRepository.getInfluencer(any()))
        .thenAnswer((_) async => Right(data));

    // act
    final api = await usecase.call(1);

    // verify
    verify(() => mockRepository.getInfluencer(any())).called(1);
    expect(api, Right(data));
  });

  test('Should return failure when get error from repository', () async {
    // arrange
    when(() => mockRepository.getInfluencer(any()))
        .thenAnswer((_) async => const Left(ServerFailure()));

    // act
    final api = await usecase.call(1);

    // verify
    verify(() => mockRepository.getInfluencer(any())).called(1);
    expect(api, const Left(ServerFailure()));
  });
}
