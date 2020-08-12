import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:truckle_drivers/src/Components/custom_new_dialog.dart';
import 'package:truckle_drivers/src/Components/custom_progress_dialog.dart';
import 'package:truckle_drivers/src/Models/auth/signUpModel.dart';
import 'package:truckle_drivers/src/Repository/appLocalization.dart';
import 'package:truckle_drivers/src/Repository/networkUtlis.dart';
import 'package:truckle_drivers/src/Screens/HomePages/main_page.dart';

class SignUpProvider with ChangeNotifier {
  String phone;
  String email;
  String firstName;
  String lastName;
  String countryId;
  String truckleId;
  File identity;
  File license;
  File carForm;
  File transportationCard;
  File insurance;

  String password;
  String passwordConfirmation;

  NetworkUtil _utils = new NetworkUtil();
  CustomDialog dialog = CustomDialog();
  CustomProgressDialog customProgressDialog;
  ProgressDialog pr;

  SignUpModel _model;
  SharedPreferences _prefs;
  signUp(String token, BuildContext context) async {
    customProgressDialog = CustomProgressDialog(context: context, pr: pr);
    customProgressDialog.showProgressDialog();
    customProgressDialog.showPr();
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString(),
    };
    FormData formData = FormData.fromMap({
      "email": email,
      "phone_number": phone,
      "name": firstName,
      "last_name": lastName,
      "truckle_id": truckleId,
      "country_id": countryId,
      "password": password,
      "password_confirmation": passwordConfirmation,
      "device_token": token,
      "identity":
          identity == null ? null : await MultipartFile.fromFile(identity.path),
      "license":
          license == null ? null : await MultipartFile.fromFile(license.path),
      "car_form":
          carForm == null ? null : await MultipartFile.fromFile(carForm.path),
      "transportation_card": transportationCard == null
          ? null
          : await MultipartFile.fromFile(transportationCard.path),
      "insurance": insurance == null
          ? null
          : await MultipartFile.fromFile(insurance.path),
    });

    Response response =
        await _utils.post("register", body: formData, headers: headers);
    if (response == null) {
      print('error register res == null');
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
      print("register sucsseful");
      _model = SignUpModel.fromJson(response.data);
    } else {
      print("error register");
      _model = SignUpModel.fromJson(response.data);
    }
    if (_model.code == 200) {
      Future.delayed(Duration(seconds: 1), () {
        customProgressDialog.hidePr();
      });
      _prefs = await SharedPreferences.getInstance();
      print('done');
      print("${_model.data[0].name}...................");
      print("${_model.data[0].apiToken}...................");
      print("${_model.data[0].id}...................");
      print("${_model.data[0].active}...................");
      _prefs.setString('name', _model.data[0].name);
      _prefs.setString('email', _model.data[0].email);
      _prefs.setInt('countRate', _model.data[0].countRate);
      _prefs.setString('email', _model.data[0].email);

      _prefs.setString('phone', _model.data[0].phoneNumber);
      _prefs.setString('token', _model.data[0].apiToken);
      _prefs.setInt('id', _model.data[0].id);
      _prefs.setInt('active', _model.data[0].active);
      // _prefs.setString('image', _model.data[0].photo);
      _prefs.setInt('type', _model.data[0].type);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => MainPage(),
        ),
        (Route<dynamic> route) => false,
      );
    } else {
      print('error register');
      Future.delayed(Duration(seconds: 1), () {
        customProgressDialog.hidePr();
        dialog.showErrorDialog(
            btnOnPress: () {},
            context: context,
            msg: _model.error[0].value,
            ok: localization.text("ok"),
            code: _model.code);
      });
    }
    notifyListeners();
  }
}
