import 'package:simple_admin/core/network/dio_client.dart';
import 'package:simple_admin/features/data/models/influencer_model.dart';
import 'package:simple_admin/features/domain/entities/influencer.dart';

abstract class InfluencerRemoteDataSource {
  Future<Influencer> getUser(int page);
}

class InfluencerRemoteDataSourceImpl implements InfluencerRemoteDataSource {
  final DioClient _client = DioClient();
  @override
  Future<Influencer> getUser(int page) async {
    final result = await _client.get('users?page=$page&per_page=6');
    // we should not catch the error here since we treat our repository
    // as DTO so our repository should return whether an error or an expected object
    // , in data source we just send the expected object/data or just throw the error from here.
    return InfluencerModel.fromJson(result.data);
  }
}
