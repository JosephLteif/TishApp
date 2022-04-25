import 'package:TishApp/TishApp/screen/PlaceDescription2.dart';
import 'package:TishApp/TishApp/viewmodel/Place_BadgeViewModel.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'TishApp/screen/TishAppMainPage.dart';
import 'TishApp/screen/TishAppLogin.dart';
import 'TishApp/screen/TishAppSignUp.dart';
import 'TishApp/screen/TishAppWelcomePage.dart';
import 'TishApp/utils/TishAppColors.dart';
import 'TishApp/viewmodel/Place_TypeViewModel.dart';
import 'TishApp/viewmodel/authViewModel.dart';
import 'TishApp/viewmodel/PlaceViewModel.dart';

final GlobalKey<NavigatorState> navigator = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(TishApp());
}

class TishApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthViewModel>(
          create: (_) => AuthViewModel(),
        ),
        ChangeNotifierProvider<PlaceViewModel>(
          create: (_) => PlaceViewModel(),
        ),
        ChangeNotifierProvider<Place_TypeViewModel>(
          create: (_) => Place_TypeViewModel(),
        ),
        ChangeNotifierProvider<Place_BadgeViewModel>(
          create: (_) => Place_BadgeViewModel(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
            primarySwatch: mainColorTheme,
            scaffoldBackgroundColor: Colors.white),
        routes: {
          '/': (context) => WelcomePage(),
          '/login': (context) => LoginPage(),
          '/signup': (context) => SignUpPage(),
          '/dashboard': (context) => TishAppMainPage(),
        },
        title: 'TishApp',
        builder: scrollBehaviour(),
        navigatorKey: navigator,
      ),
    );
  }
}
