import 'package:flutter/material.dart';
class CustomBottomSheet extends StatelessWidget {
  final text ;
  final width ;
  final list ;

  const CustomBottomSheet({Key key, this.text, this.width, this.list}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode());
        showModalBottomSheet(
            backgroundColor: Colors.black12,
            context: context, builder: (_){
          return Container(
            height:  350 ,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(10.0),
                  topRight: const Radius.circular(10.0),
                ),
                color: Colors.white
            ),
            child: list,
          ) ;
        });
      },
      child: Container(
        width: width,
        height: 50,
        decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1 , color: Colors.grey)
            )
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Icon(Icons.edit , color: Theme.of(context).primaryColor,),
              Expanded(child: Text(text , style: TextStyle(fontSize: 15),textAlign: TextAlign.end,))
            ],
          ),
        ),
      ),
    );
  }
}
