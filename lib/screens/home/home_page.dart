import 'package:accommodation_review_app/model/places.dart';
import 'package:accommodation_review_app/screens/home/add_places.dart';
import 'package:flutter/material.dart';


import '../../repositories/places_repository.dart';
import 'places_list_item.dart';


class HomePage extends StatefulWidget {
  static const routeName = 'HomePage';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Places>? _places;
  var _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    getPlaces();
  }


  getPlaces() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    await Future.delayed(Duration(seconds: 2));

    try {
      var places = await ProvinceRepository ().getPlaces();
      setState(() {
        _places = places;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    buildLoadingOverlay() {
      return Container(
          color: Colors.black.withOpacity(0.2),
          child: Center(child: CircularProgressIndicator()));
    }
    buildError() => Center( // เกิด error
        child: Padding(
            padding: const EdgeInsets.all(40.0),
            child:
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(_errorMessage ?? '', textAlign: TextAlign.center),
              SizedBox(height: 32.0),
              ElevatedButton(onPressed: getPlaces, child: Text('Retry'))
            ])));

    buildList() => ListView.builder(
        itemCount: _places?.length ?? 0,
        itemBuilder: (ctx, i) {
          Places places = _places![i];
          return PlacesListItem(places: places);
        });

    handleClickAddReview() {
      Navigator.pushNamed(context, AddPlacesPage.routeName);
    }

    var size = MediaQuery.of(context).size;

    return Scaffold(
        floatingActionButton: FloatingActionButton(
            foregroundColor: Colors.black,
            backgroundColor: Color(0xFFFCDBFF),
            onPressed: handleClickAddReview,

            child: Icon(Icons.add_home)),

        body: Stack(
          children: [
            Container(
              height: size.height * .45,
              decoration: BoxDecoration(color: Color(0xFFD7F2FD)),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "Review \nAccommodation",
                        style: TextStyle(fontWeight: FontWeight.w900,fontSize: 40.0)
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 40.0),
                      padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search",
                          icon: Image.asset("assets/icon/search.png",height: 20.0,width: 20.0,color: Color(
                              0xFFB9B9B9),),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            if (_places?.isNotEmpty ?? false)
              Positioned(
                top: 350.0,
                left: 0.0,
                right: 0.0,
                bottom: 0.0,
                child: buildList(),
              ),
            if (_errorMessage != null)
              Positioned(
                top: 350.0,
                left: 0.0,
                right: 0.0,
                bottom: 0.0,
                child: buildError(),
              ),
            if (_isLoading)
              Positioned(
                top: 350.0,
                left: 0.0,
                right: 0.0,
                bottom: 0.0,
                child: buildLoadingOverlay(),
              ),
          ],
        ),
    );
  }
}


