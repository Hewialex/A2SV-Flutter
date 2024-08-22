
import 'package:flutter_test/flutter_test.dart';
import 'package:layout_in_flutter/core/platform/network_info.dart';
import 'package:mockito/mockito.dart';

import '../../feature/product/domain/usecase/mock_classes.mocks.dart';

void main() {
  late NetworkInfoImpl networkInfo;
  late MockInternetConnectionChecker mockInternetConnectionChecker;

  setUp(() {
    mockInternetConnectionChecker = MockInternetConnectionChecker();
    networkInfo = NetworkInfoImpl(connectionChecker: mockInternetConnectionChecker);
  });

  test(
    'should forward the call to InternetConnectionChecker.hasConnection',
    () async {
      // arrange
      final tHasConnectionFuture = Future.value(true);
      when(mockInternetConnectionChecker.hasConnection)
          .thenAnswer((_) => tHasConnectionFuture);

      // act
      final result = networkInfo.isConnected;

      // assert
      verify(mockInternetConnectionChecker.hasConnection);
      expect(await result, await tHasConnectionFuture);
    },
  );
}
