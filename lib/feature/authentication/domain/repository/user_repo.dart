
import 'package:dartz/dartz.dart';
import 'package:layout_in_flutter/core/error/failure.dart';
import 'package:layout_in_flutter/feature/authentication/domain/entity/user_entity.dart';

abstract class UserRepo{
  Future <Either<Failure, UserEntity>> signUp(UserEntity user);
  
  Future <Either<Failure, UserEntity>> signIn(UserEntity user);
  
  Future <Either<Failure, UserEntity>> getMe();
  
}