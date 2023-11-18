import 'dart:convert';
import 'package:accommodation_review_app/model/places.dart';
import '../services/api_caller.dart';

class ProvinceRepository { // class ที่ทำหน้าที่ ดึงข้อมูล จาก call api
  Future<List<Places>> getPlaces() async {
    try {
      var result = await ApiCaller().get('locations?_embed=reviews');
      List list = jsonDecode(
          result);
      List<Places> placesList =
      list.map<Places>((item) => Places.fromJson(item)).toList();
      return placesList;
    }catch(e){
      // TODO:
      rethrow;
    }
  }

  Future<void> addPlaces( // เพิ่มข้อมูลห้องน้ำ
          {required String name}) async {
    try {
      var result = await ApiCaller()
          .post('locations', params: {'name': name});
    } catch (e) {
      // TODO:
      rethrow;
    }
  }
}
