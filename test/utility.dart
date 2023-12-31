import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

void _removeIfRegistered<T extends Object>({
  String? instanceName,
}) {
  if (getIt.isRegistered<T>(instanceName: instanceName)) {
    getIt.unregister<T>(instanceName: instanceName);
  }
}

void registerTestLazySingleton<T extends Object>(
  T mockObject, {
  String? instanceName,
}) {
  _removeIfRegistered<T>(instanceName: instanceName);
  getIt.registerLazySingleton<T>(
    () => mockObject,
    instanceName: instanceName,
  );
}
