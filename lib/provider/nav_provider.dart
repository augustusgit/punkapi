
import 'package:flutter/foundation.dart';

class NavProvider extends ChangeNotifier{


  int _activeIndex = 0;
  int get activeIndex => _activeIndex;

  set setPosition(int id) {
    _activeIndex = id;
    notifyListeners();
  }

  final String _postBaseUrl = "/photos";
  String get postBaseUrl => _postBaseUrl;

}