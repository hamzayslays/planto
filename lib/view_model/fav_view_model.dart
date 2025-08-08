import 'package:flutter/material.dart';

class FavoriteViewModel extends ChangeNotifier {
  final List<String> _favoritePlantIds = [];

  List<String> get favorites => _favoritePlantIds;

  bool isFavorite(String plantId) {
    return _favoritePlantIds.contains(plantId);
  }

  void toggleFavorite(String plantId) {
    if (_favoritePlantIds.contains(plantId)) {
      _favoritePlantIds.remove(plantId);
    } else {
      _favoritePlantIds.add(plantId);
    }
    notifyListeners();
  }
}
