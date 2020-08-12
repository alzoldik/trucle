import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:truckle_drivers/src/Components/custom_new_dialog.dart';
import 'package:truckle_drivers/src/Models/post/acceptModel.dart';
import 'package:truckle_drivers/src/Repository/appLocalization.dart';
import 'package:truckle_drivers/src/Repository/networkUtlis.dart';

class AcctivatedOrderProvider with ChangeNotifier {
  NetworkUtil _utils = new NetworkUtil();
  AcceptModel rateModel;
  CustomDialog dialog = CustomDialog();

  activete(
    String token,
    String id,
    BuildContext context,
  ) async {
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString(),
      "Authorization": "Bearer $token"
    };
 
    Response response =
        await _utils.get("activated/$id",  headers: headers);
    if (response == null) {
      print('error activated');
      dialog.showWarningDialog(
        btnOnPress: () {},
        context: context,
        msg: localization.text("internet"),
      );
    }
    if (response.statusCode == 200) {
      print("get activated sucsseful");
      rateModel = AcceptModel.fromJson(response.data);
    } else {
      print("error get activated data");
      rateModel = AcceptModel.fromJson(response.data);
    }
    if (rateModel.code == 200) {
      // Fluttertoast.showToast(
      //     msg: localization.text("success_rating"),
      //     toastLength: Toast.LENGTH_LONG,
      //     timeInSecForIosWeb: 1,
      //     fontSize: 16.0);
      return true;
    } else {
      print('error activated');
      Fluttertoast.showToast(
          msg: localization.text("error"),
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
    }
    notifyListeners();
  }
}
