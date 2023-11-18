import 'package:collection/collection.dart';
import 'reviews.dart';
class Places {
  final int id;
  final String name;
  final String picture;
  final double averageRating;
  final List<Review> reviews;

  Places({
    required this.id,
    required this.name,
    required this.picture,
    required this.averageRating,
    required this.reviews,
  });

  factory Places.fromJson(Map<String, dynamic> json){
    List<Review> reviews =
    json['reviews'].map<Review>((item) => Review.fromJson(item)).toList();
    var averageRating = 0.0; //ถ้าไม่มี review ก้อจะให้เป็น 0
    if (reviews.isNotEmpty) { // check ว่ามี review
      averageRating = reviews.map((review) => review.rating).average;
    }

    return Places(  //return object please
      id: json['id'],
      name: json['name'],
      picture: json['picture'],
      averageRating: averageRating,
      reviews: reviews,
    ); // เอา object map ใส่เข้าไปใน object places

  }

}
