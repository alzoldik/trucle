import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:truckle_drivers/src/Components/custom_new_dialog.dart';
import 'package:truckle_drivers/src/Models/post/acceptModel.dart';
import 'package:truckle_drivers/src/Repository/appLocalization.dart';
import 'package:truckle_drivers/src/Repository/networkUtlis.dart';

class AcceptedProvider with ChangeNotifier {
  NetworkUtil _utils = new NetworkUtil();
  AcceptModel acceptedModel;
  CustomDialog dialog = CustomDialog();
  int price;
  String note;
  accepted(
    String token,
    String id,
    BuildContext context,
  ) async {
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString(),
      "Authorization": "Bearer $token"
    };
    FormData formData = FormData.fromMap({
      "price": 3,
      "details_driver": note,
    });
    Response response =
        await _utils.post("accepted/$id", body: formData, headers: headers);
    if (response == null) {
      print('error rate');
      dialog.showWarningDialog(
        btnOnPress: () {},
        context: context,
        msg: localization.text("internet"),
      );
    }
    if (response.statusCode == 200) {
      print("get accepted sucsseful");
      acceptedModel = AcceptModel.fromJson(response.data);
    } else {
      print("error accepted data");
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
