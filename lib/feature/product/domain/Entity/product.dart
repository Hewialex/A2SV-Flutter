import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  const ProductEntity({
    required this.id,
    required this.productName,
    required this.price,
    required this.description,
    required this.imageUrl,
  });

  final String id;
  final String productName;
  final double price;
  final String description;
  final String imageUrl;

  @override
  List<Object?> get props => [id, productName, price, description, imageUrl];
}
