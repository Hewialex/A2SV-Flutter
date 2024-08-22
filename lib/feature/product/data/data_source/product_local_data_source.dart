import 'dart:convert';

import 'package:layout_in_flutter/core/error/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/product_model.dart';

abstract class ProductLocalDataSource {
  Future<List<ProductModel>> getCachedProducts();
  Future<bool> cacheProduct(ProductModel productToCache);
}

class ProductLocalDataSourceImpl extends ProductLocalDataSource {
  final SharedPreferences pref;

  ProductLocalDataSourceImpl({required this.pref});

  @override
  Future<bool> cacheProduct(ProductModel productToCache) async {
    final jsonList = pref.getStringList('cachedProduct') ?? [];
    jsonList.add(jsonEncode(productToCache.toJson()));
    return await pref.setStringList('cachedProduct', jsonList);
  }

  @override
  Future<List<ProductModel>> getCachedProducts() {
    final jsonList = pref.getStringList('cachedProduct');

    if (jsonList != null) {
      return Future.value(jsonList
          .map((jsonString) => ProductModel.fromJson(jsonDecode(jsonString)))
          .toList());
    }

    throw CacheException();
  }
}
