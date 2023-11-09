import 'package:flutter/material.dart';

Widget buildProfilPicture() => const CircleAvatar(
      radius: 60.0,
      backgroundImage: NetworkImage('https://images.unsplash.com/photo-1558981806-ec527fa84c39?auto=format&fit=crop&q=80&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
    );

Widget buildPostPicture() => const CircleAvatar(
      radius: 30.0,
      backgroundImage: NetworkImage('https://images.unsplash.com/photo-1558981806-ec527fa84c39?auto=format&fit=crop&q=80&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
    );

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
