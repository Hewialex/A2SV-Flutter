import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:layout_in_flutter/feature/authentication/data/data_source/user_local_data_source.dart';
import 'package:layout_in_flutter/feature/authentication/data/models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> signUp(UserModel user);
  Future<UserModel> signIn(UserModel user);
  Future<UserModel> getMe(String token); // Corrected method signature
}

class UserRemoteDataSourceImpl extends UserRemoteDataSource {
  final http.Client client;
  final UserLocalDataSource userLocalDataSource;

  UserRemoteDataSourceImpl({
    required this.client,
    required this.userLocalDataSource,
  });

  @override
  Future<UserModel> getMe(String token) async {
    const String apiUrl = 'https://g5-flutter-learning-path-be.onrender.com/api/v2/users/me';

    // Send the HTTP GET request with the authToken in the headers
    final response = await client.get(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Use the token parameter
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return UserModel.fromJson(data['data']);
    } else {
      throw Exception('Failed to retrieve user data. Status code: ${response.statusCode}');
    }
  }

  @override
  Future<UserModel> signIn(UserModel user) async {
    const String apiUrl = 'https://g5-flutter-learning-path-be.onrender.com/api/v2/auth/login';

    final response = await client.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "email": user.email,
        "password": user.password
      }), // Convert the user object to JSON
    );

    if (response.statusCode == 201) { // Successful login
      final Map<String, dynamic> data = jsonDecode(response.body);
      final String accessToken = data['data']['access_token'];
      await userLocalDataSource.saveAuthToken(accessToken); // Save the token locally
      return UserModel.fromJson(data);
    } else {
      throw Exception('Failed to sign in. Status code: ${response.statusCode}');
    }
  }

  @override
  Future<UserModel> signUp(UserModel user) async {
    const String apiUrl = 'https://g5-flutter-learning-path-be.onrender.com/api/v2/auth/register';

    final response = await client.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(user.toJson()), // Convert the user object to JSON
    );

    if (response.statusCode == 201) { // Successful registration
      final Map<String, dynamic> data = jsonDecode(response.body);
      
      return UserModel.fromJson(data['data']);
    } else {
      throw Exception('Failed to sign up. Status code: ${response.statusCode}');
    }
  }
}
