import 'package:TishApp/TishApp/Services/Place/ReviewRepository.dart';
import 'package:TishApp/TishApp/utils/TishAppImages.dart';
import 'package:TishApp/TishApp/utils/TishAppString.dart';
import 'package:TishApp/TishApp/utils/TishAppWidget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:TishApp/TishApp/model/TishAppModel.dart';
import 'package:TishApp/TishApp/utils/TishAppColors.dart';

class TishAppDescription extends StatefulWidget {
  Place place;
  static String tag = '/TishAppDescription';

  TishAppDescription({required this.place});

  @override
  TishAppDescriptionState createState() => TishAppDescriptionState();
}

class TishAppDescriptionState extends State<TishAppDescription> {
  double rating = 0;
  late SharedPreferences prefs;
  String email = "";
  bool liked = false;
  Icon likedIcon = Icon(Icons.star);
  Icon notlikedIcon = Icon(Icons.star_border);

  var _dialog;

  void init() async {
    prefs = await SharedPreferences.getInstance();
    email = prefs.getString('email')!.toString();
    for (var item in widget.place.reviews) {
      rating += double.parse(item.Rating.toString());
    }
    if (rating != 0) rating /= widget.place.reviews.length;
  }

  @override
  void initState() {
    init();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _reviewController = TextEditingController();
    return SafeArea(
      child: Scaffold(
        backgroundColor: TishApp_app_background,
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 190,
                floating: true,
                forceElevated: innerBoxIsScrolled,
                pinned: true,
                centerTitle: true,
                titleSpacing: 0,
                leading: IconButton(
                    icon: Icon(Icons.arrow_back, color: white),
                    onPressed: () {
                      finish(context);
                    }),
                // title: Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: <Widget>[
                // FutureBuilder(
                //     future: User_Favorite_PlacesRepository()
                //         .ifalreadyLiked(
                //             prefs.getString('email').toString(),
                //             snapshot.data!.Place_ID),
                //     builder:
                //         (context, AsyncSnapshot<bool> snapshot1) {
                //       if (snapshot.connectionState ==
                //           ConnectionState.done) {
                //         liked =
                //             snapshot1.data.toString() == 'true';
                //         return IconButton(
                //             onPressed: () async {
                //               if (!liked) {
                //                 await User_Favorite_PlacesRepository()
                //                     .LikePlace(
                //                         prefs
                //                             .getString('email')
                //                             .toString(),
                //                         snapshot.data!.Place_ID);
                //               } else {
                //                 await User_Favorite_PlacesRepository()
                //                     .DislikePlace(
                //                         prefs
                //                             .getString('email')
                //                             .toString(),
                //                         snapshot.data!.Place_ID);
                //               }

                //               liked = !liked;
                //               setState(() {});
                //             },
                //             icon:
                //                 liked ? likedIcon : notlikedIcon);
                //       } else {
                //         return IconButton(
                //           onPressed: () async {
                //             if (!liked) {
                //               await User_Favorite_PlacesRepository()
                //                   .LikePlace(
                //                       prefs
                //                           .getString('email')
                //                           .toString(),
                //                       snapshot.data!.Place_ID);
                //             } else {
                //               await User_Favorite_PlacesRepository()
                //                   .DislikePlace(
                //                       prefs
                //                           .getString('email')
                //                           .toString(),
                //                       snapshot.data!.Place_ID);
                //             }

                //             liked = !liked;
                //             setState(() {});
                //           },
                //           icon: Icon(Icons.star_border),
                //         );
                //   }
                // })
                //   ],
                // ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    height: 190,
                    child: Image.asset(
                      TishApp_PlaceHolderImage,
                      height: 190,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ];
          },
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(widget.place.Name,
                      style: primaryTextStyle(
                          size: 35,
                          color: Colors.black,
                          weight: FontWeight.bold)),
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
                              color: Colors.grey,
                              weight: FontWeight.bold)),
                    ],
                  ),
                  totalRatting(widget.place.averageReviews),
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        lbl_ambiance,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                          onTap: () {},
                          child: Text(
                            "see all >",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          )),
                    ],
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 180,
                    child: widget.place.medias.length != 0
                        ? ListView.builder(
                            itemCount: widget.place.medias.length,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CachedNetworkImage(
                                      imageUrl: this
                                          .widget
                                          .place
                                          .medias[index]
                                          .toString(),
                                      placeholder: placeholderWidgetFn()));
                            })
                        : Center(child: Text("No images available")),
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Reviews's section",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      widget.place.reviews.length != 0
                          ? ListView.builder(
                              shrinkWrap: true,
                              reverse: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: widget.place.reviews.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Container(
                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // Row(
                                            //   children: [
                                            //     CircleAvatar(),
                                            //     Padding(
                                            //       padding:
                                            //           const EdgeInsets
                                            //                   .only(
                                            //               left: 12.0),
                                            //       child: Text(
                                            //         this
                                            //             .widget
                                            //             .place
                                            //             .reviews
                                            //             .elementAt(
                                            //                 index).toString(),
                                            //         style: TextStyle(
                                            //             fontWeight:
                                            //                 FontWeight
                                            //                     .bold),
                                            //       ),
                                            //     ),
                                            //   ],
                                            // ),
                                            // Padding(
                                            //   padding:
                                            //       const EdgeInsets.only(
                                            //           top: 8.0),
                                            //   child: Row(
                                            //     children: [
                                            //       totalRatting(this
                                            //           .widget
                                            //           .place
                                            //           .reviews
                                            //           .elementAt(index)
                                            //           .Rating),
                                            //       Padding(
                                            //         padding:
                                            //             const EdgeInsets
                                            //                     .only(
                                            //                 left: 8.0),
                                            //         child: Text(this
                                            //             .widget
                                            //             .place
                                            //             .reviews
                                            //             .elementAt(
                                            //                 index)
                                            //             .Updated_At
                                            //             .toString()
                                            //             .split("T")[0]),
                                            //       )
                                            //     ],
                                            //   ),
                                            // ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 12.0),
                                              child: Text(
                                                this
                                                    .widget
                                                    .place
                                                    .reviews
                                                    .elementAt(index)
                                                    .Message
                                                    .toString()
                                                    .trim(),
                                                maxLines: 5,
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              })
                          : Center(child: Text("No Reviews Available")),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: TextField(
                          controller: _reviewController,
                          decoration: InputDecoration(
                              hintText: "Write a review",
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: mainColorTheme),
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                            onPressed: () async {
                              if (await ReviewRepository().AddReviewToPlace(
                                  email,
                                  widget.place.Place_ID,
                                  0,
                                  _reviewController.text.toString())) {
                                _reviewController.text = "";
                                Fluttertoast.showToast(
                                    msg: "Review added successfully",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              } else {
                                Fluttertoast.showToast(
                                    msg: "Something went wrong",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              }

                              setState(() {});
                            },
                            icon: Icon(Icons.send)),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
