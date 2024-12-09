import 'package:flutter/material.dart';

class AppSizes {
  // Function to get the size based on BuildContext
  static Size getSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  // Add other commonly used sizes if needed
  static double getHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
}
