import 'package:flutter/material.dart';

import '../countrySelect.dart';

class SelectCard extends StatefulWidget {
  final List<CategoryModel> list;

  const SelectCard({Key key, this.list}) : super(key: key);

  @override
  _SelectCardState createState() => _SelectCardState();
}

class _SelectCardState extends State<SelectCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: ListView.builder(
        itemCount: widget.list.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: InkWell(
              onTap: () async {
                setState(() {
                  for (int i = 0; i < widget.list.length; i++) {
                    setState(() {
                      widget.list[i].selected = false;
                    });
                  }
                  setState(() {
                    widget.list[index].selected = !widget.list[index].selected;
                  });
                });
                print(widget.list[index].label);
                if (widget.list[index].id == 1) {
                  // // setState(() {
                  // //   Provider.of<ChoseLangeProvider>(context).changeLang("ar");
                  // //   print(Provider.of<ChoseLangeProvider>(context).selectLang);
                  // });
                } else {
                  // setState(() {
                  //   Provider.of<ChoseLangeProvider>(context).changeLang("en");
                  //   print(Provider.of<ChoseLangeProvider>(context).selectLang);
                  // });

                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  widget.list[index].selected
                      ? Icon(Icons.check, color: Colors.black)
                      : Container(),
                  Row(
                    children: <Widget>[
                      Text(widget.list[index].label,
                          style: TextStyle(fontSize: 20)),
                      SizedBox(width: 10),
                      CircleAvatar(
                          backgroundImage: AssetImage(widget.list[index].image),
                          radius: 30),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
