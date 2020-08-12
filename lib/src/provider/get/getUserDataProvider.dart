import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:truckle_drivers/src/Models/get/getUserDataModel.dart';
import 'package:truckle_drivers/src/Repository/networkUtlis.dart';

class GetUserDataProvider with ChangeNotifier {
  NetworkUtil _utils = new NetworkUtil();
  GetUserDataModel userDataModel;
  Future<GetUserDataModel> getUserData(String token) async {
    Map<String, String> headers = {"Authorization": "Bearer $token"};
    Response response = await _utils.get("user-data", headers: headers);
    if (response.statusCode == 200) {
      print("get user-data sucsseful");

      userDataModel = GetUserDataModel.fromJson(response.data);
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      print('done');
      _prefs.setDouble('rate', userDataModel.data[0].rate.toDouble());
      _prefs.setString('countRate', userDataModel.data[0].countRate.toString());

      notifyListeners();
      return GetUserDataModel.fromJson(response.data);
    } else {
      print("error get user-data data");
      return GetUserDataModel.fromJson(response.data);
    }
  }
}
