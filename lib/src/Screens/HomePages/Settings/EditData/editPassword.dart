import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:truckle_drivers/src/Components/buttonSignIn.dart';
import 'package:truckle_drivers/src/Components/inputTextField.dart';
import 'package:truckle_drivers/src/provider/changeData/changePasswordProvider.dart';

class EditPassword extends StatefulWidget {
  @override
  _EditPasswordState createState() => _EditPasswordState();
}

class _EditPasswordState extends State<EditPassword> {
  SharedPreferences _pref;

  _getShared() async {
    _pref = await SharedPreferences.getInstance();
    setState(() {
      _pref =_pref;
    });

  }
  @override
  void initState() {
   _getShared();
  // Provider.of<ChangePasswordProvider>(context, listen: false).context = context;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

   
    return Stack(
      children: <Widget>[
        ListView(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 10, right: 10.0),
              child: InputFieldArea(
                hint: 'كلمة المرور القديمه',
                border: false,
                show: true,
                textInputType: TextInputType.text,
                changedFunction: (v) {
                  Provider.of<ChangePasswordProvider>(context, listen: false).oldPassword = v;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 10, right: 10.0),
              child: InputFieldArea(
                changedFunction: (v) {
                  Provider.of<ChangePasswordProvider>(context, listen: false).password = v;
                },
                hint: 'كلمة المرور الجديده',
                border: false,
                show: true,
                textInputType: TextInputType.text,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 10, right: 10.0),
              child: InputFieldArea(
                changedFunction: (v) {
                  Provider.of<ChangePasswordProvider>(context, listen: false).passwordConfirmation = v;
                },
                hint: 'تاكيد كلمة المرور الجديده',
                border: false,
                show: true,
                textInputType: TextInputType.text,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            SignInButton(
              txtColor: Colors.white,
              onPressSignIn: () {
                Provider.of<ChangePasswordProvider>(context, listen: false).changePassword(_pref.get("token"),context);
              },
              btnWidth: MediaQuery.of(context).size.width - 40,
              btnHeight: MediaQuery.of(context).size.height * .07,
              btnColor: Theme.of(context).primaryColor,
              buttonText: 'تعديل',
            ),
          ],
        ),
      ],
    );
  }
}
