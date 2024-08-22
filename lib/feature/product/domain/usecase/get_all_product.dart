import 'package:dartz/dartz.dart';
import 'package:layout_in_flutter/core/error/failure.dart';
import 'package:layout_in_flutter/feature/product/domain/Entity/product.dart';
import 'package:layout_in_flutter/feature/product/domain/repository/product_repo.dart';
class GetAllProductUseCase {
  final ProductRepo productRepo;
  GetAllProductUseCase(this.productRepo);

  Future<Either<Failure, List<ProductEntity>>> execute() async {
    return await productRepo.getAllProduct();
  }
}