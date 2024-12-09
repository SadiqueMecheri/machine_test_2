import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../Model/Category.dart';

class CategoryProvider with ChangeNotifier {
  List<Category> _categories = [];
  List<int> _selectedCategoryIds = [];
  File? _thumbnail;
  File? _video;

  List<Category> get categories => _categories;
  List<int> get selectedCategoryIds => _selectedCategoryIds;
  File? get thumbnail => _thumbnail;
  File? get video => _video;

  CategoryProvider() {
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    log("category  loadeddd");
    final response = await http
        .get(Uri.parse('https://frijo.noviindus.in/api/category_list'));
    if (response.statusCode == 202) {
      final data = json.decode(response.body);
      _categories = (data['categories'] as List)
          .map((categoryJson) => Category.fromJson(categoryJson))
          .toList();
      notifyListeners();
    } else {
      throw Exception('Failed to fetch categories');
    }
  }

  void toggleCategorySelection(int categoryId) {
    if (_selectedCategoryIds.contains(categoryId)) {
      _selectedCategoryIds.remove(categoryId);
    } else {
      _selectedCategoryIds.add(categoryId);
    }
    notifyListeners();
  }

  Future<void> pickThumbnail() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _thumbnail = File(pickedFile.path);
      notifyListeners();
    }
  }

  Future<void> pickVideo() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      _video = File(pickedFile.path);
      notifyListeners();
    }
  }

  Future<void> uploadData(String description) async {
    if (_thumbnail == null || _video == null) {
      throw Exception("Thumbnail and Video are required.");
    }

    final uri = Uri.parse(
        'https://example.com/api/upload'); // Replace with your API endpoint
    final request = http.MultipartRequest('POST', uri);

    // Add text fields
    request.fields['description'] = description;
    request.fields['categories'] = _selectedCategoryIds.join(',');

    // Add files
    request.files
        .add(await http.MultipartFile.fromPath('thumbnail', _thumbnail!.path));
    request.files.add(await http.MultipartFile.fromPath('video', _video!.path));

    final response = await request.send();

    if (response.statusCode == 200) {
      print('Upload successful');
    } else {
      throw Exception('Failed to upload data');
    }
  }
}
