import 'package:dartz/dartz.dart';
import 'package:layout_in_flutter/core/error/failure.dart';
import 'package:layout_in_flutter/feature/product/domain/Entity/product.dart';

abstract class ProductRepo{
  Future<Either<Failure, List<ProductEntity>>> getAllProduct();
  Future<Either<Failure,ProductEntity>> addProduct(ProductEntity product);
  Future<Either<Failure, Unit>> deleteProductById(String id);
  Future<Either<Failure, ProductEntity>> getProductById(String id);
  Future<Either<Failure, ProductEntity>> updateProduct(
    String id, {
    required String productName,
    required double price,
    required String description,
    required String imageUrl,
  });
  
}