import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart' as date;
import 'package:provider/provider.dart';
import 'package:truckle_drivers/src/Components/customBtn.dart';
import 'package:truckle_drivers/src/Components/customDialog.dart';
import 'package:truckle_drivers/src/Components/rating_dialog.dart';
import 'package:truckle_drivers/src/Components/registerTextField.dart';
import 'package:truckle_drivers/src/Repository/appLocalization.dart';
import 'package:truckle_drivers/src/provider/get/activeOrderProvider.dart';
import 'package:truckle_drivers/src/provider/get/compeletOrdersProvider.dart';
import 'package:truckle_drivers/src/provider/get/newOrdersProvider.dart';
import 'package:truckle_drivers/src/provider/get/pinOrdersProvider.dart';
import 'package:truckle_drivers/src/provider/get/rejectOrdersProvider.dart';
import 'package:truckle_drivers/src/provider/post/acceptedProvider.dart';
import 'package:truckle_drivers/src/provider/post/acctivetedOrderProvider.dart';
import 'package:truckle_drivers/src/provider/post/completedProvider.dart';

class Details extends StatelessWidget {
  final isOrder;
  final int orderState;
  final int index;
  final bool pin;
  final String token;

  const Details(
      {Key key,
      this.isOrder,
      this.orderState,
      this.index,
      this.pin,
      this.token})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // if (orderState == 3) {
        //   Navigator.of(context)
        //       .push(MaterialPageRoute(builder: (_) => OrderDetailsScreen()));
        // }
      },
      child: Padding(
        padding: isOrder ? EdgeInsets.all(8.0) : EdgeInsets.all(0.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: isOrder
                  ? MediaQuery.of(context).size.width - 20
                  : MediaQuery.of(context).size.width - 100,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Visibility(
                                visible: orderState == 0,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    height: 40,
                                    child: CustomBtn(
                                      text: "تفاصيل الالغاء",
                                      onTap: () {
                                        CustomDialog().show(
                                            context: context,
                                            onClick: () =>
                                                Navigator.pop(context),
                                            btnMsg: 'موافق',
                                            msg: Provider.of<
                                                        RejectedOrderProvider>(
                                                    context,
                                                    listen: false)
                                                .rejectiesOrders[index]
                                                .notes);
                                      },
                                      color: Theme.of(context).primaryColor,
                                      txtColor: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: orderState == 1 &&
                                    Provider.of<CompeletOrderProvider>(context)
                                            .compeletedOrders[index]
                                            .rateState == false,
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 3,
                                  height: 40,
                                  child: CustomBtn(
                                    text: "تقييم",
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          child: Dialog(
                                            shape: BeveledRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            child: RatingDialog(
                                              lable: Provider.of<
                                                          CompeletOrderProvider>(
                                                      context,
                                                      listen: false)
                                                  .compeletedOrders[index]
                                                  .driver,
                                              id: Provider.of<
                                                          CompeletOrderProvider>(
                                                      context,
                                                      listen: false)
                                                  .compeletedOrders[index]
                                                  .id
                                                  .toString(),
                                              token: token,
                                              index: index,
                                            ),
                                          ));
                                    },
                                    color: Theme.of(context).primaryColor,
                                    txtColor: Colors.white,
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: pin == true,
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 3,
                                  height: 40,
                                  child: CustomBtn(
                                    text: "تقديم عرض",
                                    onTap: () {
                                      // _showDialog("تاكيد الغاء الطلب", context);
                                      _showAnimateDialog(
                                          Provider.of<PinOrderOrderProvider>(
                                                  context,
                                                  listen: false)
                                              .pinedOrders[index]
                                              .id
                                              .toString(),
                                          context);
                                    },
                                    color: Theme.of(context).primaryColor,
                                    txtColor: Colors.white,
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: orderState == 3 && pin != true,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    height: 40,
                                    child: CustomBtn(
                                      text: "بداية الرحلة",
                                      onTap: () {
                                        Provider.of<AcctivatedOrderProvider>(
                                                context,
                                                listen: false)
                                            .activete(
                                                token,
                                                Provider.of<NewsOrdersProvider>(
                                                        context,
                                                        listen: false)
                                                    .newOrders[index]
                                                    .id
                                                    .toString(),
                                                context);
                                      },
                                      color: Theme.of(context).primaryColor,
                                      txtColor: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: orderState == 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    height: 40,
                                    child: CustomBtn(
                                      text: "انتهاء الرحلة",
                                      onTap: () {
                                        Provider.of<CompletedProvider>(context,
                                                listen: false)
                                            .completed(
                                                token,
                                                Provider.of<ActiveOrderProvider>(
                                                        context,
                                                        listen: false)
                                                    .activitedOrders[index]
                                                    .id
                                                    .toString(),
                                                context);
                                        // Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (_) => MapScreen()));
                                      },
                                      color: Theme.of(context).primaryColor,
                                      txtColor: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Text(
                                          orderState == 2
                                              ? Provider.of<
                                                          ActiveOrderProvider>(
                                                      context,
                                                      listen: false)
                                                  .activitedOrders[index]
                                                  .driver
                                              : orderState == 1
                                                  ? Provider.of<
                                                              CompeletOrderProvider>(
                                                          context,
                                                          listen: false)
                                                      .compeletedOrders[index]
                                                      .driver
                                                  : orderState == 0
                                                      ? Provider.of<
                                                                  RejectedOrderProvider>(
                                                              context,
                                                              listen: false)
                                                          .rejectiesOrders[
                                                              index]
                                                          .driver
                                                      : "محمد عبد الرحمن ",
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                    Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          FlutterRatingBar(
                                            itemCount: 5,
                                            itemSize: 20,
                                            allowHalfRating: false,
                                            initialRating: pin == true
                                                ? Provider.of<PinOrderOrderProvider>(context, listen: false)
                                                            .pinedOrders[index]
                                                            .rate ==
                                                        null
                                                    ? 0
                                                    : Provider.of<PinOrderOrderProvider>(context,
                                                            listen: false)
                                                        .pinedOrders[index]
                                                        .rate
                                                        .toDouble()
                                                : orderState == 2
                                                    ? Provider.of<ActiveOrderProvider>(context, listen: false).activitedOrders[index].rate == null
                                                        ? 0
                                                        : Provider.of<ActiveOrderProvider>(context,
                                                                listen: false)
                                                            .activitedOrders[
                                                                index]
                                                            .rate
                                                            .toDouble()
                                                    : orderState == 1
                                                        ? Provider.of<CompeletOrderProvider>(context, listen: false).compeletedOrders[index].rate == null
                                                            ? 0
                                                            : Provider.of<CompeletOrderProvider>(context, listen: false)
                                                                .compeletedOrders[index]
                                                                .rate
                                                                .toDouble()
                                                        : orderState == 0 ? Provider.of<RejectedOrderProvider>(context, listen: false).rejectiesOrders[index].rate == null ? 0 : Provider.of<RejectedOrderProvider>(context, listen: false).rejectiesOrders[index].rate.toDouble() : 3,
                                            itemPadding: EdgeInsets.symmetric(
                                                horizontal: 0.0),
                                            fullRatingWidget: Icon(Icons.star,
                                                color: Colors.amber, size: 20),
                                            noRatingWidget: Icon(
                                                Icons.star_border,
                                                color: Colors.amber,
                                                size: 20),
                                            onRatingUpdate: null,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                CircleAvatar(
                                  backgroundImage: Image.network(pin == true
                                          ? Provider.of<PinOrderOrderProvider>(context, listen: false)
                                              .pinedOrders[index]
                                              .photo
                                          : orderState == 2
                                              ? Provider.of<ActiveOrderProvider>(context, listen: false)
                                                  .activitedOrders[index]
                                                  .photo
                                              : orderState == 1
                                                  ? Provider.of<CompeletOrderProvider>(
                                                          context,
                                                          listen: false)
                                                      .compeletedOrders[index]
                                                      .photo
                                                  : orderState == 0
                                                      ? Provider.of<RejectedOrderProvider>(
                                                              context,
                                                              listen: false)
                                                          .rejectiesOrders[
                                                              index]
                                                          .photo
                                                      : orderState == 3
                                                          ? Provider.of<NewsOrdersProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .newOrders[index]
                                                              .photo
                                                          : "https://www.wizzogames.com/win_ar/img/winners_avatar/1505228854TPwz38SvVI")
                                      .image,
                                  radius: 25,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  pin == true
                                      ? "مدينة الانزال :   ${Provider.of<PinOrderOrderProvider>(context, listen: false).pinedOrders[index].arrivalAddress}"
                                      : orderState == 3
                                          ? "مدينة الانزال :   ${Provider.of<NewsOrdersProvider>(context, listen: false).newOrders[index].arrivalAddress}"
                                          : orderState == 2
                                              ? "مدينة الانزال :   ${Provider.of<ActiveOrderProvider>(context, listen: false).activitedOrders[index].arrivalAddress}"
                                              : orderState == 1
                                                  ? "مدينة الانزال :   ${Provider.of<CompeletOrderProvider>(context, listen: false).compeletedOrders[index].arrivalAddress}"
                                                  : orderState == 0
                                                      ? "مدينة الانزال :   ${Provider.of<RejectedOrderProvider>(context, listen: false).rejectiesOrders[index].arrivalAddress}"
                                                      : "",
                                  style: TextStyle(fontSize: 12),
                                ),
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
                              children: <Widget>[
                                Text(
                                  pin == true
                                      ? "تاريخ الانزال : ${date.DateFormat('dd/MM/yyyy').format(Provider.of<PinOrderOrderProvider>(context, listen: false).pinedOrders[index].arrivalDate)}"
                                      : orderState == 3
                                          ? "تاريخ الانزال :  ${date.DateFormat('dd/MM/yyyy').format(Provider.of<NewsOrdersProvider>(context, listen: false).newOrders[index].arrivalDate)}"
                                          : orderState == 2
                                              ? "تاريخ الانزال: ${date.DateFormat('dd/MM/yyyy').format(Provider.of<ActiveOrderProvider>(context, listen: false).activitedOrders[index].arrivalDate)}"
                                              : orderState == 1
                                                  ? "تاريخ الانزال :  ${date.DateFormat('dd/MM/yyyy').format(Provider.of<CompeletOrderProvider>(context, listen: false).compeletedOrders[index].arrivalDate)}"
                                                  : orderState == 0
                                                      ? "تاريخ الانزال:   ${date.DateFormat('dd/MM/yyyy').format(Provider.of<RejectedOrderProvider>(context, listen: false).rejectiesOrders[index].arrivalDate)} "
                                                      : "",
                                  // "9/6/2020  : تاريخ الانزال",
                                  style: TextStyle(fontSize: 12),
                                ),
                                Icon(
                                  Icons.date_range,
                                  size: 15,
                                )
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  pin == true
                                      ? "مدينة الاقلاع :   ${Provider.of<PinOrderOrderProvider>(context, listen: false).pinedOrders[index].travelAddress}"
                                      : orderState == 3
                                          ? "مدينة الاقلاع :   ${Provider.of<NewsOrdersProvider>(context, listen: false).newOrders[index].travelAddress}"
                                          : orderState == 2
                                              ? "مدينة الاقلاع :   ${Provider.of<ActiveOrderProvider>(context, listen: false).activitedOrders[index].travelAddress}"
                                              : orderState == 1
                                                  ? "مدينة الاقلاع :   ${Provider.of<CompeletOrderProvider>(context, listen: false).compeletedOrders[index].travelAddress}"
                                                  : orderState == 0
                                                      ? "مدينة الاقلاع :   ${Provider.of<RejectedOrderProvider>(context, listen: false).rejectiesOrders[index].travelAddress}"
                                                      : "",
                                  // "مدينة الاقلاع :   جدة",
                                  style: TextStyle(fontSize: 12),
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
                              children: <Widget>[
                                Text(
                                  pin == true
                                      ? "تاريخ الاقلاع :   ${date.DateFormat('dd/MM/yyyy').format(Provider.of<PinOrderOrderProvider>(context, listen: false).pinedOrders[index].travelDate)}"
                                      : orderState == 3
                                          ? "تاريخ الاقلاع :  ${date.DateFormat('dd/MM/yyyy').format(Provider.of<NewsOrdersProvider>(context, listen: false).newOrders[index].travelDate)}"
                                          : orderState == 2
                                              ? "تاريخ الاقلاع: ${date.DateFormat('dd/MM/yyyy').format(Provider.of<ActiveOrderProvider>(context, listen: false).activitedOrders[index].travelDate)}"
                                              : orderState == 1
                                                  ? "تاريخ الاقلاع :  ${date.DateFormat('dd/MM/yyyy').format(Provider.of<CompeletOrderProvider>(context, listen: false).compeletedOrders[index].travelDate)}"
                                                  : orderState == 0
                                                      ? "تاريخ الاقلاع:   ${date.DateFormat('dd/MM/yyyy').format(Provider.of<RejectedOrderProvider>(context, listen: false).rejectiesOrders[index].travelDate)} "
                                                      : "",
                                  // "9/6/2020  : تاريخ الاقلاع",
                                  style: TextStyle(fontSize: 12),
                                ),
                                Icon(
                                  Icons.date_range,
                                  size: 15,
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 2),
                  Visibility(
                    visible: orderState != 0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * .17,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text(":"),
                                  Text("التفاصيل "),
                                ],
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: Text(
                                  pin == true
                                      ? Provider.of<PinOrderOrderProvider>(
                                              context,
                                              listen: false)
                                          .pinedOrders[index]
                                          .detials
                                      : orderState == 3
                                          ? Provider.of<NewsOrdersProvider>(
                                                  context,
                                                  listen: false)
                                              .newOrders[index]
                                              .detials
                                          : orderState == 2
                                              ? Provider.of<
                                                          ActiveOrderProvider>(
                                                      context,
                                                      listen: false)
                                                  .activitedOrders[index]
                                                  .detials
                                              : orderState == 1
                                                  ? Provider.of<
                                                              CompeletOrderProvider>(
                                                          context,
                                                          listen: false)
                                                      .compeletedOrders[index]
                                                      .detials
                                                  : "محتوى تجريب للتفاصيل محتوى تجريب للتفاصيل محتوى تجريب للتفاصيل محتوى تجريب للتفاصيل محتوى تجريب للتفاصيل محتوى تجريب للتفاصيل محتوى تجريب للتفاصيل محتوى تجريب للتفاصيل محتوى تجريب للتفاصيل محتوى تجريب للتفاصيل محتوى تجريب للتفاصيل محتوى تجريب للتفاصيل محتوى تجريب للتفاصيل محتوى تجريب للتفاصيل "
                                                      "محتوى تجريب للتفاصيل محتوى تجريب للتفاصيل محتوى تجريب للتفاصيل محتوى تجريب للتفاصيل "
                                                      "محتوى تجريب للتفاصيل محتوى تجريب للتفاصيل محتوى تجريب للتفاصيل "
                                                      "محتوى تجريب للتفاصيل  ",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 5,
                                  textAlign: TextAlign.start,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _showAnimateDialog(String questionId, context) {
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Directionality(
            textDirection: localization.currentLanguage.toString() == "en"
                ? TextDirection.rtl
                : TextDirection.ltr,
            child: Transform.scale(
              scale: a1.value,
              child: Opacity(
                  opacity: a1.value,
                  child: SimpleDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    backgroundColor: Colors.white,
                    elevation: 5,
                    contentPadding: EdgeInsets.all(10),
                    children: <Widget>[
                      Text(
                        "تقديم عرض سعر",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 17),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                            height: 40,
                            width: 200,
                            child: RegisterTextField(
                              type: TextInputType.number,
                              onChange: (value) {
                                Provider.of<AcceptedProvider>(context,
                                        listen: false)
                                    .price = value;
                              },
                              hint: '',
                              label: '',
                            ),
                          ),
                          Text(
                            localization.text("price"),
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        "اضافة ملاحظة",
                        textDirection:
                            localization.currentLanguage.toString() == "en"
                                ? TextDirection.ltr
                                : TextDirection.rtl,
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: 250,
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextField(
                          textDirection:
                              localization.currentLanguage.toString() == "en"
                                  ? TextDirection.ltr
                                  : TextDirection.rtl,
                          minLines: 4,
                          maxLines: 4,
                          onChanged: (value) {
                            Provider.of<AcceptedProvider>(context,
                                    listen: false)
                                .note = value;
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                  right: 10, left: 10, top: 5, bottom: 5)),
                        ),
                      ),
                      SizedBox(height: 10),
                      CustomBtn(
                        onTap: () {
                          Provider.of<AcceptedProvider>(context, listen: false)
                              .accepted(token, questionId, context);
                        },
                        text: localization.text("send"),
                        color: Theme.of(context).primaryColor,
                        txtColor: Colors.white,
                      )
                    ],
                  )),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 300),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        // ignore: missing_return
        pageBuilder: (context, animation1, animation2) {});
  }

  // ignore: unused_element
  _showDialog(String text, BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 3,
            backgroundColor: Colors.white,
            contentPadding: EdgeInsets.all(15),
            children: <Widget>[
              Container(
                height: 50,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    text,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        print(index);
                        // Provider.of<CancelOrderProvider>(context, listen: false)
                        //     .cancelOrder("121GIZEA1cPzT", "cancel", Provider.of<NewsOrdersProvider>(context,listen: false).newOrders[0].id.toString(), context);
                      },
                      child: Container(
                          width: 50,
                          height: 30,
                          child: Center(child: Text("متاكد")))),
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                          width: 50,
                          height: 30,
                          child: Center(child: Text("الغاء"))))
                ],
              )
            ],
          );
        });
  }
}
