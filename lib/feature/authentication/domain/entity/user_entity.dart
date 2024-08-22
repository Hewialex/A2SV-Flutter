
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable{
  final String id;
  final String userName;
  final String email;
  final String password;

  UserEntity({
    required this.id, 
    required this.userName, 
    required this.email, 
    required this.password, 

  });
  
  @override
  // TODO: implement props
  List<Object?> get props => [id, userName, email, password];

  
  
}