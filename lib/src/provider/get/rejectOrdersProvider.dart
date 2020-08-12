import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:truckle_drivers/src/Models/get/rejectedOrderModel.dart';
import 'package:truckle_drivers/src/Repository/appLocalization.dart';
import 'package:truckle_drivers/src/Repository/networkUtlis.dart';

class RejectedOrderProvider with ChangeNotifier {
  List<Orders> _rejectedOrders = [];

  List<Orders> get rejectiesOrders {
    return [..._rejectedOrders];
  }

  NetworkUtil _utils = new NetworkUtil();
  RejectedOrdeModel rejectedModel;
  bool  error = false;
  Future<RejectedOrdeModel> getRejectedOrders(  String token) async {
    final List<Orders> loadedOrders = [];
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString(),
      "Authorization": "Bearer $token"
    };
    Response response = await _utils.get("get-rejected", headers: headers);
    if (response.statusCode == 200) {
      print("get get-rejected sucsseful");

      rejectedModel = RejectedOrdeModel.fromJson(response.data);

      rejectedModel.data.forEach((element) {
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
          notes: element.notes
          // userId: element.userId
        ));
      });
      _rejectedOrders = loadedOrders.reversed.toList();
       error = false;
      notifyListeners();
      return RejectedOrdeModel.fromJson(response.data);
    } else {
      print("error get get-rejected data");
       error = true;
       notifyListeners();
      return RejectedOrdeModel.fromJson(response.data);
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
    @required this.notes,
    @required this.categoryId,
    // @required this.category,
    @required this.cityId,
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
  String notes;
  int categoryId;
  String category;
  int cityId;
}
