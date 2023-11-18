import 'package:accommodation_review_app/repositories/places_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddPlacesPage extends StatefulWidget {
  static const routeName = 'add_places';

  const AddPlacesPage({super.key});

  @override
  State<AddPlacesPage> createState() => _AddPlacesPageState();
}

class _AddPlacesPageState extends State<AddPlacesPage> {
  var _isLoading = false;
  String? _errorMessage;

  final _placesNameController = TextEditingController();

  validateForm() {
    return _placesNameController.text.isNotEmpty;
  }

  saveReview() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    await Future.delayed(Duration(seconds: 2));
    try {
      var placesName = _placesNameController.text;

      await ProvinceRepository().addPlaces(name: placesName);
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
    buildLoadingOverlay() => Container(
        color: Colors.black.withOpacity(0.2),
        child: Center(child: CircularProgressIndicator()));

    buildError() => Center(
        // เกิด error
        child: Padding(
            padding: const EdgeInsets.all(40.0),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(_errorMessage ?? '', textAlign: TextAlign.center),
              SizedBox(height: 32.0),
              ElevatedButton(onPressed: saveReview, child: Text('Retry'))
            ])));

    handleClickSave() {
      if (validateForm()) {
        saveReview();
      }
    }

    buildForm() => SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.all(50.0),
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Color(0xFFD7F2FD),
              borderRadius: BorderRadius.circular(50.0),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: TextField(
                    controller: _placesNameController,
                    decoration: InputDecoration(
                      hintText: 'name',
                      hintStyle:
                          TextStyle(color: Colors.black38, fontSize: 15.0),
                      labelText: "Places Name",
                      labelStyle: TextStyle(fontSize: 20.0),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          borderSide:
                              BorderSide(color: Colors.deepPurpleAccent)),
                      prefixIcon: Icon(
                        Icons.home,
                        color: Colors.black38,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: handleClickSave,
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFDECFE8),
                      onPrimary: Colors.white,
                    ),
                    child: Text('SAVE'),
                  ),
                ),
              ],
            )));

    return Scaffold(
        //หน้าจอ
        appBar: AppBar(
            title: Text('ADD PLACES'), backgroundColor: Color(0xFFD7F2FD)),
        //backgroundColor: Color(0xFFD7F2FD),
        body: Stack(
          children: [
            buildForm(),
            if (_isLoading) buildLoadingOverlay(),
            if (_errorMessage != null) buildError(),
          ],
        ));
  }
}
