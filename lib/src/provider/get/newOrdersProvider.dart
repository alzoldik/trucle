import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:truckle_drivers/src/Models/get/newOrderModel.dart';
import 'package:truckle_drivers/src/Repository/appLocalization.dart';
import 'package:truckle_drivers/src/Repository/networkUtlis.dart';

class NewsOrdersProvider with ChangeNotifier {
  List<Orders> _newOrders = [];

  List<Orders> get newOrders {
    return [..._newOrders];
  }

  NetworkUtil _utils = new NetworkUtil();
  NewOrdeModel newOrdersModel;
  bool  error = false;
  Future<NewOrdeModel> getNewsOrders(
  String token

  ) async {
    final List<Orders> loadedOrders = [];
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString(),
      "Authorization": "Bearer $token"
    };
    Response response = await _utils.get("get-new", headers: headers);
    if (response.statusCode == 200) {
      print("get get-new sucsseful");

      newOrdersModel = NewOrdeModel.fromJson(response.data);

      newOrdersModel.data.forEach((element) {
        loadedOrders.add(Orders(
            id: element.id,
            arrivalAddress: element.arrivalAddress,
            arrivalDate: element.arrivalDate,
            arrivalLatitude: element.arrivalLatitude,
            arrivalLongitude: element.arrivalLongitude,
            arrivalTime: element.arrivalTime,
            // category: element.category,
            categoryId: element.categoryId,
            cityId: element.cityId,
            code: element.code,
            createdAt: element.createdAt,
            detials: element.detials,
            size: element.size,
            state: element.state,
            travelAddress: element.travelAddress,
            travelDate: element.travelDate,
            travelLatitude: element.travelLatitude,
            travelLongitude: element.travelLongitude,
            travelTime: element.travelTime,
            userId: element.userId,
            photo: element.photo
            ));
      });
      _newOrders = loadedOrders.reversed.toList();
       error = false;
      notifyListeners();
      return NewOrdeModel.fromJson(response.data);
    } else {
      print("error get get-new data");
       error = true;
       notifyListeners();
      return NewOrdeModel.fromJson(response.data);
    }
  }
}

class Orders {
  Orders({
    @required this.id,
    @required this.size,
    @required this.detials,
    @required this.arrivalTime,
    @required this.arrivalDate,
    @required this.travelTime,
    @required this.travelDate,
    @required this.code,
    @required this.travelLongitude,
    @required this.travelLatitude,
    @required this.travelAddress,
    @required this.arrivalLongitude,
    @required this.arrivalLatitude,
    @required this.arrivalAddress,
    @required this.userId,
    @required this.state,
    @required this.categoryId,
    // @required this.category,
    @required this.cityId,
    @required this.createdAt,
    @required this.photo,
  });

  int id;
  int size;
  String detials;
  String arrivalTime;
  DateTime arrivalDate;
  String travelTime;
  DateTime travelDate;
  String code;
  String travelLongitude;
  String travelLatitude;
  String travelAddress;
  String arrivalLongitude;
  String arrivalLatitude;
  String arrivalAddress;
  int userId;
  String state;
  int categoryId;
  String category;
  int cityId;
  DateTime createdAt;
  String photo;
}
