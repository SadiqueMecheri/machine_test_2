import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../Model/Category.dart';
import '../session/shared_preferences.dart';

class CategoryProvider with ChangeNotifier {
  List<Category> _categories = [];
  List<int> _selectedCategoryIds = [];
  File? _thumbnail;
  File? _video;
  bool _isLoading = false; // Added loading state

  List<Category> get categories => _categories;
  List<int> get selectedCategoryIds => _selectedCategoryIds;
  File? get thumbnail => _thumbnail;
  File? get video => _video;
  bool get isLoading => _isLoading; // Getter for loading

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

  Future<void> pickVideo(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      _video = File(pickedFile.path);
      notifyListeners();
    }
  }

  Future<void> uploadData(String description) async {
    try {
      _isLoading = true; // Show loader

      notifyListeners();
      String? token = await Store.getFcmtoken();
      if (_thumbnail == null || _video == null) {
        throw Exception("Thumbnail and Video are required.");
      }

      final uri = Uri.parse(
          'https://frijo.noviindus.in/api/my_feed'); // Replace with your API endpoint
      final request = http.MultipartRequest(
        'POST',
        uri,
      );

      // Add custom headers
      request.headers.addAll({
        "Authorization":
            "Bearer ${token}", // Replace with a valid token if needed
        'Content-Type': 'multipart/form-data',
      });

      // Add text fields
      request.fields['desc'] = description;
      request.fields['category'] = _selectedCategoryIds.join(',');

      // Add files
      request.files
          .add(await http.MultipartFile.fromPath('image', _thumbnail!.path));
      request.files
          .add(await http.MultipartFile.fromPath('video', _video!.path));
      log("lloaddd first");
      final response = await request.send();

      log("lloaddd");

      if (response.statusCode == 202) {
        print('Upload successful');
      } else {
        throw Exception('Failed to upload data');
      }
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      _isLoading = false; // Hide loader
      notifyListeners();
    }
  }
}
