import 'package:flutter/material.dart';

class ColorUtils {
  static Color getCategoryColor(String category) {
    switch (category) {
      case 'Cultural':
        return Colors.purple;
      case 'Technical':
        return Colors.blue;
      case 'Management':
        return Colors.orange;
      case 'Creative':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}