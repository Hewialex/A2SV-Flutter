import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:layout_in_flutter/core/error/exceptions.dart';
import 'package:layout_in_flutter/core/error/failure.dart';
import 'package:layout_in_flutter/core/platform/network_info.dart';
import 'package:layout_in_flutter/feature/authentication/data/data_source/user_local_data_source.dart';
import 'package:layout_in_flutter/feature/authentication/data/data_source/user_remote_data_source.dart';
import 'package:layout_in_flutter/feature/authentication/data/models/user_model.dart';
import 'package:layout_in_flutter/feature/authentication/domain/entity/user_entity.dart';
import 'package:layout_in_flutter/feature/authentication/domain/repository/user_repo.dart';

class UserRepoImpl implements UserRepo {
  final UserRemoteDataSource userRemoteDataSource;
  final UserLocalDataSource userLocalDataSource;
  final NetworkInfo networkInfo;

  UserRepoImpl({
    required this.userRemoteDataSource,
    required this.userLocalDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, UserEntity>> signUp(UserEntity user) async {
    if (await networkInfo.isConnected) {
      try {
        final userModel = UserModel.fromEntity(user);
        final result = await userRemoteDataSource.signUp(userModel);
        await userLocalDataSource.saveAuthToken(result.accessToken);
        return Right(result.toEntity());
      } on ServerException {
        return Left(ServerFailure('An error has occurred during sign-up'));
      } on SocketException {
        return Left(ConnectionFailure('Failed to connect to the network'));
      }
    } else {
      return Left(ConnectionFailure('No Internet connection'));
    }
  }
  
  @override
  Future<Either<Failure, UserEntity>> getMe() async {
    try {
      if (await networkInfo.isConnected) {
      try {
        final token = await userLocalDataSource.getAuthToken(); // Fetch the token
        if (token == null) {
          return Left(UnauthorizedFailure('No auth token found'));
        }
        final result = await userRemoteDataSource.getMe(token);
        return Right(result.toEntity());
      } on ServerException {
        return Left(ServerFailure('An error occurred while fetching user details'));
      } on SocketException {
        return Left(ConnectionFailure('Failed to connect to the network'));
      }
    } else {
      return Left(ConnectionFailure('No Internet connection'));
    }
    } catch(e) {
       return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
  
  @override
  Future<Either<Failure, UserEntity>> signIn(UserEntity user) async {
    if (await networkInfo.isConnected) {
      try {
        final userModel = UserModel.fromEntity(user);
        final result = await userRemoteDataSource.signIn(userModel);
        return Right(result.toEntity());
      } on ServerException {
        return Left(ServerFailure('An error occurred during sign-in'));
      } on SocketException {
        return Left(ConnectionFailure('Failed to connect to the network'));
      }
    } else {
      return Left(ConnectionFailure('No Internet connection'));
    }
  }
}
