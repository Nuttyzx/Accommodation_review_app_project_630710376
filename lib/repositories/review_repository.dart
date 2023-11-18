import 'dart:convert';

import 'package:accommodation_review_app/model/reviews.dart';
import '../services/api_caller.dart';

class ReviewRepository {

  Future<List<Review>> getReview() async {
    var result = await ApiCaller().get('locations?_embed=reviews');
    List list = jsonDecode(result);
    List<Review> reviewList =
    list.map<Review>((item) => Review.fromJson(item)).toList();

    return reviewList;
  }

  Future<void> addReview(
          {required String name, required double rating , required String comment}) async {
    try {
      var result = await ApiCaller()
          .post('reviews', params: {'name': name, 'rating': rating, 'comment': comment});
    } catch (e) {
      // TODO:
      rethrow;
    }
  }
}
