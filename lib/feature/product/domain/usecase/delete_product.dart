import 'package:dartz/dartz.dart';
import 'package:layout_in_flutter/core/error/failure.dart';
import 'package:layout_in_flutter/feature/product/domain/repository/product_repo.dart';

class DeleteProductUsecase {
  final ProductRepo productRepo;

  DeleteProductUsecase(this.productRepo);

  Future<Either<Failure, Unit>> execute(String id) {
    return productRepo.deleteProductById(id);
  }
}
