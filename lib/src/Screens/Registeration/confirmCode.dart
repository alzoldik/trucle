import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:truckle_drivers/src/Components/image_bg.dart';
import 'package:slide_countdown_clock/slide_countdown_clock.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:truckle_drivers/src/provider/auth/confirmResetCodeProvider.dart';
import 'package:truckle_drivers/src/provider/auth/phoneVerificationProvider.dart';
import 'package:truckle_drivers/src/provider/changeData/changePhoneCodeProvider.dart';

class ConfirmCode extends StatefulWidget {
  final String phoneNumber;
  final int stateOfVerificationCode;

  const ConfirmCode({Key key, this.phoneNumber, this.stateOfVerificationCode})
      : super(key: key);

  @override
  _ConfirmCodeState createState() => _ConfirmCodeState();
}

class _ConfirmCodeState extends State<ConfirmCode> {
 SharedPreferences _prefs;
  _getShared() async {
    var _instance = await SharedPreferences.getInstance();
    setState(() {
      _prefs = _instance;
    });
  }

  @override
  void initState() {
    _getShared();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var register =
        Provider.of<PhoneVerificationProvider>(context, listen: false);
    var confirmRessetCode =
        Provider.of<ConfirmResetCodeProvider>(context, listen: false);
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
                          height: 20,
                        ),
                        Center(
                            child: Text(
                          "تسجيل جديد",
                          style: TextStyle(color: Colors.black87, fontSize: 20),
                        )),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                            child: Text(
                          "ادخل كود التفعيل المرسل اليك",
                          style: TextStyle(color: Colors.black87, fontSize: 13),
                          textAlign: TextAlign.center,
                        )),
                        SizedBox(
                          height: 50,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 30),
                          child: Center(
                            child: PinCodeTextField(
                              length: 4,
                              backgroundColor: Color(
                                  0x00000000), //Theme.of(context).accentColor,
                              textStyle: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              pinTheme: PinTheme(
                                activeColor: Theme.of(context).primaryColor,
                                selectedColor: Theme.of(context).accentColor,
                                inactiveColor: Theme.of(context).accentColor,
                              ),
                              onChanged: (code) {
                                if (widget.stateOfVerificationCode == 1)
                                  register.code = code;
                                else if (widget.stateOfVerificationCode == 2)
                                  confirmRessetCode.code = code;
                                else {
                                   Provider.of<ChangePhoneCodeProvider>(context, listen: false).code = code;
                                }
                              },
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              textInputType: TextInputType.number,
                              autoFocus: true,
                              onCompleted: (String value) {
                                
                                 if (widget.stateOfVerificationCode == 1)
                                 register.phoneVerification(context);
                                else if (widget.stateOfVerificationCode == 2)
                                  confirmRessetCode.confirmResetCode(context);
                                else {
                                   Provider.of<ChangePhoneCodeProvider>(context, listen: false).changePhoneCode(_prefs.get("token"), context);
                                }
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            InkWell(
                                child: new Text(
                                  'إرسال مرة أخرى    ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 13,
                                      fontFamily: 'cairo',
                                      fontWeight: FontWeight.w400),
                                ),
                                onTap: () {
                                  // resendCodeBloc.add(Click());
                                }),
                            new Text(
                              'لم يصلك كود التفعيل؟',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                  fontFamily: 'cairo',
                                  fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          textDirection: TextDirection.rtl,
                          children: <Widget>[
                            Text("سيصل الكود خلال"),
                            SizedBox(height: 20),
                            Center(
                              child: SlideCountdownClock(
                                duration: Duration(minutes: 1),
                                slideDirection: SlideDirection.Down,
                                tightLabel: true,
                                separator: ":",
                                textStyle: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        // SignInButton(
                        //   txtColor: Colors.white,
                        //   onPressSignIn: () {
                        //     if (_code.length == 4) {
                        //       phoneVerificationBloc.codeChanged(_code);
                        //       print('pressed on OKAY >>>>>');
                        //       print("Code Is     ..........." + _code);

                        //       if (widget.stateOfVerificationCode == 0) {
                        //         Navigator.pop(context);
                        //         Navigator.of(context).push(MaterialPageRoute(
                        //             builder: (_) => ResetPasswordScreen()));
                        //         // phoneVerificationBloc.add(ResetPassword());
                        //       } else if (widget.stateOfVerificationCode == 1) {
                        //         Navigator.pop(context);
                        //         Navigator.of(context).push(MaterialPageRoute(
                        //             builder: (_) => SignUpScreen()));
                        //         // phoneVerificationBloc.add(Click());
                        //       } else {
                        //         Navigator.pop(context);
                        //         Navigator.of(context).push(MaterialPageRoute(
                        //             builder: (_) => MainPage()));
                        //         //  phoneVerificationBloc.add(Change());
                        //       }
                        //     }
                        //   },
                        //   btnWidth: MediaQuery.of(context).size.width,
                        //   btnHeight: MediaQuery.of(context).size.height * .07,
                        //   btnColor: Theme.of(context).primaryColor,
                        //   buttonText: 'تفعيل',
                        // ),
                        SizedBox(height: 20),
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
            child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Icon(Icons.arrow_back, color: Colors.black87)),
          ),
        ],
      ),
    );
  }
}
