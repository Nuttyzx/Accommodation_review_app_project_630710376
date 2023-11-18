import 'package:accommodation_review_app/screens/home/add_review.dart';
import 'package:accommodation_review_app/screens/home/review_list_item.dart';
import 'package:flutter/material.dart';

import '../../model/places.dart';
import '../../model/reviews.dart';


class ReviewPage extends StatelessWidget {
  static const routeName = 'review_page';

  final Places places;

  const ReviewPage({
    super.key,
    required this.places,

  });


  @override
  Widget build(BuildContext context) {

    buildList() => ListView.builder(
      itemCount: places.reviews.length ?? 0,
      itemBuilder: (ctx, i) {
        Review review =  places.reviews![i];
        return ReviewListItem(reviews: review);
      },
    );

    handleClickAddReview() {
      Navigator.pushNamed(context, AddReviewPage.routeName);
    }

    return Scaffold(
    backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
          onPressed: handleClickAddReview,
          foregroundColor: Colors.black,
          backgroundColor: Color(0xFFFCDBFF),
          child: Icon(Icons.add_comment)),

      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(15.0),
                  height: 350,
                  width: double.infinity,
                  alignment: Alignment.topLeft,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(places.picture),
                          fit: BoxFit.fill)
                  ),
                  child: InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.45,
                  margin: EdgeInsets.only(top: 15.0),
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFF5cEBB),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    )
                  ),
                )
              ],
            ),
          ),

          Positioned(
            top: 400,
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: buildList(),
          ),

        ],
      ),
    );
  }
}
