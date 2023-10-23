import 'package:simple_admin/core/network/dio_client.dart';
import 'package:simple_admin/features/data/models/influencer_model.dart';
import 'package:simple_admin/features/domain/entities/influencer.dart';

abstract class InfluencerRemoteDataSource {
  Future<List<Influencer>> getUser(int page);
}

class InfluencerRemoteDataSourceImpl implements InfluencerRemoteDataSource {
  final DioClient _client = DioClient.instance;
  @override
  Future<List<Influencer>> getUser(int page) async {
    final result = await _client.get('users?page=$page');

    return result.data['data'].map((json) => InfluencerModel.fromJson(json));
  }
}
