import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeProvider with ChangeNotifier {
  List<dynamic> categoryDict = [];
  List<dynamic> videoResults = [];
  bool isLoading = false;

  Future<void> fetchHomeData() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.parse('https://frijo.noviindus.in/api/home');
    try {
      final response = await http.get(url);

      if (response.statusCode == 202) {
        final data = json.decode(response.body);
        categoryDict = data['category_dict'];
        videoResults = data['results'];
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      debugPrint('Error fetching data: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
