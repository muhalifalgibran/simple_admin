import 'package:dartz/dartz.dart';
import 'package:simple_admin/core/error/failure.dart';
import 'package:simple_admin/features/domain/entities/influencer.dart';

abstract class InfluencerRepository {
  Future<Either<Failure, List<Influencer>>> getInfluencer(int page);
}
