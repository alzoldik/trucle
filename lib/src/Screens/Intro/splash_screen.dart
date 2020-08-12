import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:truckle_drivers/src/provider/get/getUserDataProvider.dart';

import '../../Components/custom_new_dialog.dart';
import '../../Components/image_bg.dart';
import '../../Repository/firebaseNotifications.dart';
import '../HomePages/main_page.dart';
import '../../Widgets/Connection/check_connection_screen.dart';
import 'countrySelect.dart';



class Splash extends StatefulWidget {
  final GlobalKey<NavigatorState> navigator;

  const Splash({Key key, this.navigator}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  AnimationController controller;

  Animation animation;
 // final _repo = Repository();


  SharedPreferences _preferences;

  _getShared() async {
    _preferences = await SharedPreferences.getInstance();
    _onDoneLoading();
     Provider.of<GetUserDataProvider>(context, listen: false)
        .getUserData(_preferences.get("token"));
//    if(_preferences.get("token") != null){
//      unreadCount(_preferences.get("token"));
//    }
  }

  Future<Timer> _loadData() async {
    return Timer(Duration(seconds: 3), checkConnection);
  }
  CustomDialog dialog = CustomDialog ();

  checkConnection() async {
    final result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => CheckConnectionScreen(state: false,)),
              (Route<dynamic> route) => false);

    } else if (result == ConnectivityResult.mobile) {
      _getShared();
    } else if (result == ConnectivityResult.wifi) {
      _getShared();
    }
  }

  _onDoneLoading() async {
    print("device token shared  : ${await _preferences.get('device_token')}");
    if (await _preferences.get('token') == null) {
      print('go to login');
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => CountrySelect(
            )));
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (_) => MainPage(
              )),
              (Route<dynamic> route) => false);
//      Repository().getOnlineUsers(
//              _preferences.get('token'))
//          .then((response) {
//        if (response.code == 401) {
//          print('another session');
//          if(response.error[0].value.contains("مطلوب")){
//            _preferences.clear();
//            Navigator.of(context).pushAndRemoveUntil(
//                MaterialPageRoute(builder: (_) => SignInScreen()),
//                    (Route<dynamic> route) => false);
//          }else{
//            Navigator.of(context).pushAndRemoveUntil(
//                MaterialPageRoute(
//                    builder: (_) => MainPage(
//                    )),
//                    (Route<dynamic> route) => false);
//          }
//        }else{
//          print('go to home');
//
//        }
//      });

    }
  }

  _initPlatformState() async {
    bool res = await FlutterAppBadger.isAppBadgeSupported();
    if (res) {
      print('Supported');
    } else {
      print('Not supported');
    }
    if (!mounted) return;
  }

  @override
  void initState() {
//    controller = AnimationController(vsync: this, duration: Duration(seconds: 2));
//    animation = Tween(begin: -1.0, end: 0.0).animate(
//        CurvedAnimation(parent: controller, curve: Curves.bounceOut));
//    controller.forward();
    _initPlatformState();
    _loadData();
    FirebaseNotifications().setUpFirebase(widget.navigator);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
 //   controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
    children: <Widget>[
      ImageBG(),
//          AnimatedBuilder(
//            animation: controller,
//            builder: (context, widget) {
//              return Transform(
//                transform:
//                    Matrix4.translationValues(0.0, animation.value * 600, 0.0),
//                child: Center(
//                  child: Image.asset(
//                    'assets/images/newLoga.png',
//                    width: 300,
//                    height: 500,
//                  ),
//                ),
//              );
//            },
//          ),
      Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*.2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/newLoga.png',
              width: 250,
              height: 250,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
//          Center(
//            child: Container(
//              margin:
//              EdgeInsets.only(top: MediaQuery.of(context).size.height * .65),
//                  child:  Center(
//                    child: Image.asset(
//                      'assets/images/flag.png',
//                      height: 40,
//                      fit: BoxFit.contain,
//                    ),
//                  ),
//            ),
//          ),
      Center(
        child: Container(
          margin:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * .8),
          child: Shimmer.fromColors(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Truckle Drivers",
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    " مرحبا بكم في تطبيق ",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              baseColor: Colors.black,
              highlightColor: Colors.white),
        ),
      )
    ],
      ),
    );
  }
}
