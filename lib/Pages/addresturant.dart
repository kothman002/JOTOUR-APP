import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddRestaurantPage extends StatefulWidget {
  @override
  _AddRestaurantPageState createState() => _AddRestaurantPageState();
}

class _AddRestaurantPageState extends State<AddRestaurantPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController evaluationController = TextEditingController();
  final TextEditingController workingHoursController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController famousDishController = TextEditingController();

  String selectedClassification = 'Popular';

  final CollectionReference restaurants =
      FirebaseFirestore.instance.collection('amman_restaurants');

  final List<String> classifications = ['Popular', 'Tourist'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Restaurant'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            DropdownButtonFormField<String>(
              value: selectedClassification,
              onChanged: (String? value) {
                setState(() {
                  selectedClassification = value!;
                });
              },
              items: classifications
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: const InputDecoration(labelText: 'Classification'),
            ),
            TextField(
              controller: locationController,
              decoration: const InputDecoration(labelText: 'Location'),
            ),
            TextField(
              controller: evaluationController,
              decoration: const InputDecoration(labelText: 'Evaluation'),
            ),
            TextField(
              controller: workingHoursController,
              decoration: const InputDecoration(labelText: 'Working Hours'),
            ),
            TextField(
              controller: phoneNumberController,
              decoration: const InputDecoration(labelText: 'Phone Number'),
            ),
            TextField(
              controller: famousDishController,
              decoration: const InputDecoration(labelText: 'The Famous Dish'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                restaurants.add({
                  'name': nameController.text,
                  'classification': selectedClassification,
                  'location': locationController.text,
                  'evaluation': evaluationController.text,
                  'workingHours': workingHoursController.text,
                  'phoneNumber': phoneNumberController.text,
                  'famousDish': famousDishController.text,
                });

                nameController.clear();
                locationController.clear();
                evaluationController.clear();
                workingHoursController.clear();
                phoneNumberController.clear();
                famousDishController.clear();

                Navigator.pop(context);
              },
              child: const Text('Add Restaurant'),
            ),
          ],
        ),
      ),
    );
  }
} 