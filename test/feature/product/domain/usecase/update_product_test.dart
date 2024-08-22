import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:layout_in_flutter/core/error/failure.dart';
import 'package:layout_in_flutter/feature/product/domain/Entity/product.dart';
import 'package:layout_in_flutter/feature/product/domain/usecase/update_product.dart';

import 'mock_classes.mocks.dart';

void main() {
  late UpdateProductUsecase updateProductUsecase;
  late MockProductRepo mockProductRepo;

  setUp(() {
    mockProductRepo = MockProductRepo();
    updateProductUsecase = UpdateProductUsecase(mockProductRepo);
  });

  final productId = '1';
  final updatedProduct = ProductEntity(
    id: productId,
    productName: 'Updated Laptop',
    price: 899.9,
    description: 'An updated high-performance laptop',
    imageUrl: 'http://example.com/updated_laptop.png',
  );
  final failure = UploadFailure('Failed to update product');

  test('should return ProductEntity on success and Failure on failure', () async {
    // Arrange
    when(mockProductRepo.updateProduct(
      productId,
      productName: updatedProduct.productName,
      price: updatedProduct.price,
      description: updatedProduct.description,
      imageUrl: updatedProduct.imageUrl,
    )).thenAnswer((_) async => Right(updatedProduct));

    // Act
    final resultSuccess = await updateProductUsecase.execute(
      productId,
      productName: updatedProduct.productName,
      price: updatedProduct.price,
      description: updatedProduct.description,
      imageUrl: updatedProduct.imageUrl,
    );

    // Assert success result
    expect(resultSuccess, Right(updatedProduct));

    // Arrange for failure
    when(mockProductRepo.updateProduct(
      productId,
      productName: updatedProduct.productName,
      price: updatedProduct.price,
      description: updatedProduct.description,
      imageUrl: updatedProduct.imageUrl,
    )).thenAnswer((_) async => Left(failure));

    // Act
    final resultFailure = await updateProductUsecase.execute(
      productId,
      productName: updatedProduct.productName,
      price: updatedProduct.price,
      description: updatedProduct.description,
      imageUrl: updatedProduct.imageUrl,
    );

    // Assert failure result
    expect(resultFailure, Left(failure));

    // Verify interactions
    verify(mockProductRepo.updateProduct(
      productId,
      productName: updatedProduct.productName,
      price: updatedProduct.price,
      description: updatedProduct.description,
      imageUrl: updatedProduct.imageUrl,
    ));
    verifyNoMoreInteractions(mockProductRepo);
  });
}
