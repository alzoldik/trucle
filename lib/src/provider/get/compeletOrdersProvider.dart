import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:truckle_drivers/src/Models/get/completedOrerModel.dart';
import 'package:truckle_drivers/src/Repository/appLocalization.dart';
import 'package:truckle_drivers/src/Repository/networkUtlis.dart';

class CompeletOrderProvider with ChangeNotifier {
  int price = 0;
  List<Orders> _compeletedOrders = [];
  bool error = false;

  List<Orders> get compeletedOrders {
    return [..._compeletedOrders];
  }

  NetworkUtil _utils = new NetworkUtil();
  CompletedOrdeModel compeletedModel;
  Future<CompletedOrdeModel> getCompeletOrders(String token) async {
    final List<Orders> loadedOrders = [];
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString(),
      "Authorization": "Bearer $token"
    };
    Response response = await _utils.get("get-completed", headers: headers);
    if (response.statusCode == 200) {
      print("get get-completed sucsseful");

      compeletedModel = CompletedOrdeModel.fromJson(response.data);

      compeletedModel.data.forEach((element) {
        loadedOrders.add(
          Orders(
              id: element.id,
              arrivalAddress: element.arrivalAddress,
              arrivalDate: element.arrivalDate,
              arrivalLatitude: element.arrivalLatitude,
              arrivalLongitude: element.arrivalLongitude,
              arrivalTime: element.arrivalTime,
              // category: element.category,
              categoryId: element.categoryId,
              cityId: element.cityId,
              rate: element.rate,
              photo: element.photo,
              driver: element.user,
              code: element.code,
              // createdAt: element.createdAt,
              detials: element.detials,
              driverId: element.userId,
              size: element.size,
              state: element.state,
              travelAddress: element.travelAddress,
              travelDate: element.travelDate,
              travelLatitude: element.travelLatitude,
              travelLongitude: element.travelLongitude,
              travelTime: element.travelTime,
              rateState: element.rateState
              // price: element.price
              ),
        );
        // price = price + element.price;
      });
      _compeletedOrders = loadedOrders.reversed.toList();
      error = false;
      notifyListeners();
      return CompletedOrdeModel.fromJson(response.data);
    } else {
      print("error get get-completed data");
      error = true;
      notifyListeners();
      return CompletedOrdeModel.fromJson(response.data);
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
    @required this.driverId,
    @required this.driver,
    @required this.photo,
    @required this.rate,
    @required this.state,
    @required this.categoryId,
    @required this.rateState,
    @required this.cityId,
    // @required this.price,
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
  int driverId;
  String driver;
  String photo;
  int rate;
  String state;
  int categoryId;
  String category;
  int cityId;
  bool rateState;
  int price;
}
