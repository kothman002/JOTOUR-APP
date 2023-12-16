import 'package:flutter/material.dart';

class RestaurantDetails extends StatelessWidget {
  final Map<String, dynamic> restaurant;

  RestaurantDetails({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant['name']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Classification: ${restaurant['classification']}'),
            Text('Location: ${restaurant['location']}'),
            Text('Working Hours: ${restaurant['workingHours']}'),
            Text('Phone Number: ${restaurant['phoneNumber']}'),
          ],
        ),
      ),
    );
  }
}
