import 'package:flutter/material.dart';
import 'package:rides_n_bikes/rides_widgets/rides_widgets.dart';

class SelectBike extends StatelessWidget {
  const SelectBike({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.pedal_bike),
              Text('Modelle'),
            ],
          ),
          Row(
            children: [
              BikeChip(text: 'BMW'),
              BikeChip(text: 'Honda'),
            ],
          ),
          Row(
            children: [
              BikeChip(text: 'BMW'),
              BikeChip(text: 'Honda'),
            ],
          ),
          Divider(),
          Row(
            children: [
              Icon(Icons.pedal_bike),
              Text('Marke'),
            ],
          ),
          Row(
            children: [
              BikeChip(text: 'BMW'),
              BikeChip(text: 'Honda'),
            ],
          ),
        ],
      ),
    );
  }
}
