import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:truckle_drivers/src/Components/custom_new_dialog.dart';
import 'package:truckle_drivers/src/Components/custom_progress_dialog.dart';
import 'package:truckle_drivers/src/Models/auth/phoneVerificationModel.dart';
import 'package:truckle_drivers/src/Repository/appLocalization.dart';
import 'package:truckle_drivers/src/Repository/networkUtlis.dart';
import 'package:truckle_drivers/src/Screens/Registeration/sign_up_screen.dart';
import 'package:truckle_drivers/src/provider/auth/signUpProvider.dart';

class PhoneVerificationProvider with ChangeNotifier {
  String countryCode;
  String phone;
  String code;

  NetworkUtil _utils = new NetworkUtil();
  CustomDialog dialog = CustomDialog();
  CustomProgressDialog customProgressDialog;
  ProgressDialog pr;
  PhoneVerificationModel _model;
  phoneVerification(BuildContext context) async {
    customProgressDialog = CustomProgressDialog(context: context, pr: pr);
    customProgressDialog.showProgressDialog();
    customProgressDialog.showPr();
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString()
    };
    FormData formData = FormData.fromMap({
      "phone_number": phone,
      "code": code,
    });

    Response response = await _utils.post(
        "phone-verification/${localization.currentLanguage.toString()}",
        body: formData,
        headers: headers);
    if (response == null) {
      Future.delayed(Duration(seconds: 1), () {
        customProgressDialog.hidePr();
        print('error phone_verification');
        dialog.showWarningDialog(
          btnOnPress: () {},
          context: context,
          msg: localization.text("internet"),
        );
      });

      return;
    }
    if (response.statusCode == 200) {
      print("phone_verification sucsseful");
      _model = PhoneVerificationModel.fromJson(response.data);
    } else {
      print("error phone_verification");
      Future.delayed(Duration(seconds: 1), () {
        customProgressDialog.hidePr();
      });
      _model = PhoneVerificationModel.fromJson(response.data);
    }
    if (_model.code == 200) {
      print('success phone_verification');
      Future.delayed(Duration(seconds: 1), () {
        customProgressDialog.hidePr();
      });
      Provider.of<SignUpProvider>(context, listen: false).phone = phone;
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => SignUpScreen()));
    } else {
      print('error phone_verification');
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
