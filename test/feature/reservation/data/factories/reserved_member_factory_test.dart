import 'package:cist_keion_app/feature/reservation/data/factories/reserved_member_factory.dart';
import 'package:cist_keion_app/feature/reservation/data/models/reserved_member_model.dart';
import 'package:cist_keion_app/feature/reservation/domain/values/reserved_member.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ReservedMemberFactory factory;

  setUp(() => factory = ReservedMemberFactory());

  const tValue = ReservedMember(id: 'testId', name: 'testName');
  const tModel = ReservedMemberModel(id: 'testId', name: 'testName');
  final tParams = ReservedMemberParams(id: 'testId', name: 'testName');

  group('create', () {
    test('should return institute grade', () {
      // act
      final result = factory.create(tParams);
      // assert
      expect(
          result,
          isA<ReservedMember>()
              .having((value) => value.id, 'id', tValue.id)
              .having((value) => value.name, 'name', tValue.name));
    });
  });

  group('createFromModel', () {
    test('should return member', () {
      // act
      final result = factory.createFromModel(tModel);
      // assert
      expect(
          result,
          isA<ReservedMember>()
              .having((value) => value.id, 'id', tValue.id)
              .having((value) => value.name, 'name', tValue.name));
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
