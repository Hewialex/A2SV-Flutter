import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:layout_in_flutter/feature/product/domain/Entity/product.dart';
import 'package:layout_in_flutter/feature/product/domain/usecase/add_product.dart';
import 'package:mockito/mockito.dart';

import 'mock_classes.mocks.dart';

void main() {
  late AddProductUsecase addProductUsecase;
  late MockProductRepo mockProductRepo;

  setUp(() {
    mockProductRepo = MockProductRepo();
    addProductUsecase = AddProductUsecase(mockProductRepo);
  });

  final product = ProductEntity(
    id: '1',
    productName: 'Laptop',
    price: 999.9,
    description: 'A high-performance laptop',
    imageUrl: 'http://example.com/laptop.png',
  );

  test('should return a ProductEntity when the repository call is successful', () async {
    // Arrange
    when(mockProductRepo.addProduct(product))
        .thenAnswer((_) async => Right(product));

    // Act
    final result = await addProductUsecase.execute(product);

    // Assert
    expect(result, Right(product));
    verify(mockProductRepo.addProduct(product));
    verifyNoMoreInteractions(mockProductRepo);
  });
}
