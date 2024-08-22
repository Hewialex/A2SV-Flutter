
import 'package:dartz/dartz.dart';
import 'package:layout_in_flutter/core/error/failure.dart';
import 'package:layout_in_flutter/feature/authentication/domain/entity/user_entity.dart';
import 'package:layout_in_flutter/feature/authentication/domain/repository/user_repo.dart';

class SignupUsecase {
  final UserRepo userRepo;

  SignupUsecase(this.userRepo);
  Future <Either<Failure, UserEntity>> execute(UserEntity user){
    return userRepo.signUp(user);
    }

}