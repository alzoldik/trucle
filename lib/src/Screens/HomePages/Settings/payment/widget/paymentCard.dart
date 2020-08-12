import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../bankPay.dart';

class MyPayments extends StatefulWidget {
  final isOrder;

  const MyPayments({Key key, this.isOrder}) : super(key: key);

  @override
  _MyPaymentsState createState() => _MyPaymentsState();
}

class _MyPaymentsState extends State<MyPayments> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.isOrder) {
         // showBob();
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => BankingPay()));
        }
      },
      child: Padding(
        padding: widget.isOrder ? EdgeInsets.all(8.0) : EdgeInsets.all(0.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: widget.isOrder
                  ? MediaQuery.of(context).size.width - 20
                  : MediaQuery.of(context).size.width - 100,
              height: MediaQuery.of(context).size.height/5,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width / 3,
                 //   color: Colors.grey[200],
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                         color: Colors.grey[200],
                    //    borderRadius: BorderRadius.all(Radius.circular(5))
                        ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("السعر"),
                        Text("125"),
                        Text("ريال سعودي"),
                        Divider(
                          height: 2,
                          color:  Colors.grey,
                        ),
                        Text("العملة المستحقة"),
                        Text("5"),
                        Text("ريال سعودي"),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              "احمد عبدالرحمن علي",
                              style: TextStyle(fontSize: 18),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 0, left: 20),
                              child: CircleAvatar(
                                backgroundColor: Theme.of(context).primaryColor,
                                radius: 5,
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Text("454545: رقم"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            FlutterRatingBar(
                              itemCount: 5,
                              itemSize: 20,
                              allowHalfRating: false,
                              initialRating: 3,
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 0.0),
                              fullRatingWidget: Icon(Icons.star,
                                  color: Colors.amber, size: 20),
                              noRatingWidget: Icon(Icons.star_border,
                                  color: Colors.amber, size: 20),
                              onRatingUpdate: null,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text("مدينة الانزال :   الرياض"),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.location_on,
                                  size: 15,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text("مدينة الاقلاع :   جدة"),
                                Icon(
                                  Icons.location_on,
                                  size: 15,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: <Widget>[
                      //     Padding(
                      //       padding: const EdgeInsets.all(8.0),
                      //       child: Container(
                      //         width: 80,
                      //         decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.circular(10),
                      //             color: Theme.of(context).primaryColor),
                      //         child: Center(
                      //           child: Padding(
                      //             padding: const EdgeInsets.all(8.0),
                      //             child: Text(
                      //               "تفاصيل",
                      //               style: TextStyle(
                      //                   color: Colors.white, fontSize: 10),
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //     Padding(
                      //       padding: const EdgeInsets.only(right: 8.0),
                      //       child: Row(
                      //         children: <Widget>[
                      //           Text("9/6/2020  : تاريخ الاقلاع"),
                      //           Icon(
                      //             Icons.date_range,
                      //             size: 20,
                      //           )
                      //         ],
                      //       ),
                      //     ),
                      //   ],
                      // )
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Container(
                      //     height: MediaQuery.of(context).size.height * .17,
                      //     child: Padding(
                      //       padding: const EdgeInsets.only(right: 8.0),
                      //       child: Column(
                      //         children: <Widget>[
                      //           Row(
                      //             mainAxisAlignment: MainAxisAlignment.end,
                      //             children: <Widget>[
                      //               Text(":"),
                      //               Text("التفاصيل "),
                      //             ],
                      //           ),
                      //           SizedBox(
                      //             height: 3,
                      //           ),
                      //           Text(
                      //             "محتوى تجريب للتفاصيل محتوى تجريب للتفاصيل محتوى تجريب للتفاصيل محتوى تجريب للتفاصيل محتوى تجريب للتفاصيل محتوى تجريب للتفاصيل محتوى تجريب للتفاصيل محتوى تجريب للتفاصيل محتوى تجريب للتفاصيل محتوى تجريب للتفاصيل محتوى تجريب للتفاصيل محتوى تجريب للتفاصيل محتوى تجريب للتفاصيل محتوى تجريب للتفاصيل "
                      //             "محتوى تجريب للتفاصيل محتوى تجريب للتفاصيل محتوى تجريب للتفاصيل محتوى تجريب للتفاصيل "
                      //             "محتوى تجريب للتفاصيل محتوى تجريب للتفاصيل محتوى تجريب للتفاصيل "
                      //             "محتوى تجريب للتفاصيل  ",
                      //             overflow: TextOverflow.ellipsis,
                      //             maxLines: 5,
                      //             textAlign: TextAlign.end,
                      //           )
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
    showBob(){
       showDialog(
            context: context,
            builder: (context) {
              return SimpleDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                elevation: 3,
                backgroundColor: Colors.white,
                contentPadding: EdgeInsets.all(15),
                children: <Widget>[
                  Container(
                    height: 50,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                       "125",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BankingPay(
                                    // packageId: packageId,
                                    // price: checkDiscountModel.data.price == null
                                    //     ? price
                                    //     : checkDiscountModel.data.price,
                                    // token: token,
                                    // desountCode: code,
                                    // sellerCode: sellerCode,
                                  )));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(' الاشتراك بالحساب البنكي'),
                        SizedBox(width: 10),
                        Icon(FontAwesomeIcons.moneyBill),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Divider(height: 1, color: Colors.grey),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => OnlinePay(
                      //               token: token,
                      //               packageId: packageId,
                      //               price: checkDiscountModel.data.price == null
                      //                   ? price
                      //                   : checkDiscountModel.data.price,
                      //               packageName: packageName,
                      //               packageUserName: userName,
                      //             )));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text('الاشتراك عن ظريق الفيزا'),
                        SizedBox(width: 10),
                        Icon(FontAwesomeIcons.ccVisa),
                      ],
                    ),
                  ),
                ],
              );
            });
    }
}
