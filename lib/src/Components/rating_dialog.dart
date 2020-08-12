import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:truckle_drivers/src/provider/get/compeletOrdersProvider.dart';
import 'package:truckle_drivers/src/provider/post/rateProvider.dart';


class RatingDialog extends StatefulWidget {
  final String id;
  final String token;
  final String lable;
  final int type;
  final int index;

  const RatingDialog({Key key, this.id, this.token, this.lable, this.type, this.index})
      : super(key: key);
  @override
  _RatingDialogState createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double rating = 1.0;
    Widget payNow = InkWell(
      onTap: () {
        print(rating.toInt());

        Navigator.of(context).pop();
        // if(widget.type == 1){
        // Provider.of<RateProductProvider>(context, listen: false)
        //     .ratePlace(widget.token, widget.id, rating.toInt(), context);
        // }else{
          Provider.of<RateProvider>(context, listen: false)
            .rate(rating.toInt(),widget.token, widget.id,  context);
            //  Provider.of<CompeletOrderProvider>(context,listen: false).compeletedOrders[widget.index].rateState = true;
        // }
        
      },
      child: Container(
        height: 60,
        width: width / 1.5,
        decoration: BoxDecoration(
            // gradient: mainButton,
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).primaryColor,
                offset: Offset(0, 5),
                blurRadius: 10.0,
              )
            ], borderRadius: BorderRadius.circular(9.0)),
        child: Center(
          child: Text("تقييم",
              style: const TextStyle(
                  color: const Color(0xfffefefe),
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  fontSize: 20.0)),
        ),
      ),
    );

    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.grey[50]),
          padding: EdgeInsets.all(24.0),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Text(
              "شكرا علي تقييمك",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: RichText(
                text: TextSpan(
                    style:
                        TextStyle(fontFamily: 'Montserrat', color: Colors.grey),
                    children: [
                      TextSpan(
                        text: "تقييم",
                      ),
                      TextSpan(
                        text: "   ",
                      ),
                      TextSpan(
                          text: widget.lable,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[600]))
                    ]),
              ),
            ),
            FlutterRatingBar(
              itemSize: 32,
              allowHalfRating: false,
              initialRating: 1,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              fullRatingWidget: Icon(Icons.star,
                  color: Theme.of(context).primaryColor, size: 32),
              noRatingWidget: Icon(Icons.star_border,
                  color: Theme.of(context).primaryColor, size: 32),
              onRatingUpdate: (value) {
                rating = value;

                print(value);
              },
            ),
            // Container(
            //     margin: EdgeInsets.symmetric(vertical: 16.0),
            //     padding: EdgeInsets.all(16.0),
            //     decoration: BoxDecoration(
            //         color: Colors.grey[200],
            //         borderRadius: BorderRadius.all(Radius.circular(5))),
            //     child: TextField(
            //       controller: TextEditingController(),
            //       decoration: InputDecoration(
            //           border: InputBorder.none,
            //           contentPadding: EdgeInsets.zero,
            //           hintText: 'Say something about the product.'),
            //       style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            //       maxLength: 200,
            //     )),
            SizedBox(
              height: 20,
            ),
            payNow
          ])),
    );
  }
}
