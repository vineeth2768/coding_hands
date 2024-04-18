import 'package:flutter/material.dart';

class BrandSelectionProvider with ChangeNotifier {
  String? _selectedBrand;

  String? get selectedBrand => _selectedBrand;

  void setSelectedBrand(String? brand) {
    _selectedBrand = brand;
    notifyListeners();
  }
}
