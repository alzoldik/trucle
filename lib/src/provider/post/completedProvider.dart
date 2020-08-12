import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:truckle_drivers/src/Components/custom_new_dialog.dart';
import 'package:truckle_drivers/src/Models/post/acceptModel.dart';
import 'package:truckle_drivers/src/Repository/appLocalization.dart';
import 'package:truckle_drivers/src/Repository/networkUtlis.dart';

class CompletedProvider with ChangeNotifier {
  NetworkUtil _utils = new NetworkUtil();
  AcceptModel acceptedModel;
  CustomDialog dialog = CustomDialog();
  int price;
  String note;
  completed(
    String token,
    String id,
    BuildContext context,
  ) async {
    Map<String, String> headers = {
      "Authorization": "Bearer $token"
    };

    Response response =
        await _utils.get("completed/$id",  headers: headers);
    if (response == null) {
      print('error completed');
      dialog.showWarningDialog(
        btnOnPress: () {},
        context: context,
        msg: localization.text("internet"),
      );
    }
    if (response.statusCode == 200) {
      print("get completed sucsseful");
      acceptedModel = AcceptModel.fromJson(response.data);
    } else {
      print("error completed data");
      acceptedModel = AcceptModel.fromJson(response.data);
    }
    if (acceptedModel.code == 200) {
      Fluttertoast.showToast(
          msg: localization.text("succes"),
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
      return true;
    } else {
      print('error confirmed');
      Fluttertoast.showToast(
          msg: localization.text("error"),
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
    }
    notifyListeners();
  }
}
