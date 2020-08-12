import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextContainer{
  Widget customText({BuildContext context ,Function onTap, String text , state = false}){
    return  InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width ,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            border: Border.all(color: Colors.grey)
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Visibility(
                visible: state ?? true,
                  child: Icon(Icons.arrow_drop_down)),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(text , textAlign : TextAlign.right,style: TextStyle(fontSize: 15),),
                ),
              )
            ],
          ),
        ),
      ),
    );

  }
}