import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:layout_in_flutter/core/error/failure.dart';
import 'package:layout_in_flutter/feature/product/domain/usecase/delete_product.dart';

import 'mock_classes.mocks.dart';

void main() {
  late DeleteProductUsecase deleteProductUsecase;
  late MockProductRepo mockProductRepo;

  setUp(() {
    mockProductRepo = MockProductRepo();
    deleteProductUsecase = DeleteProductUsecase(mockProductRepo);
  });

  final productId = '1';

  test('should return Unit when the repository call is successful', () async {
    // Arrange
    when(mockProductRepo.deleteProductById(productId))
        .thenAnswer((_) async => Right(unit));

    // Act
    final result = await deleteProductUsecase.execute(productId);

    // Assert
    expect(result, Right(unit));
    verify(mockProductRepo.deleteProductById(productId));
    verifyNoMoreInteractions(mockProductRepo);
  });

  test('should return Failure when the repository call fails', () async {
    // Arrange
    final failure = UploadFailure('Failed to delete');
    when(mockProductRepo.deleteProductById(productId))
        .thenAnswer((_) async => Left(failure));

    // Act
    final result = await deleteProductUsecase.execute(productId);

    // Assert
    expect(result, Left(failure));
    verify(mockProductRepo.deleteProductById(productId));
    verifyNoMoreInteractions(mockProductRepo);
  });
}
