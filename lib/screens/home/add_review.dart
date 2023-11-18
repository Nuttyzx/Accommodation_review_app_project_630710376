import 'package:accommodation_review_app/repositories/review_repository.dart';
import 'package:flutter/material.dart';


class AddReviewPage extends StatefulWidget {
  static const routeName = 'add_review';

  const AddReviewPage({super.key});

  @override
  State<AddReviewPage> createState() => _AddReviewPageState();
}

class _AddReviewPageState extends State<AddReviewPage> {
  var _isLoading = false;
  String? _errorMessage;

  final _userNameController = TextEditingController();
  final _ratingController = TextEditingController();
  final _commentController = TextEditingController();

  validateForm() {
    return _userNameController.text.isNotEmpty &&
        _ratingController.text.isNotEmpty &&
        _commentController.text.isNotEmpty;
  }

  saveReview() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    await Future.delayed(Duration(seconds: 2));

    try {
      var userName = _userNameController.text;
      var rating = double.parse(_ratingController.text); // แปลงจาก text เปน double
      var comment = _commentController.text;


      await ReviewRepository().addReview(name: userName, rating: rating, comment: comment);

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
                    controller: _userNameController,
                    decoration: InputDecoration(
                      hintText: 'name',
                      hintStyle: TextStyle(color: Colors.black38,fontSize: 15.0),
                      labelText: "User Name",
                      labelStyle: TextStyle(fontSize: 20.0),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          borderSide: BorderSide(color: Colors.deepPurpleAccent)
                      ),
                      prefixIcon: Icon(Icons.person_outline,color: Colors.black38,),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: TextField(
                    controller: _ratingController,
                    decoration: InputDecoration(
                      hintText: 'Score',
                      hintStyle: TextStyle(color: Colors.black38,fontSize: 15.0),
                      labelText: "Rating",
                      labelStyle: TextStyle(fontSize: 20.0),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          borderSide: BorderSide(color: Colors.deepPurpleAccent)
                      ),
                      prefixIcon: Icon(Icons.grade,color: Colors.black38,),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      hintText: 'comment',
                      hintStyle: TextStyle(color: Colors.black38,fontSize: 15.0),
                      labelText: "Review",
                      labelStyle: TextStyle(fontSize: 20.0),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          borderSide: BorderSide(color: Colors.deepPurpleAccent)
                      ),
                      prefixIcon: Icon(Icons.insert_comment_outlined,color: Colors.black38,),
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

    return Scaffold( //หน้าจอ
        appBar: AppBar(title: Text('ADD REVIEW'),
            backgroundColor: Color(0xFFD7F2FD)),
        body: Stack(
          children: [
            buildForm(),
            if (_isLoading) buildLoadingOverlay(),
            if (_errorMessage != null) buildError(),
          ],
        ));
  }
}
