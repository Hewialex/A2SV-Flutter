import 'dart:convert';
import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:layout_in_flutter/core/error/exceptions.dart';
import 'package:layout_in_flutter/feature/product/data/data_source/product_remote_data_source.dart';
import 'package:layout_in_flutter/feature/product/data/models/product_model.dart';

import 'package:mockito/mockito.dart';

import '../../domain/usecase/mock_classes.mocks.dart';



void main() {
  late ProductRemoteDataSourceImpl productRemoteDataSourceImpl;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    productRemoteDataSourceImpl = ProductRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('addProduct', () {
    const productModel = ProductModel(
      id: '1',
      productName: 'Test Product',
      price: 99.99,
      description: 'Test Description',
      imageUrl: 'Image/image.png',
    );

    test('should perform a POST request on a URL with product being the endpoint and with application/json header', () async {
      final imageBytes = utf8.encode('image_bytes') as Uint8List;

      when(mockHttpClient.send(any)).thenAnswer((_) async {
        final http.Response response = http.Response(jsonEncode({
          'id': '1',
          'productName': 'Test Product',
          'price': 99.99,
          'description': 'Test Description',
          'imageUrl': 'Image/image.png',
        }), 200);
        return http.StreamedResponse(Stream.value(response.bodyBytes), response.statusCode);
      });

      final result = await productRemoteDataSourceImpl.addProduct(productModel);

      verify(mockHttpClient.send(captureAny)).called(1);
      expect(result, productModel);
    });

    test('should throw a ServerException when the response code is 404 or other', () async {
      final imageBytes = utf8.encode('image_bytes') as Uint8List;

      when(mockHttpClient.send(any)).thenAnswer((_) async {
        return http.StreamedResponse(Stream.value([]), 404);
      });

      final call = productRemoteDataSourceImpl.addProduct(productModel);

      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('deleteProductById', () {
    const tId = '1';
    final apiUrl = "https://g5-flutter-learning-path-be.onrender.com/api/v1/products/$tId";

    test('should perform a DELETE request on the correct URL with the provided id', () async {
      // arrange
      when(mockHttpClient.delete(Uri.parse(apiUrl)))
          .thenAnswer((_) async => http.Response('', 200));

      // act
      final result = await productRemoteDataSourceImpl.deleteProductById(tId);

      // assert
      verify(mockHttpClient.delete(Uri.parse(apiUrl))).called(1);
      expect(result, equals(unit)); // Ensure result matches Unit
    });

    test('should throw a ServerException when the response code is not 200', () async {
      // arrange
      when(mockHttpClient.delete(Uri.parse(apiUrl)))
          .thenAnswer((_) async => http.Response('', 404));

      // act
      final call = productRemoteDataSourceImpl.deleteProductById(tId);

      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
  group('getProductById', () {
    const tId = '1';
    const productModel = ProductModel(
      id: '1',
      productName: 'Test Product',
      price: 99.99,
      description: 'Test Description',
      imageUrl: 'Image/image.png',
    );

    test('should perform a GET request on a URL with the id being the endpoint', () async {
      when(mockHttpClient.get(any)).thenAnswer((_) async => http.Response(jsonEncode({
        'id': '1',
        'productName': 'Test Product',
        'price': 99.99,
        'description': 'Test Description',
        'imageUrl': 'Image/image.png',
      }), 200));

      final result = await productRemoteDataSourceImpl.getProductById(tId);

      verify(mockHttpClient.get(captureAny)).called(1);
      expect(result, productModel);
    });

    test('should throw a ServerException when the response code is 404 or other', () async {
      when(mockHttpClient.get(any)).thenAnswer((_) async => http.Response('', 404));

      final call = productRemoteDataSourceImpl.getProductById(tId);

      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('updateProduct', () {
    const tId = '1';
    const tProductName = 'Updated Product';
    const tPrice = 199.99;
    const tDescription = 'Updated Description';
    const tImageUrl = 'Image/imagecopy.png';
    const updatedProductModel = ProductModel(
      id: '1',
      productName: tProductName,
      price: tPrice,
      description: tDescription,
      imageUrl: tImageUrl,
    );

    test('should perform a PUT request on a URL with the id being the endpoint', () async {
      final imageBytes = utf8.encode('image_bytes') as Uint8List;

      when(mockHttpClient.send(any)).thenAnswer((_) async {
        final http.Response response = http.Response(jsonEncode({
          'id': '1',
          'productName': tProductName,
          'price': tPrice,
          'description': tDescription,
          'imageUrl': tImageUrl,
        }), 200);
        return http.StreamedResponse(Stream.value(response.bodyBytes), response.statusCode);
      });

      final result = await productRemoteDataSourceImpl.updateProduct(
        tId,
        productName: tProductName,
        price: tPrice,
        description: tDescription,
        imageUrl: tImageUrl,
      );

      verify(mockHttpClient.send(captureAny)).called(1);
      expect(result, updatedProductModel);
    });

    test('should throw a ServerException when the response code is 404 or other', () async {
      final imageBytes = utf8.encode('image_bytes') as Uint8List;

      when(mockHttpClient.send(any)).thenAnswer((_) async {
        return http.StreamedResponse(Stream.value([]), 404);
      });

      final call = productRemoteDataSourceImpl.updateProduct(
        tId,
        productName: tProductName,
        price: tPrice,
        description: tDescription,
        imageUrl: tImageUrl,
      );

      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
