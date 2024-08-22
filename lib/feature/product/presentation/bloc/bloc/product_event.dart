// part of 'product_bloc.dart';


import 'package:equatable/equatable.dart';
import 'package:layout_in_flutter/feature/product/data/models/product_model.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class LoadAllProductEvent extends ProductEvent {
}

// Event to get a single product by ID
class GetSingleProductEvent extends ProductEvent {
  final String id;
  GetSingleProductEvent(this.id);
}

// Event to update a product's details
class UpdateProductEvent extends ProductEvent {
  
  final String id;
  final String productName;
  final double price;
  final String description;
  final String imageUrl;

  UpdateProductEvent(String productId, {
    required this.id,
    required this.productName,
    required this.price,
    required this.description,
    required this.imageUrl,
  });
}

// Event to delete a product by ID
class DeleteProductEvent extends ProductEvent {
  final String id;
  DeleteProductEvent(this.id);
}

// Event to create a new product
class CreateProductEvent extends ProductEvent {
  final ProductModel product;
  CreateProductEvent(this.product);
}

