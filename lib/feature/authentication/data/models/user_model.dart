
import 'package:layout_in_flutter/feature/authentication/domain/entity/user_entity.dart';

class UserModel extends UserEntity {
  String accessToken;
  UserModel({
    required String id,
    required String userName,
    required String email,
    required String password,
    required this.accessToken
  }) : super(
          id: id,
          userName: userName,
          email: email,
          password: password,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String? ?? '',
      userName: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      password: json['password'] as String? ?? '',
      accessToken: json['access_token'] as String? ?? ''
    );
  }

  

  Map<String, dynamic> toJson(){
    return{
      'id': id,
      'name': userName,
      'email': email,
      'password': password,
    };
  }

  static UserModel fromEntity(UserEntity user){
    return UserModel(
      id: user.id, 
      userName: user.userName, 
      email: user.email, 
      password: user.password,
      accessToken: ''
      );
  }

  UserEntity toEntity(){
    return UserEntity(
      id: id, 
      userName: userName, 
      email: email, 
      password: password,
      );
  }

}
class AuthResponse {
  final String accessToken;
  final UserModel user;

  AuthResponse({required this.accessToken, required this.user});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      accessToken: json['data']['access_token'] as String,
      user: UserModel.fromJson(json['data']['user']),
    );
  }
}




