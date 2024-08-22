import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:layout_in_flutter/feature/product/data/models/product_model.dart';
import 'package:layout_in_flutter/feature/product/domain/Entity/product.dart';

import '../../domain/usecase/json_reader.dart';

void main() {
  var testProductModel = ProductModel(
    id: '123',
    productName: 'Laptop',
    price: 999.9,
    description: 'Slim and nice',
    imageUrl: 'image',
  );

  test('Should be a subclass of ProductEntity', () async {
    // assert
    expect(testProductModel, isA<ProductEntity>());
  });
  test('should return a valid model from json', () async {
    //arrange
    final Map<String, dynamic> jsonMap = json.decode(
      readJson(
          'dummy_product_response.json'),
    );

    //act
    final result = ProductModel.fromJson(jsonMap);

    // assert
    expect(result, equals(testProductModel));
  });

  test('should return a json map containing proper data',
  () async{

    //act 
    final result = testProductModel.toJson();

    //assert
    final expectedJsonMap = {
  'id': '123',
  'productName': 'Laptop',
  'price': 999.9,
  'description': 'Slim and nice',
  'imageUrl': 'image',
};
expect(result, equals(expectedJsonMap));

    
  });

}
