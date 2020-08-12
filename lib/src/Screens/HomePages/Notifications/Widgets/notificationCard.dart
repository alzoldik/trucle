
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:truckle_drivers/src/provider/get/notificationProvider.dart';


class NotificationCard extends StatefulWidget {
  final String token ;
  final int index;
  final model ;
  final GestureTapCallback onTap;
  final GestureTapCallback click;
  final GestureTapCallback route;



  const NotificationCard({Key key, this.token, this.model, this.onTap, this.click, this.route, this.index}) : super(key: key);

  @override
  _NotificationCardState createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  // ignore: unused_field
  SharedPreferences _preferences ;
  _getShared() async{
    _preferences = await SharedPreferences.getInstance();
  }


  
  @override
  void initState() {
    _getShared();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {


          return InkWell(
            onTap: widget.click,
            child: Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: Slidable(
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: 0.25,
                child: InkWell(
                  onTap: widget.route,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.all(Radius.circular(5))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("${Provider.of<NotoficationProvider>(context,listen: false).notfications[widget.index].createdAt.day}/${Provider.of<NotoficationProvider>(context,listen: false).notfications[widget.index].createdAt.month}/${Provider.of<NotoficationProvider>(context,listen: false).notfications[widget.index].createdAt.year}",
                                    style: TextStyle(fontSize: 13, color: Colors.black)),
                                Padding(
                                  padding: const EdgeInsets.only(right:8.0),
                                  child: Text(Provider.of<NotoficationProvider>(context,listen: false).notfications[widget.index].arTitle,
                                      style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold, color: Colors.black)),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Text(
                                Provider.of<NotoficationProvider>(context,listen: false).notfications[widget.index].arMessage,
                                textAlign: TextAlign.right,
                                style: TextStyle(fontSize: 13)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                actions: <Widget>[
                  InkWell(
                    onTap: widget.onTap,
                    child: Material(
                      shape: CircleBorder(),
                      color: Colors.redAccent,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Icon(Icons.delete, color: Colors.white),
                      ),
                    ),
                  )
//                    BlocListener<DeleteNotificationBloC , AppState>(
//                      listener: (_, state){
//                        if(state is Done){
//                          DeleteNotificationModel _model = state.model ;
////                          if(_model.code != 200){
////                            customProgressDialog.hidePr();
////                            dialog.showErrorDialog(
////                                context: context,
////                                btnOnPress: () {},
////                                msg: _model.error);
////                          }else{
////                            customProgressDialog.hidePr();
////                            dialog.showSuccessDialog(
////                                context: context,
////                                btnOnPress: () {},
////                                msg: _model.data.value);
////                          }
////
////                        }else if (state is Loading){
////                       //   customProgressDialog.showPr();
//                        }
//
//                      },
//                      bloc: deleteNotificationBloC,
//                      child: BlocBuilder(
//                        bloc: deleteNotificationBloC,
//                        builder: (_,state){
//                          return InkWell(
//                            onTap: widget.onTap,
//                            child: Material(
//                              shape: CircleBorder(),
//                              color: Colors.redAccent,
//                              child: Padding(
//                                padding: const EdgeInsets.all(15),
//                                child: Icon(Icons.delete, color: Colors.white),
//                              ),
//                            ),
//                          ) ;
//                        },
//                      ),
//                    )
                ],
              ),


      ),
    );
  }
}