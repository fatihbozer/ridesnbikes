import 'package:flutter/material.dart';

class BikeChip extends StatefulWidget {
  final String text;

  const BikeChip({super.key, required this.text});

  @override
  State<BikeChip> createState() => _BikeChipsState();
}

class _BikeChipsState extends State<BikeChip> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FilterChip(
        label: Text(widget.text),
        selected: isSelected,
        onSelected: (bool value) {
          setState(() {
            isSelected = !isSelected;
          });
        },
      ),
    );
  }
}
