import 'package:flutter/material.dart';

class MotorcycleScreen extends StatefulWidget {
  const MotorcycleScreen({Key? key}) : super(key: key);

  @override
  _MotorcycleScreenState createState() => _MotorcycleScreenState();
}

class _MotorcycleScreenState extends State<MotorcycleScreen> {
  String? selectedBrand;
  String? selectedModel;

  final List<String> brands = [
    'Harley-Davidson',
    'Ducati',
    'Yamaha',
    'Honda',
    'BMW Motorrad',
    'KTM',
    'Triumph',
    'Kawasaki',
    'Suzuki',
    'Aprilia',
    'Moto Guzzi',
    'Indian Motorcycle',
    'Husqvarna',
    'Royal Enfield',
    'Zero Motorcycles',
  ]; // Beispielmarken
  final Map<String, List<String>> modelsPerBrand = {
    'Harley-Davidson': [
      'Cruiser',
      'Touring',
      'Sportster'
    ],
    'Ducati': [
      'Sportbike',
      'Naked Bike',
      'Adventure Touring',
      'Cruiser'
    ],
    'Yamaha': [
      'Sportbike',
      'Naked Bike',
      'Adventure Touring',
      'Cruiser'
    ],
    'Honda': [
      'Sportbike',
      'Adventure Touring',
      'Cruiser',
      'Standard'
    ],
    'BMW Motorrad': [
      'Sportbike',
      'Adventure Touring',
      'Naked Bike',
      'Touring'
    ],
    'KTM': [
      'Sportbike',
      'Adventure Touring',
      'Naked Bike',
      'Dual-Sport'
    ],
    'Triumph': [
      'Cruiser',
      'Street Twin',
      'Adventure Touring',
      'Sportbike'
    ],
    'Kawasaki': [
      'Sportbike',
      'Naked Bike',
      'Adventure Touring',
      'Cruiser'
    ],
    'Suzuki': [
      'Sportbike',
      'Adventure Touring',
      'Naked Bike',
      'Cruiser'
    ],
    'Aprilia': [
      'Sportbike',
      'Naked Bike',
      'Adventure Touring',
      'Cruiser'
    ],
    'Moto Guzzi': [
      'Cruiser',
      'Adventure Touring',
      'Naked Bike',
      'Touring'
    ],
    'Indian Motorcycle': [
      'Cruiser',
      'Touring',
      'Sportbike',
      'Standard'
    ],
    'Husqvarna': [
      'Naked Bike',
      'Dual-Sport',
      'Adventure Touring',
      'Supermoto'
    ],
    'Royal Enfield': [
      'Classic',
      'Adventure Touring',
      'Cruiser',
      'Standard'
    ],
    'Zero Motorcycles': [
      'Electric Sportbike',
      'Electric Dual Sport',
      'Electric Supermoto'
    ],
  };
  // Beispielmodelle pro Marke

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
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Select Brand',
                border: OutlineInputBorder(),
              ),
              value: selectedBrand,
              items: brands.map((String brand) {
                return DropdownMenuItem<String>(
                  value: brand,
                  child: Text(brand),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  selectedBrand = value;
                  selectedModel = null; // Reset model when brand changes
                });
              },
            ),
            SizedBox(height: 20),
            if (selectedBrand != null)
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Select Model',
                  border: OutlineInputBorder(),
                ),
                value: selectedModel,
                items: modelsPerBrand[selectedBrand!]!.map((String model) {
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
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (selectedBrand != null && selectedModel != null) {
                  // Hier können Sie Ihre Logik einfügen, um das Ergebnis basierend auf der Auswahl anzuzeigen
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text('Selected Bike'),
                      content: Text('Brand: $selectedBrand\nModel: $selectedModel'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Close'),
                        ),
                      ],
                    ),
                  );
                } else {
                  // Wenn kein Modell oder Marke ausgewählt wurde
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please select both brand and model.'),
                    ),
                  );
                }
              },
              child: Text('Show Result'),
            ),
          ],
        ),
      ),
    );
  }
}
