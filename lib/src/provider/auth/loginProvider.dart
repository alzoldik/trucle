import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:truckle_drivers/src/Components/custom_new_dialog.dart';
import 'package:truckle_drivers/src/Components/custom_progress_dialog.dart';
import 'package:truckle_drivers/src/Models/auth/LoginModel.dart';
import 'package:truckle_drivers/src/Repository/appLocalization.dart';
import 'package:truckle_drivers/src/Repository/networkUtlis.dart';
import 'package:truckle_drivers/src/Screens/HomePages/main_page.dart';

class LoginProvider with ChangeNotifier {
  String phone;
  String password;

  NetworkUtil _utils = new NetworkUtil();
  CustomDialog dialog = CustomDialog();
  CustomProgressDialog customProgressDialog;
  ProgressDialog pr;

  LoginModel _model;
  SharedPreferences _prefs;
  login(String token, BuildContext context) async {
    customProgressDialog = CustomProgressDialog(context: context, pr: pr);
    customProgressDialog.showProgressDialog();
    customProgressDialog.showPr();

    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString()
    };
    FormData formData = FormData.fromMap({
      "phone_number": phone,
      "password": password,
      "device_token": token,
    });

    Response response =
        await _utils.post("login", body: formData, headers: headers);
    if (response == null) {
      print('error login res == null');
      Future.delayed(Duration(seconds: 1), () {
        customProgressDialog.hidePr();
        dialog.showWarningDialog(
          btnOnPress: () {},
          context: context,
          msg: localization.text("internet"),
        );
      });

      return;
    }

    if (response.statusCode == 200) {
      print("login sucsseful");
      _model = LoginModel.fromJson(response.data);
    } else {
      print("error login");
      Future.delayed(Duration(seconds: 1), () {
        customProgressDialog.hidePr();
      });
      _model = LoginModel.fromJson(response.data);
    }
    if (_model.code == 200) {
      Future.delayed(Duration(seconds: 1), () {
        customProgressDialog.hidePr();
      });
      _prefs = await SharedPreferences.getInstance();
      print('done');
      _prefs.setString('name', _model.data[0].name);
      _prefs.setString('phone', _model.data[0].phoneNumber);
      _prefs.setString('token', _model.data[0].apiToken);
      _prefs.setInt('id', _model.data[0].id);
      _prefs.setInt('active', _model.data[0].active);
      _prefs.setString('image', _model.data[0].photo);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => MainPage(),
        ),
        (Route<dynamic> route) => false,
      );
    } else {
      print('error login');

      Future.delayed(Duration(seconds: 1), () {
        customProgressDialog.hidePr();
        dialog.showErrorDialog(
          btnOnPress: () {},
          context: context,
          msg: _model.error[0].value,
          ok: localization.text("ok"),
        );
      });
    }
    notifyListeners();
  }
}
