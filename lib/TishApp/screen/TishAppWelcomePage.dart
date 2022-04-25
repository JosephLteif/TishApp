import 'package:TishApp/TishApp/utils/TishAppColors.dart';
import 'package:TishApp/TishApp/utils/TishAppImages.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'TishAppLogin.dart';
import 'TishAppSignUp.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage();

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
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
