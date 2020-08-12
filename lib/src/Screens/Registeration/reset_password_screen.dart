import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truckle_drivers/src/Components/buttonSignIn.dart';
import 'package:truckle_drivers/src/Components/image_bg.dart';
import 'package:truckle_drivers/src/Components/inputTextField.dart';
import 'package:truckle_drivers/src/provider/auth/resetPasswordProvider.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  @override
  void initState() {
    // Provider.of<ResetPasswordProvider>(context, listen: false).context =
    //     context;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var confirmRessetCode =
        Provider.of<ResetPasswordProvider>(context, listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: <Widget>[
          ImageBG(),
          Center(
            child: Container(
              child: ListView(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                children: <Widget>[
                  Center(
                      child: Image.asset(
                    'assets/images/lock.png',
                    height: 100,
                    width: 100,
                    fit: BoxFit.contain,
                  )),
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'تغير كلمة المرور',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'cairo'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InputFieldArea(
                      inputFieldWithBorder: true,
                      textInputType: TextInputType.text,
                      hint: 'كلمة المرور',
                      show: true,
                      changedFunction: (v) {
                        confirmRessetCode.password = v;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InputFieldArea(
                      inputFieldWithBorder: true,
                      textInputType: TextInputType.text,
                      hint: 'تأكيد كلمة المرور',
                      show: true,
                      changedFunction: (v) {
                        confirmRessetCode.passwordConfirmation = v;
                      },
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SignInButton(
                        txtColor: Colors.white,
                        onPressSignIn: () {
                          confirmRessetCode.resetPassword(context);
                        },
                        btnWidth: MediaQuery.of(context).size.width,
                        btnHeight: MediaQuery.of(context).size.height * .07,
                        btnColor: Theme.of(context).primaryColor,
                        buttonText: 'تأكيد',
                      )),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
