import 'package:layout_in_flutter/feature/product/domain/Entity/product.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required String id,
    required String productName,
    required double price,
    required String description,
    required String imageUrl,
  }) : super(
          id: id,
          productName: productName,
          price: price,
          description: description,
          imageUrl: imageUrl,
        );

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as String? ?? '', // Providing a default empty string if null
      productName: json['name'] as String? ?? '', // Providing a default empty string if null
      price: (json['price'] as num?)?.toDouble() ?? 0.0, // Providing a default value if null
      description: json['description'] as String? ?? '', // Providing a default empty string if null
      imageUrl: json['imageUrl'] as String? ?? '', // Providing a default empty string if null
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': productName,
      'price': price,
      'description': description,
      'imageUrl': imageUrl,
    };
  }

  // Convert from ProductEntity to ProductModel
  static ProductModel fromEntity(ProductEntity product) {
    return ProductModel(
      id: product.id,
      productName: product.productName,
      price: product.price,
      description: product.description,
      imageUrl: product.imageUrl,
    );
  }

  // Convert from ProductModel to ProductEntity
  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      productName: productName,
      price: price,
      description: description,
      imageUrl: imageUrl,
    );
  }
  
}
