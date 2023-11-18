// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
/*
import 'package:flutter/material.dart';
import 'package:public_toilets/model/toilet.dart';

class ToiletListItem extends StatelessWidget {
  final Toilet toilet;

  const ToiletListItem({
    super.key,
    required this.toilet,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(Icons.home, size: 30.0),
            Expanded(
              child: Text(
                toilet.name,
                style: TextStyle(fontSize: 24.0, color: Colors.red),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    // collection if, ไม่ใช่ if statement
                    if (toilet.point > 2.5)
                      Text('GOOD'),

                    // collection for, ไม่ใช่ for statement
                    for (var i = 0; i < toilet.point.floor(); i++)
                      Icon(Icons.star),

                    Text(toilet.point.toString())
                  ],
                ),
                Text(toilet.distance.toString())
              ],
            ),
          ],
        ),
      ),
    );
  }
}
*/

import 'package:accommodation_review_app/model/reviews.dart';

import 'package:flutter/material.dart';

class ReviewListItem extends StatelessWidget {
  static const iconSize = 18.0;

  final Review reviews;

  const ReviewListItem({
    super.key,
    required this.reviews,
  });

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    var hasRating = reviews.rating > 0;
    var numWholeStar = reviews.rating.truncate();
    var fraction = reviews.rating - numWholeStar;
    var showHalfStar = fraction >= 0.5;
    var numBlankStar = 5 - numWholeStar - (showHalfStar ? 1 : 0);

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 60.0,
              height: 60.0,
              color: colorScheme.background,
              child: Center(
                  child:
                      Image.network(reviews.avatar, height: 50.0, width: 50.0)),
            ),
            SizedBox(width: 20.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(reviews.name, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                      Text(reviews.date, style: TextStyle(color: Colors.black45, fontSize: 12.0)),
                    ],
                  ),

                  SizedBox(height: 4.0),
                  Row(
                    children: [
                      if (hasRating)
                        Row(
                          children: [
                            for (var i = 0; i < numWholeStar; i++)
                              Icon(Icons.star, size: iconSize, color: Colors.red),
                            if (showHalfStar)
                              Icon(Icons.star_half, size: iconSize, color: Colors.red),
                            for (var i = 0; i < numBlankStar; i++)
                              Icon(Icons.star_border,
                                  size: iconSize, color: Colors.red),
                          ],
                        )
                      else
                        Text('ยังไม่มีคะแนน'), // false
                      SizedBox(width: 8.0),
                      Text("rating: " + reviews.rating.toString(), style: TextStyle(color: Colors.black45, fontSize: 12.0)),
                    ],
                  ),
                  SizedBox(height: 15.0),
                  Row(children: [
                    Expanded(
                      child: Text("Review: " ,style: TextStyle(fontSize: 15.0 , fontWeight: FontWeight.w900),),
                    ),
                  ],),
                  SizedBox(height: 8.0,),
                  Container(
                    child: Row(children: [
                      SizedBox(width: 20.0,),
                      Expanded(
                        child: Text(reviews.comment),
                      ),
                    ],),
                  ),
                  Container(
                    child: Row(children: [
                      SizedBox(width: 20.0,),
                      Image.network(reviews.photo,width: 300.0,height: 300.0)
                    ],),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
