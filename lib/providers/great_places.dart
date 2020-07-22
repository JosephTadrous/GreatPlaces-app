import 'dart:io';

import 'package:flutter/foundation.dart';

import '../models/place.dart';
import '../helpers/db_helper.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items]; // return a copy of _items
  }

  void addPlace(String pickedTitle, File pickedImage) {
    final newPlace = Place(
        id: DateTime.now().toString(),
        title: pickedTitle,
        image: pickedImage,
        location: null);
    _items.add(newPlace);
    notifyListeners();
    DbHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final placesList = await DbHelper.getPlaces('user_places');
    _items = placesList
        .map(
          (place) => Place(
              id: place['id'],
              title: place['title'],
              image: File(place['image']),
              location: null),
        )
        .toList();
    notifyListeners();
  }
}
