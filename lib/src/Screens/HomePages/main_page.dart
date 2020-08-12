import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:ff_navigation_bar/ff_navigation_bar_item.dart';
import 'package:ff_navigation_bar/ff_navigation_bar_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:truckle_drivers/src/Repository/firebaseNotifications.dart';
import 'package:truckle_drivers/src/Screens/HomePages/Notifications/notificationPage.dart';
import 'package:truckle_drivers/src/Screens/HomePages/masterScreen/master_screen.dart';
import 'package:truckle_drivers/src/Widgets/Connection/dialogs.dart';
import 'package:truckle_drivers/src/Widgets/Connection/internet_connectivity.dart';
import 'package:truckle_drivers/src/provider/helpCenter.dart';

import '../../../main.dart';
import 'MyTravels/myTravels.dart';
import 'Settings/more.dart';

class MainPage extends StatefulWidget {
  static final String homePage = "home";
  final index;

  const MainPage({Key key, this.index}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  TabController controller;
  SharedPreferences _preferences;

  getShared() async {
    _preferences = await SharedPreferences.getInstance();
    Provider.of<HelpCenterProvider>(context, listen: false).token = _preferences.get("token");

    Provider.of<HelpCenterProvider>(context, listen: false).getPhone();

//    if(_preferences.get("hello") != null){
//      CustomDialog().showSuccessDialog(
//        context: context ,
//      //  msg: " اهلا بك ${_preferences.get("username")} " ,
//        msg: "اهلا بك شركة تقني"
//      );
//    }
//    Repository().online(_preferences.get("token"), 1);
  }

  Position _startPosition;
  Geolocator _geoLocator = Geolocator();

  Future<Position> _getLocation() async {
    var currentLocation;
    try {
      currentLocation = await _geoLocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      setState(() {
        _startPosition = currentLocation;
        print("can i get my position");
        _preferences.setDouble("long", _startPosition.longitude);
        _preferences.setDouble("lat", _startPosition.latitude);
      });
    } catch (e) {
      currentLocation = null;
    }
    return currentLocation;
  }

  static final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  FirebaseNotifications appPushNotifications = FirebaseNotifications();

  final MethodChannel platform =
      MethodChannel('crossingthestreams.io/resourceResolver');

  void _requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  void _configureDidReceiveLocalNotificationSubject() {
    didReceiveLocalNotificationSubject.stream
        .listen((ReceivedNotification receivedNotification) async {
      await showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: receivedNotification.title != null
              ? Text(receivedNotification.title)
              : null,
          content: receivedNotification.body != null
              ? Text(receivedNotification.body)
              : null,
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text('Ok'),
              onPressed: () async {
                Navigator.of(context, rootNavigator: true).pop();
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainPage(),
                  ),
                );
              },
            )
          ],
        ),
      );
    });
  }

  void _configureSelectNotificationSubject() {
    selectNotificationSubject.stream.listen((String payload) async {
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainPage()),
      );
    });
  }

  Future<void> _showNotification(String title, body) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin
        .show(0, title, body, platformChannelSpecifics, payload: 'item x');
  }

  @override
  void initState() {
    if (widget.index != null) {
      _selectedIndex = widget.index;
    }
    _requestIOSPermissions();
    _configureDidReceiveLocalNotificationSubject();
    _configureSelectNotificationSubject();
    _getLocation();
    controller = TabController(vsync: this, length: 4);
    MyConnectivity.instance.initialise();
    MyConnectivity.instance.myStream.listen((onData) {
      if (MyConnectivity.instance.isIssue(onData)) {
        if (MyConnectivity.instance.isShow == false) {
          MyConnectivity.instance.isShow = true;
          showDialogNotInternet(context).then((onValue) {
            MyConnectivity.instance.isShow = false;
          });
        }
      } else {
        if (MyConnectivity.instance.isShow == true) {
          Navigator.of(context).pop();
          MyConnectivity.instance.isShow = false;
        }
      }
      appPushNotifications.notificationSubject.stream.listen((data) async {
        print("------------------XXXXXX-------- $data");
        print("------------------XXXXXX-------- ${data.length}");

        await _showNotification(
            data['notification']['title'], data['notification']['body']);
      }).onError((err) {
        print("------------------- $err");
      });
    });

    getShared();
    super.initState();
  }

  int _selectedIndex = 3;

  static final List<Widget> _widgetOptions = [
    NotificationPage(),
    MyTravels(),
    More(),
    MasterScreen(),
  ];

  @override
  void dispose() {
    appPushNotifications.killNotification();
    didReceiveLocalNotificationSubject.close();
    selectNotificationSubject.close();
    super.dispose();
  }

  // ignore: unused_field
  GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _globalKey,
        bottomNavigationBar: FFNavigationBar(
          theme: FFNavigationBarTheme(
            barBackgroundColor: Theme.of(context).primaryColor,
            selectedItemBorderColor: Theme.of(context).primaryColor,
            selectedItemBackgroundColor: Colors.white,
            selectedItemTextStyle: TextStyle(color: Colors.white),
            selectedItemIconColor: Theme.of(context).primaryColor,
            selectedItemLabelColor: Colors.white,
          ),
          selectedIndex: _selectedIndex,
          onSelectTab: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: [
            FFNavigationBarItem(
              iconData: Icons.notifications,
              label: 'الاشعارات',
            ),
            FFNavigationBarItem(
              iconData: Icons.insert_drive_file,
              label: 'رحلاتي',
            ),
            FFNavigationBarItem(
              iconData: Icons.person,
              label: 'حسابي',
            ),
            FFNavigationBarItem(
              iconData: Icons.home,
              label: 'الرئيسية',
            ),
          ],
        ),
        body: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }
}
