import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rides_n_bikes/rnb_Widgets/Buttons/my_button.dart';
import 'package:rides_n_bikes/rnb_Widgets/brands_models.dart';
import 'package:rides_n_bikes/rnb_Widgets/post_card.dart';

class MotorcycleScreen extends StatefulWidget {
  const MotorcycleScreen({Key? key}) : super(key: key);

  @override
  _MotorcycleScreenState createState() => _MotorcycleScreenState();
}

class _MotorcycleScreenState extends State<MotorcycleScreen> {
  String? selectedBrand;
  String? selectedModel;
  bool showPosts = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Selected Bikes'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Motorrad Marke auswählen
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                hintText: 'Select Brand...',
                border: OutlineInputBorder(),
              ),
              value: selectedBrand,
              items: bikeBrands.map((String brand) {
                return DropdownMenuItem<String>(
                  value: brand,
                  child: Text(brand),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  selectedBrand = value;
                  selectedModel = null; // Modell zurücksetzen wenn sich Marke ändert
                });
              },
            ),
            const SizedBox(height: 20),
            // Modell der Marke auswählen
            if (selectedBrand != null)
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  hintText: 'Select Model...',
                  border: OutlineInputBorder(),
                ),
                value: selectedModel,
                items: bikeModels[selectedBrand!]!.map((String model) {
                  return DropdownMenuItem<String>(
                    value: model,
                    child: Text(model),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    selectedModel = value;
                  });
                },
              ),
            const SizedBox(height: 20),
            // Button um ausgewähltes Marke und Modell anzuzeigen.(noch ohne richtige Funktion)
            MyButton(
              text: 'Show Result',
              onTap: () {
                setState(() {
                  showPosts = true;
                });
              },
            ),
            const SizedBox(height: 20),

            // Beiträge nach ausgewählter Marke und Modell anzeigen
            if (showPosts)
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('posts').where('selectedBrand', isEqualTo: selectedBrand).where('selectedModel', isEqualTo: selectedModel).orderBy('datePublished', descending: true).snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasError) {
                      print('Error: ${snapshot.error}');
                      return const Center(
                        child: Text('Error loading posts'),
                      );
                    }
                    if (snapshot.data!.docs.isEmpty) {
                      return const Center(
                        child: Text('No posts found'),
                      );
                    }
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) => PostCard(
                        snap: snapshot.data!.docs[index].data(),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
