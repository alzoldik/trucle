import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  const Badge({
    Key key,
    @required this.child,
    @required this.value,
    this.color,
    this.right,
    this.top,
  }) : super(key: key);

  final Widget child;
  final String value;
  final Color color;
  final right;

  final top;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        Positioned(
          right: right != null ? right : -1,
          top: top != null ? top : 0,
          child: Container(
            padding: EdgeInsets.all(2.0),
            // color: Theme.of(context).accentColor,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color != null ? color : Theme.of(context).accentColor,
            ),
            constraints: BoxConstraints(
              minWidth: 16,
              minHeight: 16,
            ),
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10, color: Colors.white),
            ),
          ),
        )
      ],
    );
  }
}
