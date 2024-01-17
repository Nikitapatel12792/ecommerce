// To parse this JSON data, do
//
//     final categoryModal = categoryModalFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CategoryModal categoryModalFromJson(String str) => CategoryModal.fromJson(json.decode(str));



class CategoryModal {
  List<Category> categories;

  CategoryModal({
    required this.categories,
  });

  factory CategoryModal.fromJson(Map<String, dynamic> json) => CategoryModal(
    categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
  );
}

class Category {
  String name;
  List<String> subcategory;

  Category({
    required this.name,
    required this.subcategory,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    name: json["name"],
    subcategory: List<String>.from(json["subcategory"].map((x) => x)),
  );
  
}
