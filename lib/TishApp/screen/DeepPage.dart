import 'package:TishApp/TishApp/model/TishAppModel.dart';
import 'package:TishApp/TishApp/screen/PlaceDescription2.dart';
import 'package:TishApp/TishApp/viewmodel/PlaceProvider.dart';
import 'package:TishApp/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'PlaceDescription.dart';

class DeepPage extends StatefulWidget {
  DeepPage({ Key? key , required this.Place_ID}) : super(key: key);

  int Place_ID;

  @override
  State<DeepPage> createState() => _DeepPageState();
}

class _DeepPageState extends State<DeepPage> {

  init() async{
    Place place = await Provider.of<PlaceProvider>(context, listen: false).PlaceByID(widget.Place_ID);
                                        if (place.place_type.Type
                                            .toString()
                                            .toLowerCase() !=
                                        'restaurant') {
                                          navigator.currentState!.push(MaterialPageRoute(
                                              builder: (context) =>
                                                  PlaceDescription2(
                                                      place: place)));
                                    } else {   
                                      navigator.currentState!.push(MaterialPageRoute(
                                              builder: ((context) =>
                                                  TishAppDescription(
                                                      place: place))));
                                    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
    );
  }
}