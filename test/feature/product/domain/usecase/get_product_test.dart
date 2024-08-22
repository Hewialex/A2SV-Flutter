import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:layout_in_flutter/core/error/failure.dart';
import 'package:layout_in_flutter/feature/product/domain/Entity/product.dart';
import 'package:layout_in_flutter/feature/product/domain/usecase/get_product.dart';

import 'mock_classes.mocks.dart';

void main() {
  late GetProductUsecase getProductUsecase;
  late MockProductRepo mockProductRepo;

  setUp(() {
    mockProductRepo = MockProductRepo();
    getProductUsecase = GetProductUsecase(mockProductRepo);
  });

  final productId = '1';
  final product = ProductEntity(
    id: productId,
    productName: 'Laptop',
    price: 999.9,
    description: 'A high-performance laptop',
    imageUrl: 'http://example.com/laptop.png',
  );
  final failure = UploadFailure('Product not found');

  test('should return correct result based on repository call', () async {
    // Arrange
    when(mockProductRepo.getProductById(productId))
        .thenAnswer((_) async => Right(product));

    // Act
    final resultSuccess = await getProductUsecase.execute(productId);

    // Assert
    expect(resultSuccess, Right(product));
    verify(mockProductRepo.getProductById(productId));

    // Arrange for failure case
    when(mockProductRepo.getProductById(productId))
        .thenAnswer((_) async => Left(failure));

    // Act for failure case
    final resultFailure = await getProductUsecase.execute(productId);

    // Assert for failure case
    expect(resultFailure, Left(failure));
    verify(mockProductRepo.getProductById(productId));
    verifyNoMoreInteractions(mockProductRepo);
  });
}
