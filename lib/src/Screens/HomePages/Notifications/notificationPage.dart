import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:truckle_drivers/src/Components/image_bg.dart';
import 'package:truckle_drivers/src/Widgets/custom_app_bar_back_ground.dart';
import 'package:truckle_drivers/src/provider/get/notificationProvider.dart';
import 'package:truckle_drivers/src/provider/post/deleteNotificationProvider.dart';

import 'Widgets/notificationCard.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  SharedPreferences _preferences;
  getShared() async {
    _preferences = await SharedPreferences.getInstance();
    Provider.of<NotoficationProvider>(context, listen: false)
        .getNotification(_preferences.get("token"));
  }

  @override
  void initState() {
    getShared();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
      ImageBG(),
      Padding(
        padding: const EdgeInsets.only(top:130.0),
        child: ListView.builder(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemCount:
              Provider.of<NotoficationProvider>(context).notfications.length,
          itemBuilder: (context, index) {
            return NotificationCard(
              index: index,
              onTap: () {

                setState(() {
                  Provider.of<DeletNotificationProvider>(context,listen: false).deletNot(_preferences.get("token"), 
                  Provider.of<NotoficationProvider>(context,listen: false).notfications[index].id ,index, context);
                  Provider.of<NotoficationProvider>(context,listen: true).notfications.removeAt(index);

                });
              },
            );
          },
        ),
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
                      "الاشعارات",
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
    ]);
  }
}