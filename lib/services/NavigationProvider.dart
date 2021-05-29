import 'package:flutter/cupertino.dart';

class NavigationProvider extends ChangeNotifier {
  var currentPage = 0;

  setPage(index) {
    currentPage = index;
    notifyListeners();
  }
}
