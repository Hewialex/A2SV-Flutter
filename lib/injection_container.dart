import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:layout_in_flutter/core/util/input_converter.dart';
import 'package:layout_in_flutter/core/platform/network_info.dart';
import 'package:layout_in_flutter/feature/authentication/data/data_source/user_local_data_source.dart';
import 'package:layout_in_flutter/feature/authentication/data/data_source/user_remote_data_source.dart';
import 'package:layout_in_flutter/feature/authentication/data/repositories/user_repo_impl.dart';
import 'package:layout_in_flutter/feature/authentication/domain/repository/user_repo.dart';
import 'package:layout_in_flutter/feature/authentication/domain/usecase/getme_usecase.dart';
import 'package:layout_in_flutter/feature/authentication/domain/usecase/signin_usecase.dart';
import 'package:layout_in_flutter/feature/authentication/domain/usecase/signup_usecase.dart';
import 'package:layout_in_flutter/feature/product/data/data_source/product_local_data_source.dart';
import 'package:layout_in_flutter/feature/product/data/data_source/product_remote_data_source.dart';
import 'package:layout_in_flutter/feature/product/data/repositories/product_repo_impl.dart';
import 'package:layout_in_flutter/feature/product/domain/repository/product_repo.dart';
import 'package:layout_in_flutter/feature/product/domain/usecase/add_product.dart';
import 'package:layout_in_flutter/feature/product/domain/usecase/delete_product.dart';
import 'package:layout_in_flutter/feature/product/domain/usecase/get_all_product.dart';
import 'package:layout_in_flutter/feature/product/domain/usecase/get_product.dart';
import 'package:layout_in_flutter/feature/product/domain/usecase/update_product.dart';
import 'package:layout_in_flutter/feature/product/presentation/bloc/bloc/product_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'feature/authentication/presentation/bloc/user_bloc.dart';

final sl = GetIt.instance;

Future<void> setUpLocator() async {
  // BLoC
  sl.registerFactory<ProductBloc>(() => ProductBloc(
      addProduct: sl(),
      deleteProductById: sl(),
      getProductById: sl(),
      updateProduct: sl(),
      getAllProductUseCase: sl()));
  
  // Usecases
  sl.registerLazySingleton<AddProductUsecase>(() => AddProductUsecase(sl()));
  sl.registerLazySingleton<GetAllProductUseCase>(() => GetAllProductUseCase(sl()));
  sl.registerLazySingleton<UpdateProductUsecase>(() => UpdateProductUsecase(sl()));
  sl.registerLazySingleton<GetProductUsecase>(() => GetProductUsecase(sl()));
  sl.registerLazySingleton<DeleteProductUsecase>(() => DeleteProductUsecase(sl()));

  // Repository
  sl.registerLazySingleton<ProductRepo>(() => ProductRepoImpl(
        remoteDataSource: sl(),
        localDataSource: sl(),
        networkInfo: sl(),
      ));

  // Data sources
  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<ProductLocalDataSource>(
    () => ProductLocalDataSourceImpl(pref: sl()),
  );

  // Core
  sl.registerLazySingleton<InputConverter>(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(connectionChecker: sl()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());

  sl.registerFactory<UserBloc>(() => UserBloc(
        signInUseCase: sl(),
        signUpUseCase: sl(),
        getMeUseCase: sl(),
      ));

  // Usecases
  sl.registerLazySingleton<SigninUsecase>(() => SigninUsecase(sl()));
  sl.registerLazySingleton<SignupUsecase>(() => SignupUsecase(sl()));
  sl.registerLazySingleton<GetmeUsecase>(() => GetmeUsecase(sl()));

  // Repository
  sl.registerLazySingleton<UserRepo>(() => UserRepoImpl(
        userRemoteDataSource: sl(),
        userLocalDataSource: sl(),
        networkInfo: sl(),
      ));

  // Data sources
  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(client: sl(), userLocalDataSource: sl()),
  );
  sl.registerLazySingleton<UserLocalDataSource>(
    () => UserLocalDataSourceImpl(sharedPreferences: sl()),
  );

  

  
}
