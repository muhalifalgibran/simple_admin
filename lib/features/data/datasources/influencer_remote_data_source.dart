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

    return InfluencerModel.fromJson(result.data);
  }
}
