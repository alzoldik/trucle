import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truckle_drivers/src/Components/buttonSignIn.dart';
import 'package:truckle_drivers/src/Components/image_bg.dart';
import 'package:truckle_drivers/src/Components/inputTextField.dart';
import 'package:truckle_drivers/src/provider/auth/registerMobileProvider.dart';

class RegisterMobileScreen extends StatefulWidget {
  @override
  _RegisterMobileScreenState createState() => _RegisterMobileScreenState();
}

class _RegisterMobileScreenState extends State<RegisterMobileScreen> {
  bool showTheMargin = true;

  @override
  void initState() {
    // Provider.of<RegisterMobileProvider>(context, listen: false).context =
    //     context;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var register = Provider.of<RegisterMobileProvider>(context, listen: false);
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
                  height: MediaQuery.of(context).size.height * .9,
                  width: MediaQuery.of(context).size.width - 100,
                  alignment: Alignment.center,
                  child: Form(
                    autovalidate: true,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                            child: Image.asset(
                          'assets/images/newLoga.png',
                          height: 150,
                          fit: BoxFit.cover,
                        )),
                        SizedBox(
                          height: 50,
                        ),
                        Center(
                            child: Text(
                          "تسجيل جديد",
                          style: TextStyle(color: Colors.black87, fontSize: 20),
                        )),
                        SizedBox(
                          height: 5,
                        ),
                        Center(
                            child: Text(
                          "فضلا قم بادخال رقم جوالك ليصلك كود التفعيل",
                          style: TextStyle(color: Colors.black87, fontSize: 13),
                          textAlign: TextAlign.center,
                        )),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .15,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InputFieldArea(
                          labelTxt: 'رقم الجوال',
                          hint: "اكتب هنا",
                          textInputType: TextInputType.number,
                          changedFunction: (v) {
                            register.phone = v;
                          },
                          // errorTxt: snapshot.error,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SignInButton(
                          txtColor: Colors.white,
                          onPressSignIn: () {
                            register.registerMobile(context);
                          },
                          btnWidth: MediaQuery.of(context).size.width,
                          btnHeight: MediaQuery.of(context).size.height * .07,
                          btnColor: Theme.of(context).primaryColor,
                          buttonText: 'التالي',
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              onPressed: () {
                FocusScope.of(context).requestFocus(FocusNode());
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black87,
              ),
            ),
          )
        ],
      ),
    );
  }
}
