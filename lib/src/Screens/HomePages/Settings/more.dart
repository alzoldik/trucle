import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:truckle_drivers/src/Components/custom_option_card.dart';
import 'package:truckle_drivers/src/Widgets/custom_app_bar_back_ground.dart';
import 'package:truckle_drivers/src/Screens/Registeration/sign_in_screen.dart';
import 'package:truckle_drivers/src/Widgets/user_data.dart';

import 'package:url_launcher/url_launcher.dart';

import 'EditData/editProfile.dart';
import 'Internal/about.dart';
import 'Internal/terms.dart';
import 'payment/myPayment.dart';

class More extends StatefulWidget {
  @override
  _MoreState createState() => _MoreState();
}

class _MoreState extends State<More> {
  SharedPreferences _prefs;

  _getShared() async {
    var _instance = await SharedPreferences.getInstance();
    setState(() {
      _prefs = _instance;
    });
  }

  CustomOptionCard _optionCard = CustomOptionCard();

  // ignore: unused_element
  _launchURL() async {
    const url = 'https://tqnee.com.sa';
    launch(url);
  }

  // ignore: unused_element
  _sendWhatsApp() async {
    var url = "whatsapp://send?phone=+966580491109";
    await canLaunch(url) ? launch(url) : print('No WhatsAPP');
  }

  @override
  void initState() {
    super.initState();
    _getShared();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ListView(
          children: <Widget>[
            CustomAppBarBackGround(
              height: MediaQuery.of(context).size.height * .2,
              widgets: <Widget>[
                Expanded(
                  child: Text(""),
                ),
              ],
            ),
            SizedBox(height: 50),
            _optionCard.optionCard(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EditProfile())),
                label: 'تعديل حسابي ',
                icon: "assets/images/001.png"),
            _optionCard.optionCard(
              icon: "assets/images/002.png",
             onTap: () => Navigator.push(context,
                 MaterialPageRoute(builder: (context) => MyPayment(
                  // isOrder: true,
                 ))),
             // onTap: null,
              label: 'عمولاتي',
            ),
            _optionCard.optionCard(
                onTap: () {
                  Theme.of(context).platform != TargetPlatform.iOS
                      ? shareTheApp()
                      : shareTheAppIOS();
                },
                label: 'مشاركة التطبيق',
                icon: "assets/images/003.png"),
            _optionCard.optionCard(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutApp())),
                label: 'عن التطبيق   ',
                icon: "assets/images/004.png"),
            _optionCard.optionCard(
              icon: "assets/images/005.png",
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => TermsApp())),
              label: 'الشروط و الاحكام',
            ),
            _optionCard.optionCard(
              icon: "assets/images/006.png",
              onTap: () {
                _prefs.clear();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignInScreen(),
                  ),
                  (Route<dynamic> route) => false,
                );
              },
              label: 'خروج',
            ),
          ],
        ),
        UserData(),
      ],
    );
  }

  shareTheApp() async {
    try {
      String _msg;
      StringBuffer _sb = new StringBuffer();
      setState(() {
        _sb.write("لتنزيل التطبيق اضغط على الرابط\n");
        _sb.write("");
        _msg = _sb.toString();
      });
      final ByteData bytes = await rootBundle.load('assets/images/newLogo.png');
      await Share.file(
          'esys image', 'esys.png', bytes.buffer.asUint8List(), 'image/png',
          text: _msg);
    } catch (e) {
      print('error: $e');
    }
  }

  shareTheAppIOS() async {
    try {
      String _msg;
      StringBuffer _sb = new StringBuffer();
      setState(() {
        _sb.write("لتنزيل التطبيق اضغط على الرابط\n");
        _sb.write("");
        _msg = _sb.toString();
      });
      final ByteData bytes = await rootBundle.load('assets/images/newLogo.png');
      await Share.file(
          'esys image', 'esys.png', bytes.buffer.asUint8List(), 'image/png',
          text: _msg);
    } catch (e) {
      print('error: $e');
    }
  }
}
