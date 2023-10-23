import 'package:get_it/get_it.dart';
import 'package:simple_admin/features/data/datasources/influencer_remote_data_source.dart';
import 'package:simple_admin/features/data/repositories/Influencer_repository_impl.dart';
import 'package:simple_admin/features/domain/repositories/influencer_repository.dart';
import 'package:simple_admin/features/domain/usecases/get_list_influencers.dart';

GetIt getIt = GetIt.instance;

// setup the dependency injection
void setupLocator() {
  getIt.registerLazySingleton<InfluencerRemoteDataSource>(
    () => InfluencerRemoteDataSourceImpl(),
  );
  getIt.registerLazySingleton<InfluencerRepository>(
    () => InfluencerRepositoryImpl(),
  );
  getIt.registerLazySingleton(() => GetListInfluencer());
}
