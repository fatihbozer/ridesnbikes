import 'package:flutter/material.dart';
import 'package:rides_n_bikes/rides_widgets/rides_post_home.dart';
import 'package:rides_n_bikes/rides_widgets/rides_select_bike.dart';

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
              Container(
                child: Align(
                  child: SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        Scaffold.of(context).showBottomSheet((context) => SelectBike());
                      },
                      child: Text('choose Motorcycle'),
                    ),
                  ),
                ),
              ),
            ],
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
