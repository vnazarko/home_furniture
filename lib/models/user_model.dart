import 'package:flutter/material.dart';

class UserModel extends ChangeNotifier {
  List<int> _favorites = []; 
  List<int> _cart = []; 

  List<int> get favorites => _favorites;
  List<int> get cart => _cart;

  void addOrRemoveInFavorites(int id) {
    if (_favorites.contains(id)) {
      _favorites.remove(id);
    } else {
      _favorites.add(id);
    }
    notifyListeners();
  }


  void addOrRemoveInCart(int id) {
    if (_cart.contains(id)) {
      _cart.remove(id);
    } else {
      _cart.add(id);
    }
    notifyListeners();
  }
}