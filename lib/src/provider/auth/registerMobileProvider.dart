import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:truckle_drivers/src/Components/custom_new_dialog.dart';
import 'package:truckle_drivers/src/Components/custom_progress_dialog.dart';
import 'package:truckle_drivers/src/Models/auth/registerMobileModel.dart';
import 'package:truckle_drivers/src/Repository/appLocalization.dart';
import 'package:truckle_drivers/src/Repository/networkUtlis.dart';
import 'package:truckle_drivers/src/Screens/Registeration/confirmCode.dart';
import 'package:truckle_drivers/src/provider/auth/phoneVerificationProvider.dart';

class RegisterMobileProvider with ChangeNotifier {
  String phone;

  NetworkUtil _utils = new NetworkUtil();
  CustomDialog dialog = CustomDialog();
  RegisterMobileModel model;
  CustomProgressDialog customProgressDialog;
  ProgressDialog pr;
  registerMobile(BuildContext context) async {
    customProgressDialog = CustomProgressDialog(context: context, pr: pr);
    customProgressDialog.showProgressDialog();
    customProgressDialog.showPr();
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString()
    };
    FormData formData = FormData.fromMap({
      "phone_number": phone,
    });

    Response response =
        await _utils.post("register-mobile", body: formData, headers: headers);
    if (response == null) {
      Future.delayed(Duration(seconds: 1), () {
        customProgressDialog.hidePr();
        print('error register mobile res == null');
        dialog.showWarningDialog(
          btnOnPress: () {},
          context: context,
          msg: localization.text("internet"),
        );
      });
      return;
    }
    if (response.statusCode == 200) {
      print("register_mobile sucsseful");
      model = RegisterMobileModel.fromJson(response.data);
    } else {
      print("error register_mobile");
      model = RegisterMobileModel.fromJson(response.data);
    }
    if (model.code == 200) {
      Future.delayed(Duration(seconds: 1), () {
        customProgressDialog.hidePr();
      });
      Provider.of<PhoneVerificationProvider>(context, listen: false).phone =
          phone;
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => ConfirmCode(
                //  phoneNumber: phone,
                stateOfVerificationCode: 1,
              )));
    } else {
      print('error register_mobile');
      Future.delayed(Duration(seconds: 1), () {
        customProgressDialog.hidePr();
        dialog.showErrorDialog(
          btnOnPress: () {},
          context: context,
          msg: model.error[0].value,
          ok: localization.text("ok"),
        );
      });
    }
    notifyListeners();
  }
}
