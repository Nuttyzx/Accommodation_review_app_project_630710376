import 'package:accommodation_review_app/model/places.dart';
import 'package:accommodation_review_app/screens/home/add_places.dart';
import 'package:accommodation_review_app/screens/home/home_page.dart';
import 'package:accommodation_review_app/screens/home/review_page.dart';
import 'package:accommodation_review_app/screens/home/start_page.dart';

import 'package:flutter/material.dart';

import 'screens/home/add_review.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {



  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),


      initialRoute: '/',
      routes: { //เส้นทาง เปลี่ยนหน้า
        '/': (context) => StartPage(),
        HomePage.routeName: (context) => HomePage(),
        AddReviewPage.routeName: (context) => AddReviewPage(),
        AddPlacesPage.routeName: (context) => AddPlacesPage(),
      },

      onGenerateRoute: (settings) {
        if (settings.name == ReviewPage.routeName) {
          return MaterialPageRoute(
            builder: (context) => ReviewPage(places: settings.arguments as Places),
          );
        }
        return null;
      },
    );
  }
}
