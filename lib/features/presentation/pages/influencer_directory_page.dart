import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_admin/features/domain/entities/influencer_data_table.dart';
import 'package:simple_admin/features/presentation/providers/influencer_provider.dart';
import 'package:simple_admin/features/presentation/widgets/custom_pager.dart';
import 'package:simple_admin/features/presentation/widgets/tag_widget.dart';

class InfluencerDirectoryPage extends StatefulWidget {
  const InfluencerDirectoryPage({super.key});

  @override
  State<InfluencerDirectoryPage> createState() =>
      _InfluencerDirectoryPageState();
}

class _InfluencerDirectoryPageState extends State<InfluencerDirectoryPage> {
  PaginatorController? _pageController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<InfluencerProvider>().getInfluencer(context, 1);
      _pageController = PaginatorController();
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
                  // give ir wrap. in case, the tags is full in width
                  // so we put our tags below other tags
                  Wrap(
                    children: [
                      TagWidget(
                        onChange: (value) {},
                        items: const [
                          'Jakarta',
                          'Bandung',
                          'Surabaya',
                          'Makassar',
                          'Medan',
                          'Bali',
                          'Papua',
                          'Aceh',
                          'Solo',
                          'Yogyakarta'
                        ],
                      ),
                      const SizedBox(width: 40),
                      TagWidget(
                        onChange: (value) {},
                        items: const [
                          'Food',
                          'Travel',
                          'Marketing',
                          'Backoffice',
                          'Engineer',
                          'Education',
                          'Human Resource',
                        ],
                      ),
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
                  // search widget
                  Card(
                    elevation: 8,
                    child: Container(
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
                                hintText: 'Search',
                              ),
                              onChanged: (value) {
                                context
                                    .read<InfluencerProvider>()
                                    .search(value);
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // table
                  // _pageController.
                  Container(
                    height: 500,
                    padding: const EdgeInsets.all(16),
                    child: PaginatedDataTable2(
                      headingRowColor: MaterialStateColor.resolveWith(
                          (states) => Colors.grey[200]!),
                      source: context
                          .select<InfluencerProvider, InfluencerDataTable>(
                              (value) =>
                                  value.dataTable ??
                                  InfluencerDataTable.empty(context)),
                      columnSpacing: 12,
                      rowsPerPage: 6,
                      horizontalMargin: 12,
                      wrapInCard: true,
                      minWidth: 800,
                      sortColumnIndex:
                          context.read<InfluencerProvider>().sortColumnIndex,
                      sortAscending:
                          context.read<InfluencerProvider>().sortAscending,
                      sortArrowIcon: Icons.keyboard_arrow_up,
                      sortArrowAnimationDuration: Duration.zero,
                      controller: _pageController,
                      empty: Center(
                          child: Container(
                              padding: const EdgeInsets.all(20),
                              color: Colors.grey[200],
                              child: const Text('No data'))),
                      header: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Table of influencer'),
                            if (_pageController != null)
                              PageNumber(controller: _pageController!)
                          ]),
                      border: TableBorder(
                        top: const BorderSide(color: Colors.black),
                        bottom: BorderSide(color: Colors.grey[300]!),
                        left: BorderSide(color: Colors.grey[300]!),
                        right: BorderSide(color: Colors.grey[300]!),
                        verticalInside: BorderSide(color: Colors.grey[300]!),
                        horizontalInside:
                            const BorderSide(color: Colors.grey, width: 1),
                      ),
                      columns: [
                        DataColumn2(
                          label: const Text('ID'),
                          size: ColumnSize.S,
                          onSort: (columnIndex, ascending) {
                            context.read<InfluencerProvider>().sort<String>(
                                (d) => d.id, columnIndex, ascending);
                            setState(() {});
                          },
                        ),
                        const DataColumn(
                          label: Text('Avatar'),
                        ),
                        DataColumn(
                          label: const Text('First Name'),
                          onSort: (columnIndex, ascending) {
                            context.read<InfluencerProvider>().sort<String>(
                                (d) => d.firstName, columnIndex, ascending);
                            setState(() {});
                          },
                        ),
                        DataColumn(
                          label: const Text('Last Name'),
                          onSort: (columnIndex, ascending) {
                            context.read<InfluencerProvider>().sort<String>(
                                (d) => d.lastName, columnIndex, ascending);
                            setState(() {});
                          },
                        ),
                        DataColumn2(
                          label: const Text('Email'),
                          size: ColumnSize.L,
                          onSort: (columnIndex, ascending) {
                            context.read<InfluencerProvider>().sort<String>(
                                (d) => d.email, columnIndex, ascending);
                            setState(() {});
                          },
                        ),
                        DataColumn(
                          label: const Text('Location'),
                          onSort: (columnIndex, ascending) {
                            context.read<InfluencerProvider>().sort<String>(
                                (d) => d.location, columnIndex, ascending);
                            setState(() {});
                          },
                        ),
                        DataColumn(
                          label: const Text('Role'),
                          onSort: (columnIndex, ascending) {
                            context.read<InfluencerProvider>().sort<String>(
                                (d) => d.role, columnIndex, ascending);
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
