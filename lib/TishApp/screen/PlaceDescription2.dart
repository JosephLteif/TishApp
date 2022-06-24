import 'package:TishApp/TishApp/Services/Place/UserFavoritePlacesRepository.dart';
import 'package:TishApp/TishApp/model/TishAppModel.dart';
import 'package:TishApp/TishApp/utils/TishAppColors.dart';
import 'package:TishApp/TishApp/utils/TishAppImages.dart';
import 'package:TishApp/TishApp/utils/TishAppWidget.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:share_plus/share_plus.dart';

class PlaceDescription2 extends StatefulWidget {
  Place place;
  PlaceDescription2({Key? key, required this.place}) : super(key: key);

  @override
  State<PlaceDescription2> createState() => _PlaceDescription2State();
}

class _PlaceDescription2State extends State<PlaceDescription2> {
  SharedPreferences? prefs;
  bool liked = false;
  String email = '';

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    prefs = await SharedPreferences.getInstance();
    email = await prefs!.getString('email').toString();
    liked = await User_Favorite_PlacesRepository()
        .ifalreadyLiked(email, int.parse(widget.place.Place_ID.toString()));
    print('liked ==>> $liked');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(children: [
        Column(
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(TishApp_PlaceHolderImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50),
                            ),
                            color: Colors.black26),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(widget.place.Name,
                                      style: primaryTextStyle(
                                          size: 25,
                                          color: Colors.white,
                                          weight: FontWeight.bold)),
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: liked ? Colors.red : Colors.grey,
                                    ),
                                    child: IconButton(
                                        onPressed: () async {
                                          if (!liked) {
                                            await User_Favorite_PlacesRepository()
                                                .LikePlace(
                                                    email,
                                                    int.parse(widget
                                                        .place.Place_ID
                                                        .toString()));
                                            liked = true;
                                          } else {
                                            await User_Favorite_PlacesRepository()
                                                .DislikePlace(
                                                    email,
                                                    int.parse(widget
                                                        .place.Place_ID
                                                        .toString()));
                                            liked = false;
                                          }
                                          setState(() {});
                                        },
                                        icon: Icon(
                                          Icons.favorite,
                                          color: Colors.white,
                                        )),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.pin_drop,
                                    color: mainColorTheme,
                                    size: 15,
                                  ),
                                  Text(widget.place.Location,
                                      style: primaryTextStyle(
                                          size: 10,
                                          color: Colors.white,
                                          weight: FontWeight.bold)),
                                ],
                              ),
                              totalRatting(widget.place.averageReviews),
                              SizedBox(height: 8),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
            Expanded(
                flex: 1,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(widget.place.Description),
                    ),
                  ),
                )),
          ],
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                  )),
                  IconButton(
                    color: Colors.white,
                      icon: Icon(Icons.share),
                      onPressed: () {
                        Share.share(
                            'https://tishapp.codepickles.com/DeepLink?placeId=${widget.place.Place_ID}');
                      }
                    )
            ],
          ),
        ),
      ])),
    );
  }
}
