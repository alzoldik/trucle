import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:truckle_drivers/src/Widgets/custom_app_bar_back_ground.dart';
import 'package:truckle_drivers/src/provider/get/newPaymentProvider.dart';
import 'package:truckle_drivers/src/provider/get/paidPaymentProvider.dart';

import 'widget/paymentCard.dart';

class MyPayment extends StatefulWidget {
  @override
  _MyPaymentState createState() => _MyPaymentState();
}

class _MyPaymentState extends State<MyPayment> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int orderState = 3;
  SharedPreferences _prefs;
  _getShared() async {
    var _instance = await SharedPreferences.getInstance();
    setState(() {
      _prefs = _instance;
    });
    Provider.of<NewPaymentProvider>(context, listen: false)
        .getNewPayment(_prefs.get("token"));
    Provider.of<PaidPaymentProvider>(context, listen: false)
        .getPaidPayment(_prefs.get("token"));
    // Provider.of<ActiveOrderProvider>(context, listen: false)
    //     .getActiveOrders(_prefs.get("token"));
    // Provider.of<CompeletOrderProvider>(context, listen: false)
    //     .getCompeletOrders(_prefs.get("token"));
    // Provider.of<RejectedOrderProvider>(context, listen: false)
    //     .getRejectedOrders(_prefs.get("token"));
  }

  @override
  void initState() {
    _getShared();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        body: Stack(
          children: <Widget>[
            ListView(
              children: <Widget>[
                Container(
                  height: height * .12,
                  margin: EdgeInsets.only(top: height * .12),
                  width: width,
                  decoration: BoxDecoration(color: Colors.white),
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 10),
                      height: 50,
                      width: width - 20,
                      // color: Colors.red,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: _list.length,
                          itemBuilder: (_, index) => Padding(
                                padding:
                                    const EdgeInsets.only(right: 0.0, left: 8),
                                child: listViewCard(
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
                                }, width, _list[index]["accentColor"]),
                              )),
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    //  return Details(isOrder: true);
                    return MyPayments(
                      isOrder: true,
                      //  orderState: orderState,
                    );
                  },
                ),
              ],
            ),
            CustomAppBarBackGround(
              widgets: <Widget>[
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          height: 60,
                          alignment: Alignment.center,
                          child: Text(
                            "عمولاتي",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: InkWell(
                            // onTap: () {
                            // //  mainBottomSheet(context, cities, "city");
                            // },
                            child: Icon(
                          Icons.pin_drop,
                          color: Theme.of(context).primaryColor,
                        )),
                      )
                    ],
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
      "name": "مسددة",
      "color": Color.fromRGBO(19, 19, 19, 1.0),
      "txtColor": Colors.white,
      "accentColor": Color.fromRGBO(19, 19, 19, 1.0),
    },
    {
      "name": "مستحقة",
      "color": Colors.grey[300],
      "txtColor": Colors.black87,
      "accentColor": Colors.grey[300],
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
          width: width / 2.5,
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
