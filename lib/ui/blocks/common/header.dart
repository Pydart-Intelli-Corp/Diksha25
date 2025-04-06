import 'package:flutter/material.dart';


class NavigationProvider extends ChangeNotifier {
  String _active = 'home';
  String? _previousActive;
  String? _hovered;

  String get active => _active;
  String? get previousActive => _previousActive;
  String? get hovered => _hovered;

  set active(String value) {
    if (_active != value) {
      _previousActive = _active;
      _active = value;
      notifyListeners();
    }
  }

  set hovered(String? value) {
    if (_hovered != value) {
      _hovered = value;
      notifyListeners();
    }
  }
}
