import 'package:flutter/material.dart';
import 'package:simple_admin/core/di/service_locator.dart';
import 'package:simple_admin/features/domain/entities/influencer.dart';
import 'package:simple_admin/features/domain/usecases/get_list_influencers.dart';

enum StatusProvider {
  loading,
  success,
  failed,
}

class InfluencerProvider extends ChangeNotifier {
  List<Influencer> influencers = [];

  void getInfluencer(int page) async {
    final api = await getIt<GetListInfluencer>().call(page);

    api.fold((error) => null, (success) => influencers = success);
    notifyListeners();
  }
}
