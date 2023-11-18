import 'package:flutter/material.dart';

import '../../model/places.dart';
import 'review_page.dart';

class PlacesListItem extends StatelessWidget {
  static const iconSize = 25.0;

  final Places places;

  const PlacesListItem({
    super.key,
    required this.places,
  });

  @override
  Widget build(BuildContext context) {
    var hasRating =
        places.averageRating > 0;
    var numWholeStar = places.averageRating.truncate();
    var fraction = places.averageRating - numWholeStar;
    var showHalfStar = fraction >= 0.5;
    var numBlankStar = 5 - numWholeStar - (showHalfStar ? 1 : 0);

    handleClickReview() {
      Navigator.pushNamed(context, ReviewPage.routeName,arguments: places);
    }

    return Card(

        child: Column(children: [
      Container(
        margin: EdgeInsets.only(top: 20.0),
        child: Image.network(
          places.picture,
          fit: BoxFit.fill,
          width: 500.0,
          height: 300.0,
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0 , horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(places.name,
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w900,
                    fontSize: 30.0)),
            Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              hasRating
                  ? Row(children: [
                      for (var i = 0; i < numWholeStar; i++)
                        Icon(
                          Icons.star,
                          size: iconSize,
                          color: Color(0xFFF5C83F),
                        ),
                      if (showHalfStar)
                        Icon(Icons.star_half,
                            size: iconSize, color: Color(0xFFF5C83F)),
                      // .5 ขึ้นไป แสดงดาวครึ่งดวง
                      for (var i = 0; i < numBlankStar; i++)
                        Icon(Icons.star_border,
                            size: iconSize, color: Color(0xFFF5C83F)),
                    ])
                  : Text('ยังไม่มีคะแนน'), // false
            ]),
          ],
        ),
      ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0 , horizontal: 10.0),
            child: Row(
              children: [
                TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  onPressed: (handleClickReview) ,
                  child: Text('See Review'),
                )
              ],
            ),
          )
    ]));
  }
}
