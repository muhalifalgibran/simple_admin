import 'package:dartz/dartz.dart';
import 'package:simple_admin/core/di/service_locator.dart';
import 'package:simple_admin/core/error/failure.dart';
import 'package:simple_admin/features/domain/entities/influencer.dart';
import 'package:simple_admin/features/domain/repositories/influencer_repository.dart';

class GetListInfluencer {
  final repository = getIt<InfluencerRepository>();

  // use call to directly call the usecase
  Future<Either<Failure, Influencer>> call(int page) async =>
      await repository.getInfluencer(page);
}
