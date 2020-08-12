import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserData extends StatefulWidget {
  @override
  _UserDataState createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {
  SharedPreferences _prefs;
  _getShared() async {
    var _instance = await SharedPreferences.getInstance();
    setState(() {
      _prefs = _instance;
    });
  }

  @override
  void initState() {
    _getShared();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        Text(
          "مرحبا بك",
          style: TextStyle(color: Colors.white),
        ),
        Text(_prefs == null ? "" : _prefs.get("name"),
            style: TextStyle(color: Colors.white)),
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 8.0, right: 8, left: 8),
              child: Text(
                  _prefs == null ? "" : _prefs.get("countRate") == null ? "0" :_prefs.get("countRate").toString(),
                  style: TextStyle(color: Colors.white)),
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: FlutterRatingBar(
                itemCount: 5,
                itemSize: 20,
                allowHalfRating: false,
                initialRating: _prefs == null ? 0 : _prefs.get("rate") == null ? 0 : _prefs.get("rate"),
                itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                fullRatingWidget: Icon(Icons.star, color: Colors.amber, size: 20),
                noRatingWidget:
                    Icon(Icons.star_border, color: Colors.amber, size: 20),
                onRatingUpdate: null,
              ),
            ),
            // RatingBar(
            //   initialRating:_prefs == null ? 0 : _prefs.get("rate"),
            //   minRating: 1,
            //   direction: Axis.horizontal,
            //   allowHalfRating: true,
            //   itemCount: 5,
            //   itemSize: 15,
            //   itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
            //   itemBuilder: (context, _) => Icon(
            //     Icons.star,
            //     size: 10,
            //     color: Colors.amber,
            //   ),
            //   onRatingUpdate: (double value) {},
            // ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: Theme.of(context).primaryColor, width: 5)),
              child: CircleAvatar(
                  radius: 45,
                  backgroundImage: _prefs == null||_prefs.get("image")  == null 
                      ? AssetImage("assets/images/avatar.jpeg")
                      : NetworkImage(_prefs.get("image"))),
            )
          ],
        )
      ],
    );
  }
}
