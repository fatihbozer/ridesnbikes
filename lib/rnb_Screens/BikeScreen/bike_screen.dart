import 'package:flutter/material.dart';
import 'package:rides_n_bikes/rnb_Widgets/post_card.dart';
import 'package:rides_n_bikes/rnb_Screens/BikeScreen/features/select_bike.dart';

class MotorcycleScreen extends StatelessWidget {
  const MotorcycleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: IconButton(
                onPressed: () {
                  Scaffold.of(context).showBottomSheet((context) => const SelectBike());
                },
                icon: const Icon(Icons.motorcycle_outlined)),
          ),
        ],
        title: const Text('selected Bikes'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        children: const [],
      ),
    );
  }
}
