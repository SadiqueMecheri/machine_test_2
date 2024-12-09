import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:machine_test_2/Model/CategoryModel.dart';

class CategoryProvider_Home with ChangeNotifier {
  List<Category> _categories = [];
  List<Result> _results = [];
  bool _isLoading = false;

  List<Category> get categories => _categories;
  List<Result> get results => _results;
  bool get isLoading => _isLoading;

  Future<void> fetchData() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response =
          await http.get(Uri.parse('https://frijo.noviindus.in/api/home'));

      if (response.statusCode == 202) {
        final data = json.decode(response.body);

        // Parse categories
        final categoriesData = data['category_dict'] as List<dynamic>;
        _categories = categoriesData.map((e) => Category.fromJson(e)).toList();

        // Parse results
        final resultsData = data['results'] as List<dynamic>;
        _results = resultsData.map((e) => Result.fromJson(e)).toList();
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
