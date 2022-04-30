import 'package:TishApp/TishApp/Services/Place/UserFavoritePlacesRepository.dart';
import 'package:TishApp/TishApp/model/TishAppModel.dart';
import 'package:TishApp/TishApp/screen/PlaceDescription.dart';
import 'package:TishApp/TishApp/screen/PlaceDescription2.dart';
import 'package:TishApp/TishApp/utils/TishAppColors.dart';
import 'package:TishApp/TishApp/utils/TishAppImages.dart';
import 'package:TishApp/TishApp/utils/TishAppString.dart';
import 'package:TishApp/TishApp/viewmodel/PlaceViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'SeeAllPlaces.dart';

class TishAppDashboard extends StatefulWidget {
  const TishAppDashboard();

  @override
  _TishAppDashboardState createState() => _TishAppDashboardState();
}

class _TishAppDashboardState extends State<TishAppDashboard> {

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<PlaceViewModel>(context, listen: false).fetchAll();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
            Stack(children: [
              Container(
                width: width,
                height: 200,
                decoration: BoxDecoration(color: mainColorTheme),
              ),
              Image.asset(
                TishApp_BackgroundLocationsmallImage,
                width: width,
                color: Colors.white,
              ),
              Container(
                width: width,
                height: 200,
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('start your', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                    Text('Adveture Now!', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                  ],
                ),
              )
            ]),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Transform.translate(
                offset: Offset(0, -30),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: lbl_where_do_you_want_to_go,
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(Icons.search, color: mainColorTheme),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            PlacesCarousel(
              title: "Trips Nearby",
              category: "Home",
            ),
            PlacesCarousel(
              title: "Popular Destinations",
              category: "all",
              Popular: true,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: SizedBox(
                height: 120,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    CategoryCardWidget(title: "Food", icon: Icons.fastfood, category: "Restaurant",),
                    CategoryCardWidget(title: "Hotels", icon: Icons.bed, category: "Hotels",),
                    CategoryCardWidget(
                        title: "Events", icon: Icons.calendar_month),
                  ],
                ),
              ),
            ),
            PlacesCarousel(
              title: "Most Restaurants",
              category: "Restaurant",
            ),
            PlacesCarousel(
              title: "Hiking",
              category: "Hiking",
            ),
          ]),
        ),
      ),
    );
  }
}

class CategoryCardWidget extends StatelessWidget {
  String title;
  IconData icon;
  String category;
  CategoryCardWidget({Key? key, required this.title, required this.icon, this.category = 'all'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SeeAllPage(category: category,)));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 70,
              width: 90,
              decoration: BoxDecoration(
                border: Border.all(color: mainColorTheme),
                color: Colors.white,
                borderRadius: BorderRadius.circular(17),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 7,
                    offset: Offset(0, 5), // changes position of shadow
                  ),
                ],
              ),
              child: Icon(
                icon,
                color: Colors.black,
                size: 50,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                title,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PlacesCarousel extends StatefulWidget {
  String title, category;
  bool Popular;
  PlacesCarousel({Key? key, required this.title, required this.category, this.Popular = false})
      : super(key: key);

  @override
  State<PlacesCarousel> createState() => _PlacesCarouselState();
}

class _PlacesCarouselState extends State<PlacesCarousel> {
  String email = '';
  SharedPreferences? prefs;
  List<Place> tempSort = [];
  bool firstTimeSorting = true;

  @override
  void initState() {
    // TODO: implement initState
    init();
  }

  init() async {
    prefs = await SharedPreferences.getInstance();
    email = prefs!.getString('email').toString();
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<PlaceViewModel>(
      builder: (context, value, child) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SeeAllPage(category: widget.category,)));
                    },
                    child: Text(
                      "see all >",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    )),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
                height: 170,
                child: ListView.builder(
                    itemCount: widget.category != 'all'
                        ? value.placeList
                            .where((element) =>
                                element.place_type.Type.toString().toLowerCase() == widget.category.toLowerCase())
                            .length>5?5:value.placeList
                            .where((element) =>
                                element.place_type.Type.toString().toLowerCase() == widget.category.toLowerCase())
                            .length
                        : value.placeList.length>5?5:value.placeList.length,
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index)  {
                      Place place;
                      if(!widget.Popular){
                        place = widget.category != 'all'
                          ? value.placeList
                              .where((element) =>
                                  element.place_type.Type.toString().toLowerCase() == widget.category.toString().toLowerCase())
                              .elementAt(index)
                          : value.placeList.elementAt(index);
                      } else {
                        if(firstTimeSorting){
                          tempSort = value.placeList;
                          tempSort.sort((a, b) => b.averageReviews.compareTo(a.averageReviews));
                          firstTimeSorting = false;
                        }
                        place = tempSort.elementAt(index);
                      }  
                      return FutureBuilder(
                        future: User_Favorite_PlacesRepository()
        .ifalreadyLiked(email, int.parse(place.Place_ID.toString())),
                        builder: (context, AsyncSnapshot<bool> snapshot) {
                          if(snapshot.hasData){
                            bool liked = snapshot.data.toString() == 'true';
                          return Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: GestureDetector(
                              onTap: () {
                                if (place.place_type.Type
                                        .toString()
                                        .toLowerCase() !=
                                    'restaurant') {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PlaceDescription2(place: place)));
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) =>
                                              TishAppDescription(place: place))));
                                }
                              },
                              child: SizedBox(
                                width: 175,
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Stack(children: [
                                        SizedBox(
                                            height: 130,
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                child: Image.asset(
                                                  TishApp_PlaceHolderImage2,
                                                  fit: BoxFit.fill,
                                                ))),
                                        SizedBox(
                                          height: 130,
                                          child: Align(
                                            alignment: Alignment.bottomRight,
                                            child: Container(
                                              height: 25,
                                              width: 25,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: liked
                                                    ? Colors.red
                                                    : Colors.grey,
                                              ),
                                              child: IconButton(
                                                  onPressed: () async {
                                                    if (!liked) {
                                                      await User_Favorite_PlacesRepository()
                                                          .LikePlace(
                                                              email,
                                                              int.parse(
                                                                  place.Place_ID
                                                                      .toString()));
                                                      liked = true;
                                                    } else {
                                                      await User_Favorite_PlacesRepository()
                                                          .DislikePlace(
                                                              email,
                                                              int.parse(
                                                                  place.Place_ID
                                                                      .toString()));
                                                      liked = false;
                                                    }
                                                    setState(() {});
                                                  },
                                                  icon: Icon(
                                                    Icons.favorite,
                                                    color: Colors.white,
                                                    size: 10,
                                                  )),
                                            ),
                                          ),
                                        )
                                      ]),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 14.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.pin_drop,
                                              color: mainColorTheme,
                                              size: 12,
                                            ),
                                            Text(
                                              place.Location.toString(),
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 14.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Opacity(
                                                opacity: 0,
                                                child: Icon(
                                                  Icons.pin_drop,
                                                  color: mainColorTheme,
                                                  size: 12,
                                                )),
                                            Text(
                                              place.Name,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13),
                                            ),
                                          ],
                                        ),
                                      )
                                    ]),
                              ),
                            ),
                          );
                          } else {
                            return Container();
                          }
                        }
                      );
                    })),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
