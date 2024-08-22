import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:dartz/dartz.dart';
import 'package:layout_in_flutter/core/error/exceptions.dart';
import 'package:layout_in_flutter/core/error/failure.dart';
import 'package:layout_in_flutter/core/platform/network_info.dart';
import 'package:layout_in_flutter/feature/product/data/data_source/product_remote_data_source.dart';
import 'package:layout_in_flutter/feature/product/data/models/product_model.dart';
import 'package:layout_in_flutter/feature/product/domain/Entity/product.dart';
import 'package:layout_in_flutter/feature/product/domain/repository/product_repo.dart';

import '../data_source/product_local_data_source.dart';

class ProductRepoImpl implements ProductRepo {
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ProductRepoImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, ProductEntity>> addProduct(ProductEntity product) async {
    if (await networkInfo.isConnected) {
      try {
        final productModel = ProductModel.fromEntity(product);
        final result = await remoteDataSource.addProduct(productModel);
        return Right(result.toEntity());
      } on ServerException {
        return Left(ServerFailure('An error has occurred'));
      } on SocketException {
        return Left(ConnectionFailure('Failed to connect to the network'));
      }
    } else {
      return Left(ConnectionFailure('No Internet connection'));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteProductById(String id) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deleteProductById(id);
        return Right(unit);
      } on ServerException {
        return Left(ServerFailure('An error has occurred'));
      } on SocketException {
        return Left(ConnectionFailure('Failed to connect to the network'));
      }
    } else {
      return Left(ConnectionFailure('No Internet connection'));
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> getProductById(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final productModel = await remoteDataSource.getProductById(id);
        return Right(productModel.toEntity());
      } on ServerException {
        return Left(ServerFailure('An error has occurred'));
      } on SocketException {
        return Left(ConnectionFailure('Failed to connect to the network'));
      }
    } else {
      return Left(ConnectionFailure('No Internet connection'));
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> updateProduct(
    String id, {
    required String productName,
    required double price,
    required String description,
    required String imageUrl,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.updateProduct(
          id,
          productName: productName,
          price: price,
          description: description,
          imageUrl: imageUrl,
        );
        return Right(result.toEntity());
      } on ServerException {
        return Left(ServerFailure('An error has occurred'));
      } on SocketException {
        return Left(ConnectionFailure('Failed to connect to the network'));
      }
    } else {
      return Left(ConnectionFailure('No Internet connection'));
    }
  }
  

  @override
  Future<Either<Failure, List<ProductEntity>>> getAllProduct() async {
    try {
      final result = await remoteDataSource.getAllProducts();
      print("returning right");
      return Right(result);
    } on ServerException {
      return Left(ServerFailure('An error has occurred'));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
 Future<List<ProductModel>> fetchProducts() async {
    // Your API call to fetch products
    final apiUrl = "https://g5-flutter-learning-path-be.onrender.com/api/v1/products";
    
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
  