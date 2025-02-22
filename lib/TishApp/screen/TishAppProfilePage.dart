import 'package:TishApp/TishApp/Services/AuthService.dart';
import 'package:TishApp/TishApp/Services/UserService.dart';
import 'package:TishApp/TishApp/model/TishAppModel.dart';
import 'package:TishApp/TishApp/utils/TishAppColors.dart';
import 'package:TishApp/TishApp/utils/TishAppString.dart';
import 'package:TishApp/TishApp/utils/TishAppWidget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage();

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late User user;
  late SharedPreferences prefs;
  int likedPlacesNum = 0;
  int reviewsNum = 0;
  int AvgRating = 0;
  String name = "";
  String email = "";
  String location = "";

  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name')!.toString();
    email = prefs.getString('email')!.toString();
    location = prefs.getString(prefs_UserLocation)!.toString();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<IconData> icons = [
      Icons.edit,
      Icons.person,
      Icons.settings,
      Icons.help,
      Icons.info,
    ];
    List<String> categories = [
      'Me',
      'Account',
      'General',
      'Help',
      'About us',
    ];
    List<String> text = [
      name,
      email,
      'Compress Photos',
      'Questions',
      '',
    ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: mainColorTheme,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          Text(
                            name,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(location),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              // Spacer(),
              Flexible(
                child: FutureBuilder<User>(
                  future: UserRepository().fetchUserByEmail(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        user = snapshot.data!;
                        return ListView.builder(
                          itemCount: user.reviews.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: CircleAvatar(),
                              title: Text(user.Username),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      totalRatting(user.reviews[index].Rating),
                                      Text(
                                          " - ${user.reviews.elementAt(index).Updated_At.toString().split("T")[0]}")
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(user.reviews
                                      .elementAt(index)
                                      .Message
                                      .toString()),
                                ],
                              ),
                            );
                          },
                        );
                      } else {
                        return Container();
                      }
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
              IconButton(
                  onPressed: () async {
                    await AuthService().LogoutRepo();
                  },
                  icon: Icon(Icons.logout)),
            ],
          ),
        ),
      ),
    );
  }
}
