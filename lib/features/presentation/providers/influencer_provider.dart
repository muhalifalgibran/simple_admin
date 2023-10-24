import 'package:flutter/material.dart';
import 'package:simple_admin/core/di/service_locator.dart';
import 'package:simple_admin/features/domain/entities/influencer.dart';
import 'package:simple_admin/features/domain/entities/influencer_data_table.dart';
import 'package:simple_admin/features/domain/usecases/get_list_influencers.dart';

enum StatusProvider {
  loading,
  success,
  failed,
}

class InfluencerProvider extends ChangeNotifier {
  List<Influencer> influencers = [];
  InfluencerDataTable? dataTable;
  bool sortAscending = true;
  int? sortColumnIndex;

  void getInfluencer(BuildContext context, int page) async {
    final api = await getIt<GetListInfluencer>().call(page);

    api.fold((error) => null, (success) {
      influencers = success;
      dataTable = InfluencerDataTable(context, influencers);
    });
    notifyListeners();
  }

  void sort<T>(
    Comparable<T> Function(Influencer d) getField,
    int columnIndex,
    bool ascending,
  ) {
    dataTable!.sort<T>(getField, ascending);
    sortColumnIndex = columnIndex;
    sortAscending = ascending;
    print('ssss');
    notifyListeners();
  }
}
