
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class CustomOptionCard{
  Widget optionCard({String label, final icon, Function onTap}) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 30,
          decoration: BoxDecoration(
              color: Colors.grey[350],
              borderRadius: BorderRadius.all(Radius.circular(5))
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right : 8.0),
                  child: Text(
                    label,
                    textAlign: TextAlign.end,
                    style: TextStyle( color: Colors.black87,fontSize: 17),
                  ),
                ),
              ),
              Visibility(
                visible: icon != null,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(5))
                  ),
                  child: Image.asset(icon),
                ),
              ),
            ],
          ),

        ),
      ),
    );
  }

}