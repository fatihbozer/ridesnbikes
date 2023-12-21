import 'package:flutter/material.dart';
import 'package:rides_n_bikes/rides_widgets/rides_post_home.dart';
import 'package:rides_n_bikes/rides_widgets/select_bike.dart';

class MotorcycleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Align(
                child: SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      Scaffold.of(context).showBottomSheet((context) => const SelectBike());
                    },
                    child: const Text('choose Motorcycle'),
                  ),
                ),
              ),
            ],
          ),
          const RidePostWidget(
            username: "Fatih",
            likes: "213 Persons liked this.",
            comments: "Show Comments...",
            description: "Description",
            time: "13:00",
          ),
          const RidePostWidget(
            username: "Fatih",
            likes: "213 Persons liked this.",
            comments: "Show Comments...",
            description: "Description",
            time: "13:00",
          ),
          const RidePostWidget(
            username: "Fatih",
            likes: "213 Persons liked this.",
            comments: "Show Comments...",
            description: "Description",
            time: "13:00",
          ),
          const RidePostWidget(
            username: "Fatih",
            likes: "213 Persons liked this.",
            comments: "Show Comments...",
            description: "Description",
            time: "13:00",
          ),
          const RidePostWidget(
            username: "Fatih",
            likes: "213 Persons liked this.",
            comments: "Show Comments...",
            description: "Description",
            time: "13:00",
          ),
          const RidePostWidget(
            username: "Fatih",
            likes: "213 Persons liked this.",
            comments: "Show Comments...",
            description: "Description",
            time: "13:00",
          ),
          const RidePostWidget(
            username: "Fatih",
            likes: "213 Persons liked this.",
            comments: "Show Comments...",
            description: "Description",
            time: "13:00",
          ),
          const RidePostWidget(
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
