// part of 'product_bloc.dart';

import 'package:equatable/equatable.dart';

import 'package:layout_in_flutter/feature/product/domain/Entity/product.dart';

sealed class ProductState extends Equatable {
  const ProductState();
  
  @override
  List<Object> get props => [];
}

// Represents the initial state before any data is loaded
final class ProductInitial extends ProductState {}

// Indicates that the app is currently fetching data
final class ProductLoading extends ProductState {}

// Represents the state where all products are successfully loaded from the repository
final class ProductLoadedAll extends ProductState {
  final List<ProductEntity> products;
  const ProductLoadedAll(this.products);

  @override
  List<Object> get props => [products];
}

class ProductDeleted extends ProductState {}

// Represents the state where a single product is successfully retrieved
final class ProductLoadedSingle extends ProductState {
  final ProductEntity product;
  const ProductLoadedSingle(this.product);

  @override
  List<Object> get props => [product];
}

// Indicates that an error has occurred during data retrieval or processing
final class ProductError extends ProductState {
  final String message;
  const ProductError(this.message);

  @override
  List<Object> get props => [message];
}
