import 'package:flutter/material.dart';
import 'package:simple_admin/core/di/service_locator.dart';
import 'package:simple_admin/features/domain/entities/influencer.dart';
import 'package:simple_admin/features/domain/entities/influencer_data_table.dart';
import 'package:simple_admin/features/domain/usecases/get_list_influencers.dart';

class InfluencerProvider extends ChangeNotifier {
  late Influencer influencers;
  InfluencerDataTable? dataTable;
  bool sortAscending = true;
  int? sortColumnIndex;
  String? location, role;

  // get the data API
  void getInfluencer(BuildContext context, int page) async {
    final api = await getIt<GetListInfluencer>().call(page);

    api.fold((error) => null, (success) {
      influencers = success;
      dataTable = InfluencerDataTable(context, influencers.data);
    });
    notifyListeners();
  }

  // we sort our row based on their column
  // wheter it is ascending or descending
  void sort<T>(
    Comparable<T> Function(InfluencerData d) getField,
    int columnIndex,
    bool ascending,
  ) {
    dataTable!.sort<T>(getField, ascending);
    sortColumnIndex = columnIndex;
    sortAscending = ascending;
    notifyListeners();
  }

  // since the data is in local we don't
  // need debouncer to make our call more efficient
  void search(String value) {
    dataTable!.search(value);
  }

  // modeling our filter
  // if location and role is null so the value will remains the same
  // if both of filter value's is default then we change it to null
  void filter({String? location, String? role}) {
    this.location =
        (location == 'All Location') ? null : (location ?? this.location);
    this.role = (role == 'All Role') ? null : (role ?? this.role);

    dataTable!.filter(this.location, this.role);
  }

  void clear() {
    location = null;
    role = null;
    dataTable!.filter(location, role);
    notifyListeners();
  }
}
