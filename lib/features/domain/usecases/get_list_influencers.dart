import 'package:dartz/dartz.dart';
import 'package:simple_admin/core/error/failure.dart';
import 'package:simple_admin/features/domain/entities/influencer.dart';
import 'package:simple_admin/features/domain/repositories/influencer_repository.dart';

class GetListInfluencer {
  final InfluencerRepository repository;

  GetListInfluencer(this.repository);

  Future<Either<Failure, List<Influencer>>> call(int page) async =>
      await repository.getInfluencer(page);
}
