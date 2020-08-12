import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truckle_drivers/src/provider/helpCenter.dart';
import 'Screens/Intro/splash_screen.dart';
import 'provider/aboutUsProvider.dart';
import 'provider/auth/confirmResetCodeProvider.dart';
import 'provider/auth/forgetPasswordProvider.dart';
import 'provider/auth/loginProvider.dart';
import 'provider/auth/phoneVerificationProvider.dart';
import 'provider/auth/registerMobileProvider.dart';
import 'provider/auth/resetPasswordProvider.dart';
import 'provider/auth/signUpProvider.dart';
import 'provider/categoriesProvider.dart';
import 'provider/changeData/changePasswordProvider.dart';
import 'provider/changeData/changePhoneCodeProvider.dart';
import 'provider/changeData/changePhoneProvider.dart';
import 'provider/changeData/editAcountProvider.dart';
import 'provider/countriesProvider.dart';
import 'provider/get/activeOrderProvider.dart';
import 'provider/get/citiesProvider.dart';
import 'provider/get/compeletOrdersProvider.dart';
import 'provider/get/getUserDataProvider.dart';
import 'provider/get/newOrdersProvider.dart';
import 'provider/get/newPaymentProvider.dart';
import 'provider/get/notificationProvider.dart';
import 'provider/get/paidPaymentProvider.dart';
import 'provider/get/pinOrdersProvider.dart';
import 'provider/get/rejectOrdersProvider.dart';
import 'provider/post/acceptedProvider.dart';
import 'provider/post/acctivetedOrderProvider.dart';
import 'provider/post/completedProvider.dart';
import 'provider/post/deleteNotificationProvider.dart';
import 'provider/post/rateProvider.dart';
import 'provider/post/subscribeProvider.dart';
import 'provider/termsProvider.dart';
import 'provider/truclesprovider.dart';

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigator;

  const MyApp({Key key, this.navigator}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: LoginProvider()),
        ChangeNotifierProvider.value(value: RegisterMobileProvider()),
        ChangeNotifierProvider.value(value: PhoneVerificationProvider()),
        ChangeNotifierProvider.value(value: SignUpProvider()),
        ChangeNotifierProvider.value(value: ForgetPasswordProvider()),
        ChangeNotifierProvider.value(value: ConfirmResetCodeProvider()),
        ChangeNotifierProvider.value(value: ResetPasswordProvider()),
        ChangeNotifierProvider.value(value: AboutUsProvider()),
        ChangeNotifierProvider.value(value: TermsProvider()),
        ChangeNotifierProvider.value(value: HelpCenterProvider()),
        ChangeNotifierProvider.value(value: CountriesProvider()),
        ChangeNotifierProvider.value(value: CategoriesProvider()),
        ChangeNotifierProvider.value(value: TruclesProvider()),

        
        ChangeNotifierProvider.value(value: ChangePasswordProvider()),
        ChangeNotifierProvider.value(value: EditUserDataProvider()),
        ChangeNotifierProvider.value(value: ChangeMobileProvider()),
        ChangeNotifierProvider.value(value: ChangePhoneCodeProvider()),

        ChangeNotifierProvider.value(value: NewsOrdersProvider()),
        ChangeNotifierProvider.value(value: ActiveOrderProvider()),
        ChangeNotifierProvider.value(value: CompeletOrderProvider()),
        ChangeNotifierProvider.value(value: RejectedOrderProvider()),
        ChangeNotifierProvider.value(value: RateProvider()),
        ChangeNotifierProvider.value(value: NotoficationProvider()),
        ChangeNotifierProvider.value(value: DeletNotificationProvider()),
        ChangeNotifierProvider.value(value: PinOrderOrderProvider()),

        
        ChangeNotifierProvider.value(value: AcceptedProvider()),
        ChangeNotifierProvider.value(value: AcctivatedOrderProvider()),
        ChangeNotifierProvider.value(value: SubscribeProvider()),
        ChangeNotifierProvider.value(value: GetUserDataProvider()),
        ChangeNotifierProvider.value(value: CompletedProvider()),
        ChangeNotifierProvider.value(value: CitiesProvider()),
        ChangeNotifierProvider.value(value: PaidPaymentProvider()),
        ChangeNotifierProvider.value(value: NewPaymentProvider()),











        // ChangeNotifierProvider.value(value: CancelOrderProvider()),
      ],
      child: MaterialApp(
        navigatorKey: navigator,
        debugShowCheckedModeBanner: false,
        title: "Truckle",
        theme: ThemeData(
            primaryColor: Color.fromRGBO(19, 19, 19, 1.0),
            accentColor: Color.fromRGBO(108, 108, 108, 1.0),
            fontFamily: "cairo"),
        home: Splash(
          navigator: navigator,
        ),
      ),
    );
  }
}
