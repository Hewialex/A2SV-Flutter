import 'package:dartz/dartz.dart';
import 'package:layout_in_flutter/core/error/failure.dart';
import 'package:layout_in_flutter/feature/product/domain/Entity/product.dart';
import 'package:layout_in_flutter/feature/product/domain/repository/product_repo.dart';

class UpdateProductUsecase {
  final ProductRepo productRepo;

  UpdateProductUsecase(this.productRepo);

  Future<Either<Failure, ProductEntity>> execute(
    String id, {
    required String productName,
    required double price,
    required String description,
    required String imageUrl,
  }) {
    return productRepo.updateProduct(
      id,
      productName: productName,
      price: price,
      description: description,
      imageUrl: imageUrl,
    );
  }
}
