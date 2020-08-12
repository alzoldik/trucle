import 'package:flutter/material.dart';
import 'package:truckle_drivers/src/Components/customBtn.dart';
import 'package:truckle_drivers/src/Screens/Registeration/sign_in_screen.dart';


import 'Widgets/selectCard.dart';

class CountrySelect extends StatefulWidget {
  static bool selectLang = false;
  @override
  _CountrySelectState createState() => _CountrySelectState();
}

class _CountrySelectState extends State<CountrySelect> {
  // ignore: unused_field
  List<CategoryModel> _countries = [];
  List<CategoryModel> _lang = [];

  @override
  void initState() {
    super.initState();
    // _countries.add(new CategoryModel(
    //     id: 1, label: 'مصر', image: 'assets/images/eg.png', selected: false));
    // _countries.add(new CategoryModel(
    //     id: 2, label: 'السعودية', image: 'assets/images/SA.png', selected: false));

    _lang.add(new CategoryModel(
        id: 1, label: 'العربية', image: 'assets/images/eg.png', selected: false));
    _lang.add(new CategoryModel(
      id: 2,
      label: 'English',
      selected: false,
      image: 'assets/images/en.jpg',
    ));
     _lang.add(new CategoryModel(
      id: 3,
      label: 'हिन्दी',
      selected: false,
      image: 'assets/images/india.jpg',
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            'assets/images/bg.jpg',
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: <Widget>[
                SizedBox(height: 50),
                Image.asset('assets/images/newLoga.png', height: 100),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text('إختر اللغة',
                      textAlign: TextAlign.right,
                      style: TextStyle(color: Theme.of(context).primaryColor)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200],
                    ),
                    child: SelectCard(
                      list: _lang,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(30),
                  child: CustomBtn(
                    color: Theme.of(context).primaryColor,
                    txtColor: Colors.white,
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => SignInScreen()));
                    },
                    // onTap: Provider.of<ChoseLangeProvider>(context)
                    //             .selectLang ==
                    //         true
                    //     ? () async {
                    //         SharedPreferences _prefs =
                    //             await SharedPreferences.getInstance();

                    //         await localization.setNewLanguage(
                    //             Provider.of<ChoseLangeProvider>(context).lang,
                    //             true);
                    //         Navigator.push(
                    //             context,
                    //             MaterialPageRoute(
                    //                 builder: (context) => MainPage()));
                    //                 _prefs.setBool("firstLog", true);
                    //         setState(() {
                    //           Provider.of<ChoseLangeProvider>(context)
                    //               .selectLang = false;
                    //         });
                    //       }
                    //     : null,
                    text: 'متابعة',
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryModel {
  int id;
  String label;
  bool selected;
  String image;

  CategoryModel({this.id, this.label, this.selected, this.image});
}
