import 'package:dartz/dartz.dart';
import 'package:layout_in_flutter/core/error/failure.dart';
import 'package:layout_in_flutter/feature/product/domain/Entity/product.dart';
import 'package:layout_in_flutter/feature/product/domain/repository/product_repo.dart';

class GetProductUsecase {
  final ProductRepo productRepo;

  GetProductUsecase(this.productRepo);

  Future<Either<Failure, ProductEntity>> execute(String id) {
    return productRepo.getProductById(id);
  }
}
