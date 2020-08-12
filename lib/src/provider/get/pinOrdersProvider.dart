import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:truckle_drivers/src/Models/get/pinOrderModle.dart';
import 'package:truckle_drivers/src/Repository/appLocalization.dart';
import 'package:truckle_drivers/src/Repository/networkUtlis.dart';

class PinOrderOrderProvider with ChangeNotifier {
  List<Orders> _pinOrders = [];

  List<Orders> get pinedOrders {
    return [..._pinOrders];
  }

clearList(){
  _pinOrders = [];
  notifyListeners();
}
  NetworkUtil _utils = new NetworkUtil();
  PinOrderModel pinOrderModel;
  bool error = false;
  Future<PinOrderModel> getPinOrders(String token,int id) async {
    final List<Orders> loadedOrders = [];
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString(),
      "Authorization": "Bearer $token"
    };
    FormData formData = FormData.fromMap({
      "city_id": id,
    });
    Response response =
        await _utils.post("get-pending", headers: headers, body: formData);
    if (response.statusCode == 200) {
      print("get get-pending sucsseful");

      pinOrderModel = PinOrderModel.fromJson(response.data);

      pinOrderModel.data.forEach((element) {
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
            rate: element.rate,
            photo: element.photo,
            driver: element.user,
            code: element.code,
            createdAt: element.createdAt,
            detials: element.detials,
            driverId: element.userId,
            size: element.size,
            state: element.state,
            travelAddress: element.travelAddress,
            travelDate: element.travelDate,
            travelLatitude: element.travelLatitude,
            travelLongitude: element.travelLongitude,
            travelTime: element.travelTime,
            discountPercentage: element.discountPercentage));
      });
      _pinOrders = loadedOrders.reversed.toList();
      error = false;
      notifyListeners();
      return PinOrderModel.fromJson(response.data);
    } else {
      print("error get get-pending data");
      error = true;
      notifyListeners();
      return PinOrderModel.fromJson(response.data);
    }
  }
}

class Orders {
  Orders(
      {@required this.id,
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
      // @required this.category,
      @required this.cityId,
      @required this.createdAt,
      @required this.discountPercentage});

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
  DateTime createdAt;
  String discountPercentage;
}
