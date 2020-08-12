import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:truckle_drivers/src/Widgets/custom_app_bar_back_ground.dart';
import 'package:truckle_drivers/src/provider/aboutUsProvider.dart';

import 'package:url_launcher/url_launcher.dart';

class AboutApp extends StatefulWidget {
  @override
  _AboutAppState createState() => _AboutAppState();
}

class _AboutAppState extends State<AboutApp> {
  _launchURL() async {
    const url = 'https://tqnee.com.sa';
    launch(url);
  }

  @override
  void initState() {
    super.initState();
    Provider.of<AboutUsProvider>(context, listen: false).getAboutUs();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .15,
                    ),
                    Provider.of<AboutUsProvider>(
                              context,
                            ).content ==
                            null
                        ? SpinKitThreeBounce(
                            color: Theme.of(context).primaryColor,
                            size: 22,
                          )
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              Provider.of<AboutUsProvider>(context,
                                      listen: false)
                                  .content,
                              textAlign: TextAlign.right,
                            ),
                          )
                  ],
                ),
                InkWell(
                  onTap: _launchURL,
                  child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'تصميم وتنفيذ تقني لتقنية المعملومات',
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(color: Colors.blueAccent, fontSize: 12),
                      )),
                ),
              ],
            ),
            CustomAppBarBackGround(
              widgets: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Container(
                      height: 60,
                      alignment: Alignment.center,
                      child: Text(
                        "عن التطبيق",
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
          ],
        ),
      ),
    );
  }
}
