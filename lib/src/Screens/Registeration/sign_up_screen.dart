import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truckle_drivers/src/Components/buttonSignIn.dart';
import 'package:truckle_drivers/src/Components/custom_text_container.dart';
import 'package:truckle_drivers/src/Components/image_bg.dart';
import 'package:truckle_drivers/src/Components/inputTextField.dart';
import 'package:truckle_drivers/src/Screens/Registeration/documents.dart';
import 'package:truckle_drivers/src/Widgets/ImagePicker/image_picker_handler.dart';
import 'package:truckle_drivers/src/provider/auth/signUpProvider.dart';
import 'package:truckle_drivers/src/provider/countriesProvider.dart';
import 'package:truckle_drivers/src/provider/truclesprovider.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = 'SignUpScreen';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with TickerProviderStateMixin, ImagePickerListener {
  Color btnColor = Colors.grey;
  bool isChecked = false;
  final FirebaseMessaging _fcm = FirebaseMessaging();
  String _deviceToken = 'DEFULT_TOKEN';
  ImageProvider imageProvider;
  File _image;
  AnimationController _controller;
  ImagePickerHandler imagePicker;
  // ignore: unused_field
  // CustomDialog _dialog = CustomDialog();

  // List<String> _countries = [];
  String _country;

  // List<String> _trucks = [];
  String _truck;
  var rejister;
  @override
  void initState() {
    rejister = Provider.of<SignUpProvider>(context, listen: false);
    Provider.of<CountriesProvider>(context, listen: false).getCountries();
    Provider.of<TruclesProvider>(context, listen: false).getTrucles();

    _fcm.getToken().then((response) {
      _deviceToken = response;
      print('The device Token is :' + _deviceToken);
    });
    // _countries = ["قطر", "السعودية", "عمان", "الامارات", "البحرين"];
    // _trucks = ["شاحنة صغيره", "شاحنه كبيره", "ساحنة متوسطة"];

    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    imagePicker = new ImagePickerHandler(
        this, _controller, Color.fromRGBO(0, 150, 75, 1.0));
    imagePicker.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _blank = new FocusNode();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(_blank);
        },
        child: Stack(
          children: <Widget>[
            ImageBG(),
            Center(
              child: Container(
                padding: EdgeInsets.all(20),
                height: MediaQuery.of(context).size.height,
                child: ListView(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () => imagePicker.showDialog(context),
                          child: Stack(
                            children: <Widget>[
                              _image == null
                                  ? Center(
                                      child: Image.asset(
                                      'assets/images/newLoga.png',
                                      height: 150,
                                      fit: BoxFit.cover,
                                    ))
                                  : Center(
                                      child: Image.file(
                                      _image,
                                      height: 150,
                                      fit: BoxFit.cover,
                                    )),
                              Positioned(
                                bottom: 0,
                                right: 80,
                                child: CircleAvatar(
                                  child: Icon(
                                    Icons.add,
                                    color: Theme.of(context).primaryColor,
                                    size: 15,
                                  ),
                                  radius: 10,
                                  backgroundColor: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
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
                          "فضلا اكمل بيانات التسجيل",
                          style: TextStyle(color: Colors.black87, fontSize: 13),
                          textAlign: TextAlign.center,
                        )),
                        SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width * .43,
                              child: InputFieldArea(
                                changedFunction: (v) {
                                  Provider.of<SignUpProvider>(context,
                                          listen: false)
                                      .lastName = v;
                                },
                                textInputType: TextInputType.text,
                                labelTxt: 'الاسم الاخير',
                                hint: "اكتب هنا",
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * .43,
                              child: InputFieldArea(
                                changedFunction: (v) {
                                  Provider.of<SignUpProvider>(context,
                                          listen: false)
                                      .firstName = v;
                                },
                                textInputType: TextInputType.text,
                                labelTxt: 'الاسم الاول',
                                hint: "اكتب هنا",
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        InputFieldArea(
                          changedFunction: (v) {
                            Provider.of<SignUpProvider>(context, listen: false)
                                .email = v;
                          },
                          textInputType: TextInputType.emailAddress,
                          labelTxt: 'البريد الإكتروني (إختياري)',
                          hint: "اكتب هنا",
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InputFieldArea(
                          textInputType: TextInputType.text,
                          labelTxt: 'كلمة المرور',
                          hint: "اكتب هنا",
                          show: true,
                          changedFunction: (v) {
                            Provider.of<SignUpProvider>(context, listen: false)
                                .password = v;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InputFieldArea(
                          textInputType: TextInputType.text,
                          labelTxt: 'تأكيد كلمة المرور',
                          hint: "اكتب هنا",
                          show: true,
                          changedFunction: (v) {
                            Provider.of<SignUpProvider>(context, listen: false)
                                .passwordConfirmation = v;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: CustomTextContainer().customText(
                              text: _country != null ? _country : "السعودية",
                              state: true,
                              context: context,
                              onTap: () {
                                showModalBottomSheet(
                                    backgroundColor: Colors.black12,
                                    context: context,
                                    builder: (_) {
                                      return Container(
                                        height: 300,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft:
                                                  const Radius.circular(10.0),
                                              topRight:
                                                  const Radius.circular(10.0),
                                            ),
                                            color: Colors.white),
                                        child: ListView.builder(
                                          itemCount:
                                              Provider.of<CountriesProvider>(
                                                      context,
                                                      listen: false)
                                                  .getcountries
                                                  .length,
                                          itemBuilder: (_, index) {
                                            return Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: FlatButton(
                                                    child: Text(
                                                        "${Provider.of<CountriesProvider>(context, listen: false).getcountries[index].name}"),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      setState(() {
                                                        _country = Provider.of<CountriesProvider>( context,listen: false).getcountries[index].name;
                                                        Provider.of<SignUpProvider>(context,listen: false).countryId =
                                                            Provider.of<CountriesProvider>(context,listen: false).getcountries[index].id;
                                                        // _country = currentCity.name ;
                                                        print(
                                                            "_____________________________ currentCity is : $_country");
                                                        //   changeUserBloC.cityIdChanged(currentCity.id);
                                                        print("${Provider.of<CountriesProvider>(context,listen: false).getcountries[index].id}");
                                                      });
                                                    },
                                                  ),
                                                ),
                                                Divider(
                                                  indent: 10.0,
                                                  endIndent: 10.0,
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      );
                                    });
                              }),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: CustomTextContainer().customText(
                              state: true,
                              context: context,
                              text: _truck != null ? _truck : "شاحنة كبيرة",
                              onTap: () {
                                showModalBottomSheet(
                                    backgroundColor: Colors.black12,
                                    context: context,
                                    builder: (_) {
                                      return Container(
                                        height: 300,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft:
                                                  const Radius.circular(10.0),
                                              topRight:
                                                  const Radius.circular(10.0),
                                            ),
                                            color: Colors.white),
                                        child: ListView.builder(
                                          itemCount:
                                              Provider.of<TruclesProvider>(
                                                      context,
                                                      listen: false)
                                                  .trucles
                                                  .length,
                                          itemBuilder: (_, index) {
                                            return Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: FlatButton(
                                                    child: Text(
                                                        "${Provider.of<TruclesProvider>(context, listen: false).trucles[index].name}"),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      setState(() {
                                                        _truck = Provider.of<TruclesProvider>(context,listen: false).trucles[index].name;
                                                        Provider.of<SignUpProvider>(context,listen: false).truckleId =
                                                            Provider.of<TruclesProvider>(context,listen: false).trucles[index].id;
                                                        // _country = currentCity.name ;
                                                        print(
                                                            "_____________________________ currentCity is : $_truck");
                                                        //   changeUserBloC.cityIdChanged(currentCity.id);
                                                        print("${Provider.of<TruclesProvider>(context,listen: false).trucles[index].id}");
                                                      });
                                                    },
                                                  ),
                                                ),
                                                Divider(
                                                  indent: 10.0,
                                                  endIndent: 10.0,
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      );
                                    });
                              }),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              "المستندات",
                              textAlign: TextAlign.right,
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Documents(),
                        Container(
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Row(
                              children: <Widget>[
                                new Checkbox(
                                    value: isChecked,
                                    activeColor: Theme.of(context).primaryColor,
                                    onChanged: (bool newValue) {
                                      setState(() {
                                        isChecked = !isChecked;
                                      });
                                    }),
                                InkWell(
                                    onTap: () => showDialog(
                                        context: context,
                                        builder: (_) => SimpleDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              backgroundColor: Theme.of(context)
                                                  .primaryColor,
                                              children: <Widget>[
                                                Center(
                                                  child: Container(
                                                    height: 200,
                                                    width: 500,
                                                    child: ListView(
                                                      physics: ScrollPhysics(),
                                                      children: <Widget>[
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(
                                                          "المحتوى سوف يظهر في صفحة ويب",
                                                          maxLines: 100,
                                                          softWrap: true,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12,
                                                              fontFamily:
                                                                  'cairo'),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )),
                                    child: Text(
                                      'الموافقه علي الشروط والاحكام',
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontFamily: 'cairo',
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SignInButton(
                          txtColor: Colors.white,
                          onPressSignIn: () {
                            Provider.of<SignUpProvider>(context, listen: false)
                                .signUp(_deviceToken, context);
                          },
                          btnWidth: MediaQuery.of(context).size.width - 40,
                          btnHeight: MediaQuery.of(context).size.height * .07,
                          btnColor: btnColor,
                          buttonText: 'تسجيل',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  userImage(File _image) {
    setState(() {
      this._image = _image;
    });
  }
}
