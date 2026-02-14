import 'package:flutter/material.dart';

class SearchViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
}
