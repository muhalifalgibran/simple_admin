import 'package:flutter/material.dart';

class TagWidget extends StatefulWidget {
  const TagWidget({
    this.items,
    required this.onChange,
    required this.value,
    super.key,
  });

  final List<String>? items;
  final String value;
  final Function(String value) onChange;

  @override
  State<TagWidget> createState() => _TagWidgetState();
}

class _TagWidgetState extends State<TagWidget> {
  List<String> list = <String>['One', 'Two', 'Three', 'Four'];

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: Container(
        width: 180,
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: DropdownButton(
          underline: const SizedBox(),
          focusColor: Colors.transparent,
          isExpanded: true,
          items: widget.items?.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList() ??
              list.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
          value: widget.value,
          onChanged: (value) {
            setState(() {
              widget.onChange(value.toString());
            });
          },
        ),
      ),
    );
  }
}
