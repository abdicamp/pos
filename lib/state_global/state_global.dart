// lib/state/global_loading_state.dart
import 'package:flutter/material.dart';

class GlobalLoadingState with ChangeNotifier {
  bool _isLoading = false;
  int lengthApproveRequest = 0;

  int get getlengthApproveRequestVariabel => lengthApproveRequest;
  bool get isLoading => _isLoading;

  void show() {
    _isLoading = true;
    notifyListeners();
  }

  void hide() {
    _isLoading = false;
    notifyListeners();
  }
}
