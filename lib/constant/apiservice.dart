import 'dart:convert';

import 'package:eshop/apiModel/apimodel.dart';
import 'package:http/http.dart' as http;

class Apiservice {
  List<Products> product = [];
  List<Products> category = [];
  Autogenerated autogenerated = Autogenerated();
  List category1 = [];
  List<Products> smartCategory = [];
  Future productApi() async {
    try {
      String api = 'https://dummyjson.com/products?sortBy=title&order=asc';

      final uri = Uri.parse(api);
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        if (jsonData['products'] == null) {
          print("Key 'products' not found in JSON!");
          // return;
        } else {
          print("not working");
        }

        final List<dynamic> productList = jsonData['products'];

        category = productList.map((item) => Products.fromJson(item)).toList();
        return category;
        print('Parsed product list: ${product[1].availabilityStatus}');
      }
    } catch (e) {
      print("error>>$e");
    }
    throw '';
  }

  Future fetchCategories() async {
    final response = await http.get(
      Uri.parse('https://dummyjson.com/products/category-list'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);

      CategoryModel categoryModel = CategoryModel.fromJson(jsonData);
      category1 = categoryModel.categories;
      // print("categ")
      return category1;
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<Autogenerated> productApi1(String cate) async {
    try {
      String api = "https://dummyjson.com/products/category/${cate}";

      final uri = Uri.parse(api);
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        print("Raw JSON: ${response.body}");

        final jsonData = jsonDecode(response.body);

        if (jsonData['products'] == null) {
          print("Key 'products' not found in JSON!");
          // return;
        }

        // final List<dynamic> productList = jsonData['products'];

        // print("First brand: ${productList[1]['brand']}");
        // Autogenerated autogenerated = jsonData
        //     .map((item) => Products.fromJson(item))
        //     .toList();
        // category = autogenerated.products!;

        print("category>>!$category1");
        // Autogenerated.fromJson(jsonData);
        return Autogenerated.fromJson(jsonData);

        print('Parsed product list: ${product[1].availabilityStatus}');
      }
    } catch (e) {
      print("error>>$e");
    }
    throw '';
  }

  Future smartphone() async {
    try {
      final response = await http.get(
        Uri.parse('https://dummyjson.com/products/category/smartphones'),
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        print("categorylist>>$jsonData");
        List product = jsonData['products'];
        smartCategory = product.map((item) => Products.fromJson(item)).toList();
        print("categ>>${smartCategory[2]}");
        return smartCategory;
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      print("error..>>$e");
    }
  }
}

class CategoryModel {
  final List<String> categories;

  CategoryModel({required this.categories});

  factory CategoryModel.fromJson(List<dynamic> json) {
    return CategoryModel(categories: List<String>.from(json));
  }
}
