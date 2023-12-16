import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tour/AppColors/colors.dart';
import 'package:tour/Pages/addresturant.dart';
import 'package:tour/Pages/resturantdetails.dart';

class RestaurantList extends StatelessWidget {
  final CollectionReference restaurants = FirebaseFirestore.instance.collection('amman_restaurants');
  final FirebaseStorage _storage = FirebaseStorage.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundcolor,
      appBar: AppBar(
        title: const Text('Restaurant&Cafes List', style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.buttomcolor,
      ),
      body: StreamBuilder(
        stream: restaurants.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }

          var restaurantList = snapshot.data!.docs;

          return ListView.builder(
            itemCount: restaurantList.length,
            itemBuilder: (context, index) {
              var restaurant = restaurantList[index].data() as Map<String, dynamic>;

              return FutureBuilder(
                future: _storage.ref('amman_resturant/${restaurant['image']}').getDownloadURL(),
                builder: (BuildContext context, AsyncSnapshot<String> imageSnapshot) {
                  if (imageSnapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (imageSnapshot.hasError) {
                    print('Error loading image: ${imageSnapshot.error}');
                    return Text('Error loading image');
                  } else if (imageSnapshot.data == null) {
                    print('Image URL is null');
                    return Text('Image not found');
                  } else {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RestaurantDetails(restaurant: restaurant),
                              ),
                            );
                          },
                          child: Image.network(
                            imageSnapshot.data!,
                            height: 250,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          )
                        ),
                        ListTile(
                          title: Text(restaurant['name'] ,style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Classification: ${restaurant['classification']}',style: const TextStyle(fontWeight: FontWeight.bold)),
                              Row(
                                children: [
                                  RatingBar.builder(
                                    initialRating: double.parse(restaurant['rating'].toString()),
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemSize: 20.0,  //the size of the stars
                                    itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                        color: Colors.amber,
                                ),
                                      onRatingUpdate: (rating) {
                                        //req parameter for rating
  },
),
                                ],
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RestaurantDetails(restaurant: restaurant),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  }
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddRestaurantPage(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
