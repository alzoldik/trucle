import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:truckle_drivers/src/Screens/HomePages/masterScreen/internal/orderDetails.dart';
import 'package:truckle_drivers/src/Widgets/custom_app_bar_back_ground.dart';
import 'package:truckle_drivers/src/provider/get/citiesProvider.dart';
import 'package:truckle_drivers/src/provider/get/pinOrdersProvider.dart';

class OrderCenter extends StatefulWidget {
  @override
  _OrderCenterState createState() => _OrderCenterState();
}

class _OrderCenterState extends State<OrderCenter> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  // List<CitiesModel> cities = [];
  List<String> title = ["قطر", "السعودية", "عمان", "الامارات", "البحرين"];
  String citeId;
  // @override
  // void initState() {
  //   super.initState();
  //   //  if (getCitiesByCountryIdModel.data != null) {

  //   // }
  // }

  SharedPreferences _prefs;
  _getShared() async {
    var _instance = await SharedPreferences.getInstance();
    setState(() {
      _prefs = _instance;
    });
    Provider.of<PinOrderOrderProvider>(context, listen: false)
        .getPinOrders(_prefs.get("token"), null);
    Provider.of<CitiesProvider>(context, listen: false).getCities();
    //  for (int i = 0; i < Provider.of<CitiesProvider>(context,).coties.length; i++) {
    //   cities.add(new CitiesModel(id: Provider.of<CitiesProvider>(context, listen: false).coties[i].id, label: Provider.of<CitiesProvider>(context, listen: false).coties[i].name, selected: false));
    // }
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
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(
            MediaQuery.of(context).size.height / 4,
          ),
          child: CustomAppBarBackGround(
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
                          "مركز الطلبات",
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
                          onTap: () {
                            mainBottomSheet(context, "city");
                          },
                          child: Icon(
                            Icons.pin_drop,
                            color: Colors.white,
                          )),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        key: scaffoldKey,
        body: Provider.of<PinOrderOrderProvider>(
                  context,
                ).pinedOrders.length ==
                0
            ? Center(
                child: Text("لا يوجد طلبات"),
              )
            : ListView(
                children: <Widget>[
                  ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: //1,
                        Provider.of<PinOrderOrderProvider>(
                      context,
                    ).pinedOrders.length,
                    itemBuilder: (context, index) {
                      return Details(
                        isOrder: true,
                        index: index,
                        orderState: 3,
                        pin: true,
                        token: _prefs.get("token"),
                      );
                    },
                  ),
                ],
              ),
      ),
    );
  }

  mainBottomSheet(BuildContext context, String title) {
    return showModalBottomSheet<dynamic>(
        isScrollControlled: false,
        backgroundColor: Colors.white,
        context: context,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        builder: (BuildContext bc) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: ListView(children: <Widget>[
                Container(
                  color: Colors.white,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: Provider.of<CitiesProvider>(
                      context,
                    ).coties.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 40,
                            child: ListTile(
                                onTap: () {
                                  print(Provider.of<CitiesProvider>(context,
                                          listen: false)
                                      .coties[index]
                                      .id);
                                  if (_prefs != null) {
                                    Provider.of<PinOrderOrderProvider>(context,
                                            listen: false)
                                        .clearList();
                                    Provider.of<PinOrderOrderProvider>(context,
                                            listen: false)
                                        .getPinOrders(
                                            _prefs.get("token"),
                                            Provider.of<CitiesProvider>(context,
                                                    listen: false)
                                                .coties[index]
                                                .id);
                                  }
                                  Navigator.pop(context);
                                  setState(() {
                                    citeId = Provider.of<CitiesProvider>(
                                            context,
                                            listen: false)
                                        .coties[index]
                                        .id
                                        .toString();
                                    print("citeid $citeId");
                                  });

                                  setState(() {
                                    Provider.of<CitiesProvider>(context,
                                                listen: false)
                                            .coties[index]
                                            .selected =
                                        !Provider.of<CitiesProvider>(context,
                                                listen: false)
                                            .coties[index]
                                            .selected;
                                    for (int i = 0;
                                        i <
                                            Provider.of<CitiesProvider>(context,
                                                    listen: false)
                                                .coties
                                                .length;
                                        i++) {
                                      if (i == index) {
                                      } else {
                                        Provider.of<CitiesProvider>(context,
                                                listen: false)
                                            .coties[index]
                                            .selected = false;
                                      }
                                    }
                                  });
                                },
                                trailing: CircleAvatar(
                                  child: Icon(
                                    Icons.check,
                                    size: 10,
                                  ),
                                  radius: 10,
                                  backgroundColor: Provider.of<CitiesProvider>(
                                                  context,
                                                  listen: false)
                                              .coties[index]
                                              .selected ==
                                          true
                                      ? Colors.yellow[600]
                                      : Theme.of(context).primaryColor,
                                ),
                                selected: Provider.of<CitiesProvider>(context,
                                        listen: false)
                                    .coties[index]
                                    .selected,
                                title: Text(
                                  Provider.of<CitiesProvider>(context,
                                          listen: false)
                                      .coties[index]
                                      .name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Provider.of<CitiesProvider>(context,
                                                    listen: false)
                                                .coties[index]
                                                .selected ==
                                            true
                                        ? Colors.yellow[600]
                                        : Theme.of(context).primaryColor,
                                  ),
                                )),
                          ),
                          Divider()
                        ],
                      );
                    },
                  ),
                ),
              ]),
            ),
          );
        });
  }
}

class CitiesModel {
  int id;
  String label;
  bool selected;

  CitiesModel({this.id, this.label, this.selected});
}
