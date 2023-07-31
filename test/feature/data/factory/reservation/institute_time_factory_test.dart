import 'package:cist_keion_app/feature/data/factory/reservation/institute_time_factory.dart';
import 'package:cist_keion_app/feature/domain/value/institute_time.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late InstituteTimeFactory factory;

  setUp(() => factory = InstituteTimeFactory());

  const tValue = InstituteTime.first;
  const tModel = 'first';

  group('create', () {
    test('should return institute grade', () {
      // act
      final result = factory.create('first');
      // assert
      expect(result, tValue);
    });
  });

  group('createFromModel', () {
    test('should return member', () {
      // act
      final result = factory.createFromModel(tModel);
      // assert
      expect(result, tValue);
    });
  });

  group('convertToModel', () {
    test('should return model', () {
      // act
      final result = factory.convertToModel(tValue);
      // assert
      expect(result, tModel);
    });
  });
}
