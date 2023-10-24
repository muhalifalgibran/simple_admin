import 'package:flutter/material.dart';

class PagerWidget extends StatefulWidget {
  const PagerWidget({
    required this.currentPage,
    required this.totalPage,
    required this.onUpdate,
    super.key,
  });
  final int currentPage;
  final int totalPage;
  final Function(int) onUpdate;

  @override
  State<PagerWidget> createState() => _PagerWidgetState();
}

class _PagerWidgetState extends State<PagerWidget> {
  int _page = 1;
  @override
  void initState() {
    super.initState();
    _page = widget.currentPage;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // invisible if the first page
        SizedBox(
          width: 30,
          child: Visibility(
            visible: widget.currentPage > 1,
            child: GestureDetector(
                onTap: () {
                  // make lower boundaries
                  if (_page > 1) widget.onUpdate(_page -= 1);
                },
                child: const Icon(Icons.chevron_left)),
          ),
        ),
        Container(
          width: 130,
          margin: const EdgeInsets.symmetric(horizontal: 2),
          child: Text('Page ${widget.currentPage} of ${widget.totalPage}'),
        ),
        // invisible if reach the max page
        SizedBox(
          width: 30,
          child: Visibility(
            visible: _page != widget.totalPage,
            child: GestureDetector(
                onTap: () {
                  // make higher boundaries
                  if (_page < widget.totalPage) widget.onUpdate(_page += 1);
                },
                child: const Icon(Icons.chevron_right)),
          ),
        ),
      ],
    );
  }
}
