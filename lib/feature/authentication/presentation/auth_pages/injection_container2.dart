// import 'package:get_it/get_it.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';
// import 'package:layout_in_flutter/core/platform/network_info.dart';
// import 'package:layout_in_flutter/core/util/input_converter.dart';
// import 'package:layout_in_flutter/feature/authentication/data/data_source/user_local_data_source.dart';
// import 'package:layout_in_flutter/feature/authentication/data/data_source/user_remote_data_source.dart';
// import 'package:layout_in_flutter/feature/authentication/data/repositories/user_repo_impl.dart';
// import 'package:layout_in_flutter/feature/authentication/domain/repository/user_repo.dart';
// import 'package:layout_in_flutter/feature/authentication/domain/usecase/getme_usecase.dart';
// import 'package:layout_in_flutter/feature/authentication/domain/usecase/signin_usecase.dart';
// import 'package:layout_in_flutter/feature/authentication/domain/usecase/signup_usecase.dart';
// import 'package:layout_in_flutter/feature/authentication/presentation/bloc/user_bloc.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;

// final locator = GetIt.instance;

// Future<void> setUpLocator() async {
//   // BLoC
//   locator.registerFactory<UserBloc>(() => UserBloc(
//         signInUseCase: locator(),
//         signUpUseCase: locator(),
//         getMeUseCase: locator(),
//       ));

//   // Usecases
//   locator.registerLazySingleton<SigninUsecase>(() => SigninUsecase(locator()));
//   locator.registerLazySingleton<SignupUsecase>(() => SignupUsecase(locator()));
//   locator.registerLazySingleton<GetmeUsecase>(() => GetmeUsecase(locator()));

//   // Repository
//   locator.registerLazySingleton<UserRepo>(() => UserRepoImpl(
//         userRemoteDataSource: locator(),
//         userLocalDataSource: locator(),
//         networkInfo: locator(),
//       ));

//   // Data sources
//   locator.registerLazySingleton<UserRemoteDataSource>(
//     () => UserRemoteDataSourceImpl(client: locator(), userLocalDataSource: locator()),
//   );
//   locator.registerLazySingleton<UserLocalDataSource>(
//     () => UserLocalDataSourceImpl(sharedPreferences: locator(), pref: locator()),
//   );

//   // Core
//   locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(connectionChecker: locator()));
//   locator.registerLazySingleton<InputConverter>(() => InputConverter());

//   // External
//   final sharedPreferences = await SharedPreferences.getInstance();
//   locator.registerLazySingleton(() => sharedPreferences);
//   locator.registerLazySingleton(() => http.Client());
//   locator.registerLazySingleton(() => InternetConnectionChecker());
// }
