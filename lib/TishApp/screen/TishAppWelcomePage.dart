import 'dart:async';

import 'package:TishApp/TishApp/screen/DeepPage.dart';
import 'package:TishApp/TishApp/utils/TishAppColors.dart';
import 'package:TishApp/TishApp/utils/TishAppImages.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:uni_links/uni_links.dart';

import 'TishAppLogin.dart';
import 'TishAppSignUp.dart';

bool _initialURILinkHandled = false;

class WelcomePage extends StatefulWidget {
  WelcomePage();

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  Uri? _initialURI;
  Uri? _currentURI;
  Object? _err;

  StreamSubscription? _streamSubscription;

  void _incomingLinkHandler() {
 // 1
 if (!kIsWeb) {
   // 2
   _streamSubscription = uriLinkStream.listen((Uri? uri) {
     if (!mounted) {
       return;
     }
     debugPrint('Received URI: $uri');
     debugPrint('${uri!.pathSegments[0]}');
     setState(() {
       _currentURI = uri;
       _err = null;
     });
     if(uri.pathSegments.length > 0){
      if(uri.pathSegments[0] == 'Place'){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
      Navigator.push(context, MaterialPageRoute(builder: ((context) => DeepPage(Place_ID: (uri.pathSegments[1]).toInt(),))));
     }
     }
     // 3
   }, onError: (Object err) {
     if (!mounted) {
       return;
     }
     debugPrint('Error occurred: $err');
     setState(() {
       _currentURI = null;
       if (err is FormatException) {
         _err = err;
       } else {
         _err = null;
       }
     });
   });
 }
}

  Future<void> _initURIHandler() async {
 // 1
 if (!_initialURILinkHandled) {
   _initialURILinkHandled = true;
   // 2
   try {
     // 3
     final initialURI = await getInitialUri();
     // 4
     if (initialURI != null) {
       debugPrint("Initial URI received $initialURI");
            if(initialURI.pathSegments.length > 0){
      if(initialURI.pathSegments[0] == 'Place'){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
      Navigator.push(context, MaterialPageRoute(builder: ((context) => DeepPage(Place_ID: (initialURI.pathSegments[1]).toInt(),))));
     }
     }
       if (!mounted) {
         return;
       }
       setState(() {
         _initialURI = initialURI;
       });
     } else {
       debugPrint("Null Initial URI received");
     }
   } on PlatformException { // 5
     debugPrint("Failed to receive initial uri");
   } on FormatException catch (err) { // 6
     if (!mounted) {
       return;
     }
     debugPrint('Malformed Initial URI received');
     setState(() => _err = err);
   }
 }
}

@override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }

@override
  void initState() {
    super.initState();
    _initURIHandler();
    _incomingLinkHandler();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(color: mainColorTheme),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white),
                  ),
                )
              ],
            ),
            Center(
              child: Image.asset(TishApp_WelcomePageImage),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Enjoy the beautiful world !",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                          color: mainColorTheme,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.6),
                                blurRadius: 10,
                                offset: Offset(0, 4))
                          ]),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Get started",
                            style: TextStyle(color: Colors.white),
                          ),
                          Transform.rotate(
                              angle: -3.2,
                              child: Icon(
                                Icons.arrow_circle_left_outlined,
                                color: Colors.white,
                              ))
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 70),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
