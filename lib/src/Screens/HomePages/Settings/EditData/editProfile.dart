import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:truckle_drivers/src/Components/buttonSignIn.dart';
import 'package:truckle_drivers/src/Components/inputTextField.dart';
import 'package:truckle_drivers/src/Screens/HomePages/Settings/EditData/editPassword.dart';
import 'package:truckle_drivers/src/Widgets/ImagePicker/image_picker_handler.dart';
import 'package:truckle_drivers/src/Widgets/custom_app_bar_back_ground.dart';
import 'package:truckle_drivers/src/provider/changeData/changePhoneProvider.dart';
import 'package:truckle_drivers/src/provider/changeData/editAcountProvider.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile>
    with TickerProviderStateMixin, ImagePickerListener {
  SharedPreferences _pref;

  getShared() async {
    _pref = await SharedPreferences.getInstance();
    setState(() {
      _pref =_pref;
    });

  }

  ImageProvider imageProvider = AssetImage("assets/avatar.jpg");

  File _image;
  TextEditingController _nameController;
  TextEditingController _emailController;

  TextEditingController _phoneController;

  AnimationController _controller;
  ImagePickerHandler imagePicker;

  @override
  void initState() {
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    imagePicker = new ImagePickerHandler(
        this, _controller, Color.fromRGBO(12, 169, 149, 1));
    imagePicker.init();
    getShared();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: _pref == null
            ? Container()
            : Stack(
                children: <Widget>[
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.width * .46),
                      child: Container(
                        padding: EdgeInsets.all(8),
                        width: MediaQuery.of(context).size.width * .9,
                        child: ListView(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                InputFieldArea(
                                  border: false,
                                  hint: "اسم المستخدم",
                                  changedFunction: (v) {
                                    Provider.of<EditUserDataProvider>(context,
                                            listen: false)
                                        .name = v;
                                  },
                                  textInputType: TextInputType.text,
                                  controller: _nameController,
                                  suffixIcon: Icon(
                                    Icons.edit,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  init: _pref.get("name"),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                InputFieldArea(
                                  border: false,
                                  hint: "البريد الالكتروني",
                                  changedFunction: (v) {
                                    Provider.of<EditUserDataProvider>(context,
                                            listen: false)
                                        .email = v;
                                  },
                                  textInputType: TextInputType.text,
                                  controller: _emailController,
                                  suffixIcon: Icon(
                                    Icons.edit,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  init: _pref.get("email"),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                SignInButton(
                                  txtColor: Colors.white,
                                  onPressSignIn: () {
                                    Provider.of<EditUserDataProvider>(context,
                                            listen: false)
                                        .changeUserData(_pref.get("token"),context);
                                  },
                                  btnWidth:
                                      MediaQuery.of(context).size.width - 40,
                                  btnHeight:
                                      MediaQuery.of(context).size.height * .07,
                                  btnColor: Theme.of(context).primaryColor,
                                  buttonText: "تعديل بيانات المستخدم",
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: InputFieldArea(
                                    changedFunction: (v) {
                                      Provider.of<ChangeMobileProvider>(context,
                                              listen: false)
                                          .phone = v;
                                    },
                                    border: false,
                                    hint: _pref.get("phone"),
                                    textInputType: TextInputType.number,
                                    controller: _phoneController,
                                    suffixIcon: Icon(
                                      Icons.edit,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SignInButton(
                                  txtColor: Colors.white,
                                  onPressSignIn: () {
                                    Provider.of<ChangeMobileProvider>(context,
                                            listen: false)
                                        .changeMobile(_pref.get("token"),context);
                                  },
                                  btnWidth:
                                      MediaQuery.of(context).size.width - 40,
                                  btnHeight:
                                      MediaQuery.of(context).size.height * .07,
                                  btnColor: Theme.of(context).primaryColor,
                                  buttonText: 'تعديل رقم الجوال',
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Divider(
                              height: 2,
                              color: Colors.grey,
                            ),
                            EditPassword()
                          ],
                        ),
                      ),
                    ),
                  ),
                  CustomAppBarBackGround(
                    widgets: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Container(
                            height: 60,
                            alignment: Alignment.center,
                            child: Text(
                              "تعديل حسابي",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.format_align_right,
                            color: Theme.of(context).primaryColor),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * .05),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 5)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              InkWell(
                                onTap: () => imagePicker.showDialog(context),
                                child: _image == null
                                    ? CachedNetworkImage(
                                        imageUrl: _pref
                                                    .getString("photo") !=
                                                null
                                            ? _pref.getString("photo")
                                            : "",
                                        fadeInDuration: Duration(seconds: 2),
                                        placeholder: (context, url) =>
                                            CircleAvatar(
                                                radius: 60,
                                                backgroundImage: AssetImage(
                                                    'assets/images/avatar.jpeg')),
                                        imageBuilder: (context, provider) {
                                          return CircleAvatar(
                                              radius: 60,
                                              backgroundImage: provider);
                                        },
                                      )
                                    : Container(
                                        child: CircleAvatar(
                                          radius: 60,
                                          backgroundImage:
                                              Image.file(_image).image,
                                        ),
                                      ),
                              ),
                              Positioned(
                                bottom: 5,
                                right: 10,
                                child: InkWell(
                                  onTap: () => imagePicker.showDialog(context),
                                  child: CircleAvatar(
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.black,
                                      size: 15,
                                    ),
                                    radius: 10,
                                    backgroundColor: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          )
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
       Provider.of<EditUserDataProvider>(context, listen: false).image = _image;
    });
  }
}
