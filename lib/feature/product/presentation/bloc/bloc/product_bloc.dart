import 'package:bloc/bloc.dart';

import 'package:layout_in_flutter/core/error/failure.dart';
import 'package:layout_in_flutter/feature/product/data/models/product_model.dart';
import 'package:layout_in_flutter/feature/product/domain/usecase/add_product.dart';
import 'package:layout_in_flutter/feature/product/domain/usecase/delete_product.dart';
import 'package:layout_in_flutter/feature/product/domain/usecase/get_all_product.dart';
import 'package:layout_in_flutter/feature/product/domain/usecase/get_product.dart';
import 'package:layout_in_flutter/feature/product/domain/usecase/update_product.dart';
import 'package:layout_in_flutter/feature/product/presentation/bloc/bloc/product_event.dart';
import 'package:layout_in_flutter/feature/product/presentation/bloc/bloc/product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final AddProductUsecase addProduct;
  final DeleteProductUsecase deleteProductById;
  final GetProductUsecase getProductById;
  final UpdateProductUsecase updateProduct;
  final GetAllProductUseCase getAllProductUseCase;

  ProductBloc({
    required this.addProduct,
    required this.deleteProductById,
    required this.getProductById,
    required this.updateProduct,
    required this.getAllProductUseCase,
  }) : super(ProductInitial()) {
    on<CreateProductEvent>((event, emit) async {
      emit(ProductLoading());
      final result = await addProduct.execute(event.product);
      print("event "); // Use execute method
      print(event.product);
      result.fold(
        (failure) => emit(ProductError(_mapFailureToMessage(failure))),
        (product) =>
            emit(ProductLoadedSingle(ProductModel.fromEntity(product))),
      );
    });

    on<DeleteProductEvent>((event, emit) async {
      emit(ProductLoading());
      final result =
          await deleteProductById.execute(event.id); // Use execute method
      result.fold(
        (failure) => emit(ProductError(_mapFailureToMessage(failure))),
        (_) => add(
            LoadAllProductEvent()), // Assuming ProductDeleted is a state representing successful deletion
      );
    });

    on<GetSingleProductEvent>((event, emit) async {
      emit(ProductLoading());
      final result =
          await getProductById.execute(event.id); // Use execute method
      result.fold(
        (failure) => emit(ProductError(_mapFailureToMessage(failure))),
        (product) =>
            emit(ProductLoadedSingle(ProductModel.fromEntity(product))),
      );
    });

    on<UpdateProductEvent>((event, emit) async {
      print("update product event called");
      emit(ProductLoading());
      final result = await updateProduct.execute(
        event.id,
        productName: event.productName,
        price: event.price,
        description: event.description,
        imageUrl: event.imageUrl,
      ); // Use execute method
      result
          .fold((failure) => emit(ProductError(_mapFailureToMessage(failure))),
               (_) => add(
            LoadAllProductEvent()), );
    });

    on<LoadAllProductEvent>((event, emit) async {
      print("getting in to the event");
      emit(ProductLoading());
      final result = await getAllProductUseCase.execute();
      print('after event $result');
      result.fold(
        (failure) => emit(ProductError(_mapFailureToMessage(failure))),
        (data) {
          List<ProductModel> newProduct =
              data.map((el) => ProductModel.fromEntity(el)).toList();
          emit(ProductLoadedAll(newProduct)); // Pass the argument correctly
        },
      );
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server Failure';
      case CacheFailure:
        return 'Cache Failure';
      default:
        return 'Unexpected Error';
    }
  }

  
}
