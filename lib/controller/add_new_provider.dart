import 'package:flutter/material.dart';

class AddNewNoteProvider extends ChangeNotifier {
  String title = '';
  String description = '';

  void updateTitle(String value) {
    title = value;
    notifyListeners();
  }

  void updateDescription(String value) {
    description = value;
    notifyListeners();
  }
}
