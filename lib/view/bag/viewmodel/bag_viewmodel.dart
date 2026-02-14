import 'package:flutter/material.dart';

class BagViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
}
