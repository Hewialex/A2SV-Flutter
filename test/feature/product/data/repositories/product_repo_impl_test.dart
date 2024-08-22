import 'package:layout_in_flutter/core/platform/network_info.dart';
import 'package:layout_in_flutter/feature/product/data/data_source/product_local_data_source.dart';
import 'package:layout_in_flutter/feature/product/data/data_source/product_remote_data_source.dart';
import 'package:layout_in_flutter/feature/product/data/repositories/product_repo_impl.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockRemoteDataSource extends Mock 
    implements ProductRemoteDataSource{}

class MockLocalDataSource extends Mock 
    implements ProductLocalDataSource{}

class MockNetworkInfo extends Mock 
    implements NetworkInfo{}


void main(){
  late ProductRepoImpl repo;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp((){
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repo = ProductRepoImpl(
      remoteDataSource : mockRemoteDataSource,
      localDataSource : mockLocalDataSource,
      networkInfo : mockNetworkInfo,

    );
  });
  group('addProduct', (){
    

  });
}