import 'package:TishApp/TishApp/Components/Widgets.dart';
import 'package:TishApp/TishApp/Services/UserService.dart';
import 'package:TishApp/TishApp/model/TishAppModel.dart';
import 'package:TishApp/TishApp/utils/TishAppColors.dart';
import 'package:TishApp/TishApp/utils/TishAppImages.dart';
import 'package:TishApp/TishApp/viewmodel/PlaceProvider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                flex: 1,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(color: mainColorTheme),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          "Favorites",
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                    )
                  ],
                )),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: FutureBuilder<User>(
                  future: UserRepository().fetchUserByEmail(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return ListView.builder(
                        itemCount: snapshot.data!.favorite_Places.length,
                        itemBuilder: (context, index) {
                          Place temp =
                              snapshot.data!.favorite_Places[index].place;
                          String bucketName = temp.medias.length != 0
                              ? temp.medias[generateRandomNumber(
                                  0, temp.medias.length)]['bucketName']
                              : 'null';
                          String objectName = temp.medias.length != 0
                              ? temp.medias[generateRandomNumber(
                                  0, temp.medias.length - 1)]['objectName']
                              : 'null';
                          return Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: Colors.grey))),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      bucketName != 'null' &&
                                              objectName != 'null'
                                          ? FutureBuilder(
                                              future: PlaceProvider()
                                                  .fetchPlaceImage(
                                                      bucketName, objectName),
                                              builder: (context,
                                                  AsyncSnapshot<String>
                                                      snapshot) {
                                                String link =
                                                    'data:image/jpeg;base64,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';
                                                if (snapshot.data.toString() !=
                                                    "null") {
                                                  link =
                                                      snapshot.data.toString();
                                                }
                                                return Image.network(
                                                  link,
                                                  height: 250,
                                                  width: double.infinity,
                                                  fit: BoxFit.cover,
                                                );
                                              },
                                            )
                                          : ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(24.0),
                                              child: Image.asset(
                                                TishApp_PlaceHolderImage,
                                              ),
                                            ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.pin_drop,
                                            color: mainColorTheme,
                                          ),
                                          Text(
                                            temp.Location.toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 14),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Opacity(
                                              opacity: 0,
                                              child: Icon(Icons.pin_drop)),
                                          Text(
                                            temp.Name.toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(flex: 1, child: Container()),
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
