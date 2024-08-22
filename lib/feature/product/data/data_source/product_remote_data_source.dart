import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:http_parser/http_parser.dart';
import 'package:layout_in_flutter/core/error/exceptions.dart';
import 'package:layout_in_flutter/feature/product/data/models/product_model.dart';
import 'package:http/http.dart' as http;

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getAllProducts();
  Future<ProductModel> addProduct(ProductModel product);
  Future<Unit> deleteProductById(String id);
  Future<ProductModel> getProductById(String id);
  Future<ProductModel> updateProduct(
    String id, {
    required String productName,
    required double price,
    required String description,
    required String imageUrl,
  });
}

class ProductRemoteDataSourceImpl extends ProductRemoteDataSource {
  final http.Client client;
  ProductRemoteDataSourceImpl({required this.client});
  
  @override
  Future<ProductModel> addProduct(ProductModel product) async {
    const apiUrl = "https://g5-flutter-learning-path-be.onrender.com/api/v1/products";
    final imageBytes = await File(product.imageUrl).readAsBytes();
    final request = http.MultipartRequest('POST', Uri.parse(apiUrl));

    request.fields['name'] = product.productName;
    request.fields['price'] = product.price.toString();
    request.fields['description'] = product.description;

    request.files.add(http.MultipartFile.fromBytes(
      'image',
      imageBytes,
      filename: 'image.jpg',
      contentType: MediaType('image', 'jpeg'),
    ));

    final streamResponse = await client.send(request);
    final response = await http.Response.fromStream(streamResponse);

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      final product = ProductModel.fromJson(responseBody);
      return product;
    } else {
      throw ServerException();
    }
  }
  
  @override
  Future<Unit> deleteProductById(String id) async {
    final apiUrl = "https://g5-flutter-learning-path-be.onrender.com/api/v1/products/$id";
    final response = await client.delete(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      return unit;
    } else {
      throw ServerException();
    }
  }
  
  @override
  Future<ProductModel> getProductById(String id) async {
    final apiUrl = "https://g5-flutter-learning-path-be.onrender.com/api/v1/products/$id";
    final response = await client.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      final product = ProductModel.fromJson(responseBody);
      return product;
    } else {
      throw ServerException();
    }
  }
  
  @override
  Future<ProductModel> updateProduct(String id, {
    required String productName,
    required double price,
    required String description,
    required String imageUrl,
  }) async {
    print("inside update remote");
    print("name $productName $price $description");
    final apiUrl = "https://g5-flutter-learning-path-be.onrender.com/api/v1/products/$id";
   
   final data = {
    'name': productName,
    'price': price,
    'description': description,
  };


      final response = await http.put(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json', // Set the content type to JSON
      },
      body: jsonEncode(data), // Encode the data as JSON
    );

    if (response.statusCode == 200) {

      print("if");
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      final product = ProductModel.fromJson(responseBody);
      return product;
    } else {
      throw ServerException();
    }
  }
  
  @override
 Future<List<ProductModel>> getAllProducts() async {
    const apiUrl = "https://g5-flutter-learning-path-be.onrender.com/api/v1/products";
    final response = await client.get(Uri.parse(apiUrl));
    print("response");
    print(response.body);

    if (response.statusCode == 200) {
      print("here");
      final Map<String, dynamic> responseBody = jsonDecode(response.body);

      // Ensure 'data' is present in the response
      if (responseBody.containsKey('data')) {
        final List<dynamic> data = responseBody['data'];

        // Parse the data into a list of ProductModel
        final List<ProductModel> products = data.map((json) => ProductModel.fromJson(json)).toList();
        print("products $products");
        return products;
      } else {
        throw ServerException();
      }
    } else {
      throw ServerException();
    }
  }
}
