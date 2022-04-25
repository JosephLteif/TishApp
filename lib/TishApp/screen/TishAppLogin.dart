import 'package:TishApp/TishApp/Components/CloseBtn.dart';
import 'package:TishApp/TishApp/Components/SubmitBtn.dart';
import 'package:TishApp/TishApp/screen/TishAppDashboard.dart';
import 'package:TishApp/TishApp/screen/TishAppMainPage.dart';
import 'package:TishApp/TishApp/utils/TishAppColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:TishApp/TishApp/viewmodel/authViewModel.dart';
import 'package:provider/provider.dart';

import 'TishAppSignUp.dart';

class LoginPage extends StatefulWidget {
  LoginPage();

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.getBool('IsLoggedIn') == true
        ? Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => TishAppMainPage()),
          )
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CloseBtn(),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Welcome',
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 30),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Back',
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 30)),
              ],
            ),
            Spacer(),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: 'Email',
                hintStyle: TextStyle(color: Colors.grey),
                prefixIcon: Icon(
                  Icons.email,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Password',
                hintStyle: TextStyle(color: Colors.grey),
                prefixIcon: Icon(
                  Icons.lock,
                  color: Colors.grey,
                ),
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Sign in',
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 30)),
                SubmitBtn(
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    await Provider.of<AuthViewModel>(context, listen: false)
                        .Login(nameController.text, passwordController.text);
                    if (Provider.of<AuthViewModel>(context, listen: false)
                        .login_response) {
                      nameController.text = '';
                      passwordController.text = '';
                      Navigator.pushNamed(context, '/dashboard');
                    } else {
                      ;
                      Fluttertoast.showToast(
                          webBgColor:
                              "linear-gradient(to right, #ff2196f3, #ff2196bf)",
                          msg: "Login Failed \n",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  },
                ),
              ],
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SignInButton(
                  Buttons.Apple,
                  mini: true,
                  onPressed: () {},
                ),
                SignInButton(
                  Buttons.Facebook,
                  mini: true,
                  onPressed: () {},
                ),
              ],
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Forgot Password?',
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 20)),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: Text('Sign up',
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 20)),
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    ));
  }
}
