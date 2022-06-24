import 'package:TishApp/TishApp/Services/Place/Place_Badge_Repository.dart';
import 'package:TishApp/TishApp/Services/Place/Place_Type_Repository.dart';
import 'package:TishApp/TishApp/Services/Place/ReviewRepository.dart';
import 'package:flutter/cupertino.dart';
import 'package:TishApp/TishApp/Services/Place/PlaceRepository.dart';
import 'package:TishApp/TishApp/model/TishAppModel.dart';

class PlaceProvider with ChangeNotifier {
  List<Place> _placeList = [];
  Place? _place;
  //  = Place(
  //     Created_at: 'null',
  //     Description: 'null',
  //     Location: 'null',
  //     Name: 'null',
  //     Place_ID: 'null',
  //     reviews: [],
  //     earnedBadges: [],
  //     place_type: Place_Type(Place_Type_ID: 'null', Type: 'null'));
  List<Place_Badge> _place_badge_List = [];
  List<Place_Type> _place_type_List = [];

  Future<void> fetchPlace_TypeData() async {
    print("Entered");
    try {
      List<Place_Type> _place_Types =
          await Place_TypeRepository().fetchPlace_TypeList();
      setSelectedPlace_Type(_place_Types);
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  void setSelectedPlace_Type(List<Place_Type> _place_type_List) {
    this._place_type_List = [];
    this._place_type_List.addAll(_place_type_List);
    notifyListeners();
  }

  List<Place_Badge> get place_badge_List {
    return _place_badge_List;
  }

  Future<void> fetchPlace_BadgeData() async {
    try {
      List<Place_Badge> _place_Types =
          await Place_BadgeRepository().fetchPlace_BadgeList();
      setSelectedPlace_Badge(_place_Types);
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  void setSelectedPlace_Badge(List<Place_Badge> list) {
    this._place_badge_List.addAll(list);
    notifyListeners();
  }

  List<Place_Type> get place_type_List {
    return _place_type_List;
  }

  PlaceProvider() {
    fetchAll();
  }

  Future<void> fetchAll() async {
    try {
      List<Place> response = await PlaceRepository().fetchAllPlace();
      _placeList = response;
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  Future<void> fetchOne(int id) async {
    try {
      Place response = await PlaceRepository().fetchOnePlace(id);
      setSelectedPlace(response);
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

    Future<Place> PlaceByID(int id) async {
      var response;
    try {
      response = await PlaceRepository().fetchOnePlace(id);
      return response;
    } catch (e) {
      print(e);
      return response;
    }
    
  }

  Future<String> fetchPlaceImage(String bucketName, String imageName) async {
    String response = 'false';
    try {
      response =
          await PlaceRepository().fetchOnePlaceImage(bucketName, imageName);
    } catch (e) {
      print(e);
    }
    return response;
  }

  void setSelectedPlace(Place place) {
    this._place = place;
    notifyListeners();
  }

  Place? get place {
    return _place;
  }

  List<Place> get placeList {
    return _placeList;
  }

  Future<bool> addReview(
      String userEmail, int placeID, int rating, String message) async {
    bool response = await ReviewRepository()
        .AddReviewToPlace(userEmail, placeID, rating, message);
    if (response) {
      Place p = placeList.firstWhere((element) => element.Place_ID == placeID);
      p.reviews.add(Review(
          Rating: rating,
          Message: message,
          Updated_At: DateTime.now(),
          Created_At: DateTime.now()));
      double temp = 0.0;
      for (var item in p.reviews) {
        temp += double.parse(item.Rating.toString());
      }
      if (temp != 0) temp /= p.reviews.length;

      p.averageReviews = temp;
    }
    notifyListeners();
    return response;
  }
}
