import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:truckle_drivers/src/Components/custom_new_dialog.dart';
import 'package:truckle_drivers/src/Models/post/acceptModel.dart';
import 'package:truckle_drivers/src/Repository/appLocalization.dart';
import 'package:truckle_drivers/src/Repository/networkUtlis.dart';
import 'package:truckle_drivers/src/Screens/HomePages/main_page.dart';

class SubscribeProvider with ChangeNotifier {
  NetworkUtil _utils = new NetworkUtil();
  CustomDialog dialog = CustomDialog();

  bool loading = false;
  AcceptModel subscribeModel;
  subscribe(String token, String packageId, String price, String discountCode,
      String sellerCode, File image, BuildContext context) async {
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString(),
      'Authorization': 'Bearer $token',
    };
    FormData formData = FormData.fromMap({
      "order_id": packageId,
      "price": price,
      "photo": image == null ? null : await MultipartFile.fromFile(image.path),
    });

    Response response =
        await _utils.post("pay", body: formData, headers: headers);
    if (response == null) {
      loading = false;
      notifyListeners();
      print('error pay');
      dialog.showWarningDialog(
        btnOnPress: () {},
        context: context,
        msg: localization.text("internet"),
      );
    }
    if (response.statusCode == 200) {
      print("pay data sucsseful");
      subscribeModel = AcceptModel.fromJson(response.data);
    } else {
      print("error  pay data");
      subscribeModel = AcceptModel.fromJson(response.data);
    }
    if (subscribeModel.code == 200) {
      loading = false;
      notifyListeners();

      dialog.showSuccessDialog(
        btnOnPress: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => MainPage(
                index: 3,
              ),
            ),
            (Route<dynamic> route) => false,
          );
        },
        context: context,
        msg: subscribeModel.data.value,
        btnMsg: localization.text("ok"),
      );
    } else {
      loading = false;
      notifyListeners();

      print('error edit_account');
      dialog.showErrorDialog(
          btnOnPress: () {},
          context: context,
          msg: localization.text("error"),
          ok: localization.text("ok"),
          code: subscribeModel.code);
    }
    notifyListeners();
  }
}
