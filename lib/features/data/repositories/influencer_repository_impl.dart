import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:simple_admin/core/di/service_locator.dart';
import 'package:simple_admin/core/error/failure.dart';
import 'package:simple_admin/features/data/datasources/influencer_remote_data_source.dart';
import 'package:simple_admin/features/domain/entities/influencer.dart';
import 'package:simple_admin/features/domain/repositories/influencer_repository.dart';

class InfluencerRepositoryImpl implements InfluencerRepository {
  final dataSource = getIt<InfluencerRemoteDataSource>();

  @override
  Future<Either<Failure, List<Influencer>>> getInfluencer(int page) async {
    try {
      final api = await dataSource.getUser(page);
      return Right(api);
    } on DioException catch (e) {
      if (e.response != null && e.response?.statusCode != null) {
        if (e.response!.statusCode! >= 400 && e.response!.statusCode! < 500) {
          return const Left(ClientFailure());
        } else {
          return const Left(ServerFailure());
        }
      } else {
        return const Left(ServerFailure());
      }
    }
  }
}
