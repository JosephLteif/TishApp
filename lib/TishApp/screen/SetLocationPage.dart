import 'package:TishApp/TishApp/utils/TishAppColors.dart';
import 'package:TishApp/TishApp/utils/TishAppImages.dart';
import 'package:TishApp/TishApp/utils/TishAppString.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetLocationPage extends StatefulWidget {
  SetLocationPage({Key? key}) : super(key: key);

  @override
  State<SetLocationPage> createState() => _SetLocationPageState();
}

class _SetLocationPageState extends State<SetLocationPage> {
  TextEditingController? _LocationController;
  SharedPreferences? _sharedPreferences;

  @override
  void initState() {
    // TODO: implement initState
    init();
    super.initState();
  }

  init() async {
    _LocationController = TextEditingController();
    _sharedPreferences = await SharedPreferences.getInstance();
    _LocationController!.text =
        _sharedPreferences!.getString(prefs_UserLocation).toString();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      body: Stack(children: [
        Container(
          height: height,
          width: width,
          child: Image.asset(
            TishApp_BackgroundLocationImage,
            fit: BoxFit.fill,
          ),
          decoration: BoxDecoration(color: Colors.grey.shade100),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            children: [
              Spacer(
                flex: 3,
              ),
              Text(
                lbl_confirm_your_location,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Spacer(
                flex: 1,
              ),
              Icon(
                Icons.pin_drop,
                color: mainColorTheme,
                size: 114,
              ),
              Spacer(
                flex: 1,
              ),
              TextField(
                controller: _LocationController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: lbl_location,
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey))),
              ),
              Spacer(
                flex: 1,
              ),
              ElevatedButton(
                  onPressed: () async {
                    await _sharedPreferences!.setString(
                        prefs_UserLocation, _LocationController!.text);
                    Fluttertoast.showToast(
                        msg: "Location Updated",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: mainColorTheme,
                        textColor: Colors.black,
                        fontSize: 16.0);
                  },
                  child: Text('Submit')),
              Spacer(
                flex: 3,
              ),
            ],
          ),
        )
      ]),
    );
  }
}
