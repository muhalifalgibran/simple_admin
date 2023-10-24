import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:simple_admin/features/domain/entities/influencer.dart';

// Keeps track of selected rows, feed the data into InfluencerDataTable
class RestorableInfluencerSelections extends RestorableProperty<Set<int>> {
  Set<int> _dessertSelections = {};

  // Returns whether or not a influencer row is selected by index.
  bool isSelected(int index) => _dessertSelections.contains(index);

  // Takes a list of [Influencer]s and saves the row indices of selected rows
  // into a [Set].
  void setDessertSelections(List<InfluencerData> influencers) {
    final updatedSet = <int>{};
    for (var i = 0; i < influencers.length; i += 1) {
      var influencer = influencers[i];
      if (influencer.selected) {
        updatedSet.add(i);
      }
    }
    _dessertSelections = updatedSet;
    notifyListeners();
  }

  @override
  Set<int> createDefaultValue() => _dessertSelections;

  @override
  Set<int> fromPrimitives(Object? data) {
    final selectedItemIndices = data as List<dynamic>;
    _dessertSelections = {
      ...selectedItemIndices.map<int>((dynamic id) => id as int),
    };
    return _dessertSelections;
  }

  @override
  void initWithValue(Set<int> value) {
    _dessertSelections = value;
  }

  @override
  Object toPrimitives() => _dessertSelections.toList();
}

// modeling our inflencers data to datatable
// so we can use this class to map our influencers to datatable
class InfluencerDataTable extends DataTableSource {
  InfluencerDataTable.empty(this.context) {
    influencers = [];
  }

  InfluencerDataTable(
    this.context,
    this.influencers, [
    this.hasZebraStripes = false,
  ]) {
    _allInfluencers = influencers;
  }

  final BuildContext context;

  // for data
  late List<InfluencerData> influencers;
  // for keep our data remains the original
  // since we use search and filter
  late List<InfluencerData> _allInfluencers;
  int _selectedCount = 0;
  bool hasZebraStripes = false;

  // sort function to sort based on selectedField
  void sort<T>(
      Comparable<T> Function(InfluencerData d) getField, bool ascending) {
    influencers.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });
    notifyListeners();
  }

  void search(String value) {
    influencers = _allInfluencers
        .where((obj) => (obj.firstName.contains(value) ||
            obj.lastName.contains(value) ||
            obj.email.contains(value) ||
            obj.location.toLowerCase().contains(value) ||
            obj.role.toLowerCase().contains(value)))
        .toList();
    notifyListeners();
  }

  void filter(String? location, String? role) {
    influencers = _allInfluencers
        .where((obj) =>
            (obj.location.contains(location ?? '')) &&
            (obj.role.contains(role ?? '')))
        .toList();

    notifyListeners();
  }

  void updateSelectedDesserts(RestorableInfluencerSelections selectedRows) {
    _selectedCount = 0;
    for (var i = 0; i < influencers.length; i += 1) {
      var inflencer = influencers[i];
      if (selectedRows.isSelected(i)) {
        inflencer.selected = true;
        _selectedCount += 1;
      } else {
        inflencer.selected = false;
      }
    }
    notifyListeners();
  }

  @override
  DataRow? getRow(int index, [Color? color]) {
    // implement getRow
    assert(index >= 0);
    if (index >= influencers.length) throw 'index > _desserts.length';
    final influencer = influencers[index];
    return DataRow2.byIndex(
      index: index,
      selected: influencer.selected,
      color: color != null
          ? MaterialStateProperty.all(color)
          : (hasZebraStripes && index.isEven
              ? MaterialStateProperty.all(Theme.of(context).highlightColor)
              : null),
      onSelectChanged: (value) {
        if (influencer.selected != value) {
          _selectedCount += value! ? 1 : -1;
          assert(_selectedCount >= 0);
          influencer.selected = value;
          notifyListeners();
        }
      },
      cells: [
        DataCell(Text(influencer.id)),
        DataCell(ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            influencer.avatar,
            height: 80.0,
            width: 80.0,
          ),
        )),
        DataCell(Text(influencer.firstName)),
        DataCell(Text(influencer.lastName)),
        DataCell(Text(influencer.email)),
        DataCell(Text(influencer.location)),
        DataCell(Text(influencer.role)),
      ],
    );
  }

  @override
  // implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // implement rowCount
  int get rowCount => influencers.length;

  @override
  // implement selectedRowCount
  int get selectedRowCount => _selectedCount;
}
