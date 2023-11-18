import 'package:accommodation_review_app/screens/home/home_page.dart';
import 'package:flutter/material.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD7F2FD),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/icon/house.jpg",height: 300.0,),
            Container(
              margin: EdgeInsets.only(top: 50.0),
              child: Text("Review Accommodation",style: TextStyle(color: Colors.white,fontSize: 35,fontWeight: FontWeight.bold),),
            ),
            SizedBox(height: 50,),
            InkWell(
              onTap: (){
                Navigator.pushReplacementNamed(context, HomePage.routeName);
              },
              child: Ink(
                padding: EdgeInsets.symmetric(horizontal: 80.0,vertical: 16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.white,
                ),
                child: Text("Get Started",style: TextStyle(color: Color(0xFFF5cEBB),fontSize: 18.0,fontWeight: FontWeight.bold),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
