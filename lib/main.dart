import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'TishApp/screen/TishAppMainPage.dart';
import 'TishApp/screen/TishAppLogin.dart';
import 'TishApp/screen/TishAppSignUp.dart';
import 'TishApp/screen/TishAppWelcomePage.dart';
import 'TishApp/utils/TishAppColors.dart';
import 'TishApp/viewmodel/authProvider.dart';
import 'TishApp/viewmodel/PlaceProvider.dart';

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
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider<PlaceProvider>(
          create: (_) => PlaceProvider(),
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
