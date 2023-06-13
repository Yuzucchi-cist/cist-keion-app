import 'package:cist_keion_app/core/network/network_info.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'network_info_test.mocks.dart';

@GenerateMocks([Connectivity])
void main() {
  late NetworkInfoImpl networkInfo;
  late MockConnectivity mockConnectivity;

  setUp(() {
    mockConnectivity = MockConnectivity();
    networkInfo = NetworkInfoImpl(mockConnectivity);
  });

  group('isConnected', () {
    test('DataConnectionChecker.hasConnection の呼び出しを転送できる.', () async {
      // arrange
      const tConnectionResultFuture = ConnectivityResult.wifi;
      when(mockConnectivity.checkConnectivity())
          .thenAnswer((_) async => tConnectionResultFuture);
      // act
      final result = await networkInfo.isConnected;
      // assert
      verify(mockConnectivity.checkConnectivity());
      expect(result, isTrue);
    });
  });
}
