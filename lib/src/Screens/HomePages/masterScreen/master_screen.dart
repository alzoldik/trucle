import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:truckle_drivers/src/Components/customBtn.dart';
import 'package:truckle_drivers/src/Screens/HomePages/masterScreen/internal/orderCenter.dart';
import 'package:truckle_drivers/src/Widgets/custom_app_bar_back_ground.dart';
import 'package:truckle_drivers/src/Widgets/user_data.dart';
import 'package:truckle_drivers/src/provider/helpCenter.dart';
import 'package:url_launcher/url_launcher.dart';

class MasterScreen extends StatefulWidget {
  @override
  _MasterScreenState createState() => _MasterScreenState();
}

class _MasterScreenState extends State<MasterScreen> {
  List<ServicesModel> services = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(
              MediaQuery.of(context).size.height / 4,
            ),
            child: Stack(
              children: <Widget>[
                CustomAppBarBackGround(
                  height: MediaQuery.of(context).size.height / 4,
                  widgets: <Widget>[
                    Expanded(
                      child: Text(""),
                    ),
                  ],
                ),
                UserData(),
              ],
            )),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text("شاحنة مقطورة"),
            Column(
              children: <Widget>[
                Container(
                  height: 100,
                  width: 1,
                  color: Colors.grey,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => OrderCenter(
                          
                        )));
                  },
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Theme.of(context).primaryColor),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.note,
                          color: Colors.white,
                          size: 40,
                        ),
                        Text(
                          "13",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text("مركز الطلبات"),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                CustomBtn(
                  txtColor: Colors.white,
                  onTap: () {
                    _callUser();
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (_) => RegisterMobileScreen()));
                  },
                  color: Theme.of(context).primaryColor,
                  text: 'اتصل بنا',
                  icon: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Icon(
                      Icons.phone,
                      color: Colors.white,
                    ),
                  ),
                  hegh: 35,
                  wedth: 140,
                ),
                CustomBtn(
                  txtColor: Colors.white,
                  onTap: () {
                    _sendWhatsApp();
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (_) => RegisterMobileScreen()));
                  },
                  color: Theme.of(context).accentColor,
                  text: 'تواصل معنا',
                  icon: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Icon(
                      FontAwesomeIcons.whatsapp,
                      color: Colors.white,
                    ),
                  ),
                  hegh: 35,
                  wedth: 140,
                ),
              ],
            ),
          ],
        ));
  }

  _sendWhatsApp() async {
    var url =
        "https://wa.me/${Provider.of<HelpCenterProvider>(context, listen: false).phone}?text=السلام عليكم";
    await canLaunch(url) ? launch(url) : print('No WhatsAPP');
  }

  _callUser() async {
    launch(
        "tel:${Provider.of<HelpCenterProvider>(context, listen: false).phone}");
  }
}

class SectionModel {
  final IconData icon;
  final String name;
  final Function onTap;

  SectionModel({this.icon, this.name, this.onTap});
}

class ServicesModel {
  final String image;
  final String name;

  ServicesModel({this.name, this.image});
}
