import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:layout_in_flutter/core/error/exceptions.dart';
import 'package:layout_in_flutter/feature/product/data/data_source/product_local_data_source.dart';
import 'package:layout_in_flutter/feature/product/data/models/product_model.dart';
import 'package:mockito/mockito.dart';


import '../../domain/usecase/json_reader.dart';
import '../../domain/usecase/mock_classes.mocks.dart'; // Import the generated mocks

void main() {
  late MockSharedPreferences mockSharedPreferences;
  late ProductLocalDataSourceImpl productLocalDataSourceImpl;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    productLocalDataSourceImpl =
        ProductLocalDataSourceImpl(pref: mockSharedPreferences);
  });

  group('getCachedProducts', () {
    final tProductModelList = [
      ProductModel.fromJson(
        json.decode(readJson('dummy_product_response.json')),
      ),
    ];

    test('should return a list of product models when there is cached data', () async {
      // arrange
      when(mockSharedPreferences.getStringList('cachedProduct'))
          .thenReturn([readJson('dummy_product_response.json')]);

      // act
      final result = await productLocalDataSourceImpl.getCachedProducts();

      // assert
      expect(result, equals(tProductModelList));
    });

    test('should throw a CacheException when there is no cached value', () async {
      // arrange
      when(mockSharedPreferences.getStringList('cachedProduct')).thenReturn(null);

      // act
      final call = productLocalDataSourceImpl.getCachedProducts;

      // assert
      expect(() => call(), throwsA(isA<CacheException>()));
    });
  });

  group('cacheProduct', () {
    final tProductModel = ProductModel(
      id: "123",
      productName: "Laptop",
      price: 999.9,
      description: "Slim and nice",
      imageUrl: "image",
    );

    test('should call SharedPreferences to cache the data', () async {
      // arrange
      final jsonString = jsonEncode(tProductModel.toJson());
      when(mockSharedPreferences.getStringList('cachedProduct')).thenReturn([]);
      when(mockSharedPreferences.setStringList('cachedProduct', any)).thenAnswer((_) async => true);

      // act
      await productLocalDataSourceImpl.cacheProduct(tProductModel);

      // assert
      verify(mockSharedPreferences.setStringList('cachedProduct', [jsonString]));
    });

    test('should return true when data is cached successfully', () async {
      // arrange
      final jsonString = jsonEncode(tProductModel.toJson());
      when(mockSharedPreferences.getStringList('cachedProduct')).thenReturn([]);
      when(mockSharedPreferences.setStringList('cachedProduct', [jsonString])).thenAnswer((_) async => true);

      // act
      final result = await productLocalDataSourceImpl.cacheProduct(tProductModel);

      // assert
      expect(result, true);
    });

    test('should return false when data is not cached successfully', () async {
      // arrange
      final jsonString = jsonEncode(tProductModel.toJson());
      when(mockSharedPreferences.getStringList('cachedProduct')).thenReturn([]);
      when(mockSharedPreferences.setStringList('cachedProduct', [jsonString])).thenAnswer((_) async => false);

      // act
      final result = await productLocalDataSourceImpl.cacheProduct(tProductModel);

      // assert
      expect(result, false);
    });
  });
}
