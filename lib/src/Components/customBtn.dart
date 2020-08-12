import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomBtn extends StatefulWidget {
  final String text;
  final Function onTap;
  final Color color;
  final Color txtColor;
  final Widget icon;
  final double hegh;
  final double wedth;

  const CustomBtn(
      {Key key,
      @required this.text,
      @required this.onTap,
      @required this.color,
      this.txtColor, this.icon, this.hegh, this.wedth})
      : super(key: key);

  @override
  _CustomBtnState createState() => _CustomBtnState();
}

class _CustomBtnState extends State<CustomBtn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.hegh == null ?50:widget.hegh,
      width: widget.wedth == null ?null : widget.wedth,
      child: MaterialButton(
        onPressed: widget.onTap,
        color: widget.color,
        elevation: 0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Center(
          child: Row(
            mainAxisAlignment: 
             widget.icon == null ?
            MainAxisAlignment.center :MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                widget.text,
                textAlign: TextAlign.center,
                style: TextStyle(color: widget.txtColor),
              ),
              widget.icon == null ? Text("") : widget.icon
            ],
          ),
        ),
      ),
    );
  }
}
