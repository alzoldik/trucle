import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truckle_drivers/src/Components/buttonSignIn.dart';
import 'package:truckle_drivers/src/Components/customBtn.dart';
import 'package:truckle_drivers/src/Components/image_bg.dart';
import 'package:truckle_drivers/src/Components/inputTextField.dart';
import 'package:truckle_drivers/src/Screens/Registeration/forgetPassword.dart';
import 'package:truckle_drivers/src/Screens/Registeration/register_mobile_screen.dart';
import 'package:truckle_drivers/src/provider/auth/loginProvider.dart';

class SignInScreen extends StatefulWidget {
  static const routeName = 'SignInScreen';

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  FirebaseMessaging _fcm = FirebaseMessaging();
  String _deviceToken;

  @override
  void initState() {
    _fcm.getToken().then((response) {
      setState(() {
        _deviceToken = response;
      });
      print('The device Token is :' + _deviceToken);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var logain = Provider.of<LoginProvider>(context, listen: false);
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: <Widget>[
            ImageBG(),
            ListView(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              children: <Widget>[
                Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height * .95,
                    width: MediaQuery.of(context).size.width - 100,
                    alignment: Alignment.center,
                    child: Form(
                      autovalidate: true,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Center(
                              child: Image.asset(
                            'assets/images/newLoga.png',
                            height: 130,
                            fit: BoxFit.cover,
                          )),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 4.0),
                                child: Text(
                                  "تسجيل الدخول",
                                  style: TextStyle(
                                      color: Colors.black87, fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          InputFieldArea(
                            labelTxt: 'رقم الجوال',
                            hint: "اكتب هنا",
                            //  errorTxt: "",
                            changedFunction: (v) {
                              logain.phone = v;
                            },
                            textInputType: TextInputType.number,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          InputFieldArea(
                            labelTxt: 'كلمة المرور',
                            hint: "اكتب هنا",
                            textInputType: TextInputType.text,
                            show: false,
                            inputFieldWithBorder: false,
                            changedFunction: (v) {
                              logain.password = v;
                            },
                            // errorTxt: "",
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          FlatButton(
                            child: Text('نسيت كلمة المرور ',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor)),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => ForgetPassword()));
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SignInButton(
                            txtColor: Colors.white,
                            onPressSignIn: () {
                              logain.login(_deviceToken,context);
                            },
                            btnWidth: MediaQuery.of(context).size.width,
                            btnHeight: MediaQuery.of(context).size.height * .07,
                            btnColor: Theme.of(context).primaryColor,
                            buttonText: 'دخول',
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CustomBtn(
                            txtColor: Colors.white,
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => RegisterMobileScreen()));
                            },
                            color: Theme.of(context).accentColor,
                            text: 'تسجيل جديد',
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
