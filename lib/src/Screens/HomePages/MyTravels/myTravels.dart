import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:truckle_drivers/src/Screens/HomePages/masterScreen/internal/orderDetails.dart';
import 'package:truckle_drivers/src/Widgets/custom_app_bar_back_ground.dart';
import 'package:truckle_drivers/src/provider/get/activeOrderProvider.dart';
import 'package:truckle_drivers/src/provider/get/compeletOrdersProvider.dart';
import 'package:truckle_drivers/src/provider/get/newOrdersProvider.dart';
import 'package:truckle_drivers/src/provider/get/rejectOrdersProvider.dart';

class MyTravels extends StatefulWidget {
  @override
  _MyTravelsState createState() => _MyTravelsState();
}

class _MyTravelsState extends State<MyTravels> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int orderState = 3;
  SharedPreferences _prefs;
  _getShared() async {
    var _instance = await SharedPreferences.getInstance();
    setState(() {
      _prefs = _instance;
    });
    Provider.of<NewsOrdersProvider>(context, listen: false)
        .getNewsOrders(_prefs.get("token"));
    Provider.of<ActiveOrderProvider>(context, listen: false)
        .getActiveOrders(_prefs.get("token"));
    Provider.of<CompeletOrderProvider>(context, listen: false)
        .getCompeletOrders(_prefs.get("token"));
    Provider.of<RejectedOrderProvider>(context, listen: false)
        .getRejectedOrders(_prefs.get("token"));
  }

  @override
  void initState() {
    super.initState();
    _getShared();
    // numb = widget.orderType;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        body: Stack(
          children: <Widget>[
            ListView(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * .12),
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: Colors.white),
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 10),
                      height: 50,
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: _list.length,
                          itemBuilder: (_, index) => listViewCard(
                                  _list[index]["name"],
                                  _list[index]["color"],
                                  _list[index]["txtColor"], () {
                                setState(() {
                                  orderState = index;
                                });
                                for (int i = 0; i < _list.length; i++) {
                                  if (_list[i]["color"] ==
                                      Theme.of(context).primaryColor) {
                                    setState(() {
                                      _list[i]["color"] = Colors.grey[300];
                                      _list[i]["txtColor"] = Colors.black87;
                                      _list[i]["accentColor"] =
                                          Colors.grey[300];
                                    });
                                  }
                                }
                                print("index is + $index");
                                setState(() {
                                  _list[index]["color"] =
                                      Theme.of(context).primaryColor;
                                  _list[index]["txtColor"] = Colors.white;
                                  _list[index]["accentColor"] =
                                      Theme.of(context).primaryColor;
                                });
                              }, MediaQuery.of(context).size.width,
                                  _list[index]["accentColor"])),
                    ),
                  ),
                ),
                orderState == 2 &&
                            Provider.of<ActiveOrderProvider>(
                                  context,
                                ).error ==
                                true ||
                        orderState == 3 &&
                            Provider.of<NewsOrdersProvider>(
                                  context,
                                ).error ==
                                true ||
                        orderState == 1 &&
                            Provider.of<CompeletOrderProvider>(
                                  context,
                                ).error ==
                                true ||
                        orderState == 0 &&
                            Provider.of<RejectedOrderProvider>(
                                  context,
                                ).error ==
                                true
                    ? Container(
                        height: MediaQuery.of(context).size.height - 300,
                        child: Center(
                          child: Text("لا يوجد طلبات"),
                        ))
                    :
                    _prefs == null ? Center(
                      child: CircularProgressIndicator(),
                    ):
                     ListView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: orderState == 2
                            ? Provider.of<ActiveOrderProvider>(
                                context,
                              ).activitedOrders.length
                            : orderState == 3
                                ? Provider.of<NewsOrdersProvider>(
                                    context,
                                  ).newOrders.length
                                : orderState == 1
                                    ? Provider.of<CompeletOrderProvider>(
                                        context,
                                      ).compeletedOrders.length
                                    : Provider.of<RejectedOrderProvider>(
                                        context,
                                      ).rejectiesOrders.length,
                        itemBuilder: (context, index) {
                          // return Details(
                          //   isOrder: true,
                          //   orderState: orderState,
                          //   index: index,
                          // );
                          return Details(
                            isOrder: true,
                            orderState: orderState,
                            index: index,
                            token: _prefs.get("token"),
                          );
                        },
                      ),
              ],
            ),
            CustomAppBarBackGround(
              widgets: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Container(
                      height: 60,
                      alignment: Alignment.center,
                      child: Text(
                        "رحلاتي",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  var _list = [
    {
      "name": "ملغية",
      "color": Colors.grey[300],
      "txtColor": Colors.black87,
      "accentColor": Colors.grey[300],
    },
    {
      "name": "مكتملة",
      "color": Colors.grey[300],
      "txtColor": Colors.black87,
      "accentColor": Colors.grey[300],
    },
    {
      "name": "نشطة",
      "color": Colors.grey[300],
      "txtColor": Colors.black87,
      "accentColor": Colors.grey[300],
    },
    {
      "name": "جديدة",
      "color": Color.fromRGBO(19, 19, 19, 1.0),
      "txtColor": Colors.white,
      "accentColor": Color.fromRGBO(19, 19, 19, 1.0),
    },
  ];

  Widget listViewCard(
    String name,
    Color containerColor,
    Color textColor,
    GestureTapCallback onTap,
    double width,
    Color accentColor,
  ) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: width * .2,
          height: 50,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: accentColor == null
                    ? [containerColor, containerColor]
                    : [containerColor, accentColor]),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Center(
              child: Text(
            name,
            style: TextStyle(
                fontSize: 15,
                color: textColor == null ? Colors.white : textColor,
                fontFamily: "cairo"),
            textAlign: TextAlign.center,
          )),
        ),
      ),
    );
  }
}
