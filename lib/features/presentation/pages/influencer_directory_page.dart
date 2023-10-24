import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_admin/features/presentation/providers/influencer_provider.dart';
import 'package:simple_admin/features/presentation/widgets/tag_widget.dart';

class InfluencerDirectoryPage extends StatefulWidget {
  const InfluencerDirectoryPage({super.key});

  @override
  State<InfluencerDirectoryPage> createState() =>
      _InfluencerDirectoryPageState();
}

class _InfluencerDirectoryPageState extends State<InfluencerDirectoryPage> {
  void _sort<T>(
    // Comparable<T> Function(Dessert d) getField,
    int columnIndex,
    bool ascending,
  ) {
    // _dessertsDataSource.sort<T>(getField, ascending);
    setState(() {
      _sortColumnIndex.value = columnIndex;
      _sortAscending.value = ascending;
    });
  }

  final RestorableBool _sortAscending = RestorableBool(true);
  final RestorableIntN _sortColumnIndex = RestorableIntN(null);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<InfluencerProvider>().getInfluencer(1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 244, 237),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Title
            Container(
              height: 58,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                stops: const [
                  0.1,
                  0.4,
                  0.6,
                  0.9,
                ],
                colors: [
                  const Color.fromARGB(255, 255, 65, 211),
                  const Color.fromARGB(255, 206, 29, 164),
                  Colors.purple.shade500,
                  Colors.purple.shade700,
                ],
              )),
              child: const Center(
                child: Text(
                  'Influencer Directory',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
            // Tags
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      TagWidget(onChange: (value) {}),
                      TagWidget(onChange: (value) {}),
                      TagWidget(onChange: (value) {}),
                      TagWidget(onChange: (value) {}),
                      TagWidget(onChange: (value) {}),
                      TagWidget(onChange: (value) {}),
                    ],
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  const Text(
                    'Clear all',
                    style: TextStyle(color: Colors.red),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  // search
                  Container(
                    width: 220,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.search),
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration.collapsed(
                                hintText: 'Search'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // table
                  Container(
                    height: 500,
                    padding: const EdgeInsets.all(16),
                    child: DataTable2(
                        columnSpacing: 12,
                        horizontalMargin: 12,
                        minWidth: 600,
                        columns: [
                          DataColumn2(
                            label: Text('Column A'),
                            size: ColumnSize.L,
                          ),
                          DataColumn(
                            label: Text('Column B'),
                          ),
                          DataColumn(
                            label: Text('Column C'),
                          ),
                          DataColumn(
                            label: Text('Column D'),
                          ),
                          DataColumn(
                            label: Text('Column NUMBERS'),
                            numeric: true,
                          ),
                        ],
                        rows: List<DataRow>.generate(
                            100,
                            (index) => DataRow(cells: [
                                  DataCell(Text('A' * (10 - index % 10))),
                                  DataCell(Text('B' * (10 - (index + 5) % 10))),
                                  DataCell(Text('C' * (15 - (index + 5) % 10))),
                                  DataCell(
                                      Text('D' * (15 - (index + 10) % 10))),
                                  DataCell(
                                      Text(((index + 0.1) * 25.4).toString()))
                                ]))),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
