import 'package:flutter/material.dart';
import 'package:rides_n_bikes/rides_widgets/rides_post_home.dart';
import 'package:rides_n_bikes/rides_widgets/select_bike.dart';

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
        children: const [
          RidePostWidget(
            username: "Fatih",
            likes: "213 Persons liked this.",
            comments: "Show Comments...",
            description: "Description",
            time: "13:00",
          ),
          RidePostWidget(
            username: "Fatih",
            likes: "213 Persons liked this.",
            comments: "Show Comments...",
            description: "Description",
            time: "13:00",
          ),
          RidePostWidget(
            username: "Fatih",
            likes: "213 Persons liked this.",
            comments: "Show Comments...",
            description: "Description",
            time: "13:00",
          ),
          RidePostWidget(
            username: "Fatih",
            likes: "213 Persons liked this.",
            comments: "Show Comments...",
            description: "Description",
            time: "13:00",
          ),
          RidePostWidget(
            username: "Fatih",
            likes: "213 Persons liked this.",
            comments: "Show Comments...",
            description: "Description",
            time: "13:00",
          ),
          RidePostWidget(
            username: "Fatih",
            likes: "213 Persons liked this.",
            comments: "Show Comments...",
            description: "Description",
            time: "13:00",
          ),
          RidePostWidget(
            username: "Fatih",
            likes: "213 Persons liked this.",
            comments: "Show Comments...",
            description: "Description",
            time: "13:00",
          ),
          RidePostWidget(
            username: "Fatih",
            likes: "213 Persons liked this.",
            comments: "Show Comments...",
            description: "Description",
            time: "13:00",
          ),
        ],
      ),
    );
  }
}
