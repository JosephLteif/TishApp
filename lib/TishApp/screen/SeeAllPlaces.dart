import 'package:TishApp/TishApp/model/TishAppModel.dart';
import 'package:TishApp/TishApp/screen/PlaceDescription.dart';
import 'package:TishApp/TishApp/viewmodel/PlaceProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SeeAllPage extends StatefulWidget {
  String category;
  SeeAllPage({Key? key, required this.category}) : super(key: key);

  @override
  State<SeeAllPage> createState() => _SeeAllPageState();
}

class _SeeAllPageState extends State<SeeAllPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PlaceProvider>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: Text(widget.category),
        ),
        body: ListView.builder(
            itemCount: widget.category != 'all'
                ? value.placeList
                    .where((element) =>
                        element.place_type.Type.toString().toLowerCase() ==
                        widget.category.toLowerCase())
                    .length
                : value.placeList.length,
            itemBuilder: (context, index) {
              Place p = widget.category != 'all'
                  ? value.placeList
                      .where((element) =>
                          element.place_type.Type.toString().toLowerCase() ==
                          widget.category.toLowerCase())
                      .elementAt(index)
                  : value.placeList.elementAt(index);
              return ListTile(
                title: Text(p.Name),
                subtitle: Text(p.place_type.Type.toString()),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TishAppDescription(place: p)));
                },
              );
            }),
      ),
    );
  }
}
