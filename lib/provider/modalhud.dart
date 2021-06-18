import 'package:flutter/cupertino.dart';

class ModalHub extends ChangeNotifier {
  bool isLoading = false;
  changeisLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
