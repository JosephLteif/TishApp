import 'package:TishApp/TishApp/Services/Place/ReviewRepository.dart';
import 'package:flutter/cupertino.dart';
import 'package:TishApp/TishApp/Services/Place/PlaceRepository.dart';
import 'package:TishApp/TishApp/model/TishAppModel.dart';

class PlaceViewModel with ChangeNotifier {
  late List<Place> _placeList = [];
  late Place _place = Place(
      Created_at: 'null',
      Description: 'null',
      Location: 'null',
      Name: 'null',
      Place_ID: 'null',
      reviews: [],
      earnedBadges: [],
      place_type: Place_Type(Place_Type_ID: 'null', Type: 'null'));

  PlaceViewModel() {
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

  Place get place {
    return _place;
  }

  List<Place> get placeList {
    return _placeList;
  }

  Future<bool> addReview(String userEmail, int placeID, int rating, String message) async {
    bool response = await ReviewRepository().AddReviewToPlace(
                                    userEmail,
                                    placeID,
                                    rating,
                                    message);
    if (response) {
      Place p = placeList.firstWhere((element) => element.Place_ID == placeID);
      p.reviews.add(
          Review(
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
