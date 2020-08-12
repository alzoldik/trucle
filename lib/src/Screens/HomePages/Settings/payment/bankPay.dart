import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:truckle_drivers/src/Components/customBtn.dart';
import 'package:truckle_drivers/src/Components/custom_new_dialog.dart';
import 'package:truckle_drivers/src/Widgets/custom_app_bar_back_ground.dart';

class BankingPay extends StatefulWidget {
  @override
  _BankingPayState createState() => _BankingPayState();
}

class _BankingPayState extends State<BankingPay> {
  File _mainImg;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  CustomDialog dialog = CustomDialog();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            ListView(
              children: <Widget>[
                SizedBox(
                  height: 200,
                ),
                _showMainImg("صورة الايصال"),
                Padding(
                  padding: const EdgeInsets.only(right: 50, left: 50, top: 50),
                  child:
                      // Provider.of<SubscribeProvider>(context).loading == true
                      //     ? Center(
                      //         child: CircularProgressIndicator(),
                      //       )
                      //     :
                      CustomBtn(
                    onTap: () {
                      // setState(() {
                      //   Provider.of<SubscribeProvider>(context).loading = true;
                      // });
                      // onSave();
                    },
                    color: Theme.of(context).primaryColor,
                    text: "ارسال",
                    txtColor: Colors.white,
                  ),
                )
              ],
            ),
            CustomAppBarBackGround(
              widgets: <Widget>[
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          height: 60,
                          alignment: Alignment.center,
                          child: Text(
                            "الحساب البنكي",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: InkWell(
                            // onTap: () {
                            // //  mainBottomSheet(context, cities, "city");
                            // },
                            child: Icon(
                          Icons.pin_drop,
                          color: Theme.of(context).primaryColor,
                        )),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  onSave() {
    if (_mainImg == null) {
      // setState(() {
      //   Provider.of<SubscribeProvider>(context).loading = false;
      // });
      // dialog.showErrorDialog(
      //   btnOnPress: () {},
      //   context: context,
      //   msg: localization.text("image_bank"),
      //   ok: localization.text("ok"),
      // );
    } else {}
    // Provider.of<SubscribeProvider>(context).subscribe(
    //     widget.token,
    //     widget.packageId,
    //     widget.price,
    //     widget.desountCode,
    //     widget.sellerCode,
    //     _mainImg,
    //     context);
  }

  _showMainImg(String txt) {
    if (_mainImg != null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Stack(
          children: <Widget>[
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    _mainImg,
                    alignment: Alignment.center,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              child: InkWell(
                onTap: () {
                  setState(() {
                    _mainImg = null;
                  });
                },
                child: Icon(
                  Icons.delete,
                  color: Colors.red,
                  size: 30,
                ),
              ),
              bottom: 10,
              left: 10,
            ),
          ],
        ),
      );
    } else {
      return _cameraBtn(
          icon: Icons.camera_alt,
          label: txt,
          onTap: () {
            _getMainImg(ImageSource.gallery);
          });
    }
  }

  Widget _cameraBtn({Function onTap, String label, IconData icon}) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Color.fromRGBO(220, 220, 220, 1))),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[Icon(icon), Text(label)],
            ),
          ),
        ),
      ),
    );
  }

  _getMainImg(ImageSource source) async {
    var image = await ImagePicker.pickImage(source: source);
    setState(() {
      _mainImg = image;
    });
  }
}
