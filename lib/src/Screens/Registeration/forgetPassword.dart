import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truckle_drivers/src/Components/buttonSignIn.dart';
import 'package:truckle_drivers/src/Components/image_bg.dart';
import 'package:truckle_drivers/src/Components/inputTextField.dart';
import 'package:truckle_drivers/src/provider/auth/forgetPasswordProvider.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {

@override
  void initState() {
    // Provider.of<ForgetPasswordProvider>(context, listen: false).context = context;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var forgetPassword = Provider.of<ForgetPasswordProvider>(context, listen: false);
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
                  height: MediaQuery.of(context).size.height,
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
                          'assets/images/lock.png',
                          height: 100,
                          width: 100,
                          fit: BoxFit.contain,
                        )),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                            child: Text(
                          "فضلا ادخل رقم الجوال",
                          style: TextStyle(color: Colors.black87, fontSize: 20),
                        )),
                        SizedBox(
                          height: 5,
                        ),
                        Center(
                            child: Text(
                          "لاستعادة كلمة المرور",
                          style: TextStyle(color: Colors.black87, fontSize: 15),
                        )),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .3,
                        ),
                        InputFieldArea(
                          labelTxt: 'رقم الجوال',
                          hint: "اكتب هنا",
                          textInputType: TextInputType.number,
                          changedFunction:(v){
                            forgetPassword.phone = v;
                          },
                          //  errorTxt: snapshot.error,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SignInButton(
                          txtColor: Colors.white,
                          onPressSignIn: () {
                            // _forgetPasswordMethod();
                            forgetPassword.forgetPassword(context);
                          },
                          btnWidth: MediaQuery.of(context).size.width,
                          btnHeight: MediaQuery.of(context).size.height * .07,
                          btnColor: Theme.of(context).primaryColor,
                          buttonText: 'ارسال',
                        ),
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
