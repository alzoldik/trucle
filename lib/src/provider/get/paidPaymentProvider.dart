import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:truckle_drivers/src/Models/get/PaidPaymentModel.dart';
import 'package:truckle_drivers/src/Repository/appLocalization.dart';
import 'package:truckle_drivers/src/Repository/networkUtlis.dart';

class PaidPaymentProvider with ChangeNotifier {
  int price = 0;
  List<Pays> _pays = [];
  bool error = false;

  List<Pays> get pays {
    return [..._pays];
  }

  NetworkUtil _utils = new NetworkUtil();
  GetPaidPaymentModel compeletedModel;
  Future<GetPaidPaymentModel> getPaidPayment(String token) async {
    final List<Pays> loadedOrders = [];
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString(),
      "Authorization": "Bearer $token"
    };
    Response response = await _utils.get("get-paid-payment", headers: headers);
    if (response.statusCode == 200) {
      print("get get-paid-payment sucsseful");

      compeletedModel = GetPaidPaymentModel.fromJson(response.data);

      compeletedModel.data.forEach((e) {
        loadedOrders.add(
          Pays(
              arrivalAddress: e.arrivalAddress,
              arrivalDate: e.arrivalDate,
              arrivalLatitude: e.arrivalLatitude,
              arrivalLongitude: e.arrivalLongitude,
              arrivalTime: e.arrivalTime,
              categoryId: e.categoryId,
              cityId: e.cityId,
              code: e.code,
              commissionPrice: e.commissionPrice,
              createdAt: e.createdAt,
              detials: e.detials,
              id: e.id,
              notes: e.notes,
              price: e.price,
              rate: e.rate,
              size: e.size,
              state: e.state,
              totalPrice: e.totalPrice,
              travelAddress: e.travelAddress,
              travelDate: e.travelDate,
              travelLatitude: e.arrivalLatitude,
              travelLongitude: e.travelLongitude,
              travelTime: e.travelTime,
              user: e.user,
              userId: e.userId),
        );
        // price = price + element.price;
      });
      _pays = loadedOrders.reversed.toList();
      error = false;
      notifyListeners();
      return GetPaidPaymentModel.fromJson(response.data);
    } else {
      print("error get get-paid-payment data");
      error = true;
      notifyListeners();
      return GetPaidPaymentModel.fromJson(response.data);
    }
  }
}

class Pays {
  Pays({
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
    @required this.user,
    @required this.rate,
    @required this.state,
    @required this.categoryId,
    @required this.notes,
    @required this.cityId,
    @required this.price,
    @required this.commissionPrice,
    @required this.totalPrice,
    @required this.createdAt,
  });

  int id;
  int size;
  String detials;
  String arrivalTime;
  DateTime arrivalDate;
  String travelTime;
  DateTime travelDate;
  int code;
  String travelLongitude;
  String travelLatitude;
  String travelAddress;
  String arrivalLongitude;
  String arrivalLatitude;
  String arrivalAddress;
  int userId;
  String user;
  int rate;
  String state;
  int categoryId;
  String notes;
  int cityId;
  int price;
  int commissionPrice;
  int totalPrice;
  DateTime createdAt;
}
