import 'package:TishApp/TishApp/Components/CloseBtn.dart';
import 'package:TishApp/TishApp/Components/SubmitBtn.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:TishApp/TishApp/viewmodel/authProvider.dart';
import 'package:provider/provider.dart';

import 'TishAppLogin.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage();

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController lastNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();

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
                    'Sign up and',
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 30),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('start',
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 30)),
                ],
              ),
              Spacer(),
              TextField(
                controller: firstNameController,
                decoration: InputDecoration(
                  labelText: 'First Name',
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: lastNameController,
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                  ),
                ),
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Sign in',
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 30)),
                  SubmitBtn(
                    onPressed: () async {
                      await Provider.of<AuthProvider>(context, listen: false)
                          .Register(
                              firstNameController.text,
                              lastNameController.text,
                              passwordController.text,
                              emailController.text);
                      if (Provider.of<AuthProvider>(context, listen: false)
                          .register_response) {
                        firstNameController.text = '';
                        lastNameController.text = '';
                        passwordController.text = '';
                        emailController.text = '';
                        Navigator.pop(context);
                      } else {
                        Fluttertoast.showToast(
                            webBgColor:
                                "linear-gradient(to right, #ff2196f3, #ff2196bf)",
                            msg: "Registration Failed \n",
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Text('Sign in',
                        style: TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 20)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
