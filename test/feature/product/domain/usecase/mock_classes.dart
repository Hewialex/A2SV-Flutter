import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:layout_in_flutter/core/platform/network_info.dart';
import 'package:layout_in_flutter/feature/product/data/data_source/product_local_data_source.dart';
import 'package:layout_in_flutter/feature/product/domain/repository/product_repo.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


@GenerateMocks([
  ProductRepo,
  ProductLocalDataSource,
  InternetConnectionChecker,
  
  SharedPreferences,
  NetworkInfo,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}