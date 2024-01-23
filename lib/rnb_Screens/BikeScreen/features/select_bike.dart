import 'package:flutter/material.dart';
import 'package:rides_n_bikes/rnb_Screens/BikeScreen/features/rides_bikechip.dart';

class SelectBike extends StatelessWidget {
  const SelectBike({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 500,
      child: Column(
        children: [
          SizedBox(height: 16),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 30),
              ),
              Icon(Icons.pedal_bike),
              Padding(
                padding: EdgeInsets.only(left: 20),
              ),
              Text(
                'Motorrad Typ',
                style: TextStyle(fontFamily: 'Formula1bold', fontSize: 16),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BikeChip(text: 'Chopper'),
              BikeChip(text: 'Naked Bike'),
              BikeChip(text: 'Motocross'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BikeChip(text: 'Touring'),
              BikeChip(text: 'Superbikes'),
              BikeChip(text: 'Enduro'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BikeChip(text: 'Motorroller'),
              BikeChip(text: 'Cafe Racer/Scrambler'),
            ],
          ),
          Divider(),
          SizedBox(height: 16),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 30),
              ),
              Icon(Icons.pedal_bike),
              Padding(
                padding: EdgeInsets.only(left: 20),
              ),
              Text(
                'Marke',
                style: TextStyle(fontFamily: 'Formula1bold', fontSize: 16),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BikeChip(text: 'Aprilia'),
              BikeChip(text: 'BMW'),
              BikeChip(text: 'Honda'),
              BikeChip(text: 'Ducati'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BikeChip(text: 'Husqvarna'),
              BikeChip(text: 'Indian'),
              BikeChip(text: 'Harley-Davidson'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BikeChip(text: 'KTM'),
              BikeChip(text: 'Kawasaki'),
              BikeChip(text: 'Suzuki'),
              BikeChip(text: 'Triumph'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BikeChip(text: 'Vespa'),
              BikeChip(text: 'Yamaha'),
            ],
          ),
        ],
      ),
    );
  }
}
