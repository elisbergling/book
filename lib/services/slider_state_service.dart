import 'package:flutter/material.dart';

class SliderState extends ChangeNotifier {
  double _tempRating = 2;
  double _tempDistance = 10;
  double _tempPrice = 100;

  double? _realRating;
  double? _realDistance;
  double? _realPrice;

  double get rating => _tempRating;
  double get distance => _tempDistance;
  double get price => _tempPrice;

  set rating(r) {
    _tempRating = r;
    notifyListeners();
  }

  set distance(d) {
    _tempDistance = d;
    notifyListeners();
  }

  set price(p) {
    _tempPrice = p;
    notifyListeners();
  }

  void apply() {
    _realRating = _tempRating;
    _realDistance = _tempDistance;
    _realPrice = _tempPrice;
    notifyListeners();
  }

  void cancel() {
    _tempRating = _realRating ?? 2;
    _tempDistance = _realDistance ?? 10;
    _tempPrice = _realPrice ?? 100;
    notifyListeners();
  }
}
