import 'package:cist_keion_app/feature/auth/data/factories/belonging_factory.dart';
import 'package:cist_keion_app/feature/auth/data/models/firestore/belonging_model.dart';
import 'package:cist_keion_app/feature/auth/domain/values/belongings/band.dart';
import 'package:cist_keion_app/feature/auth/domain/values/belongings/belonging.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final factory = BelongingFactoryImpl();

  const tId = 'testId';
  const tType = BelongingType.band;
  const tName = 'testName';
  final tMemberIds = ['testMemberId'];
  final tAdditionalParam = NoAdditionalParam();

  final tParams = BelongingParams<NoAdditionalParam>(
    id: tId,
    type: tType,
    name: tName,
    memberIds: tMemberIds,
    additionalParams: tAdditionalParam,
  );

  final tValue = Band(id: tId, name: tName, memberIds: tMemberIds);
  final tModel = BelongingModel<NoAdditionalParam>(
    id: tId,
    type: tType,
    name: tName,
    memberIds: tMemberIds,
    additionalParams: tAdditionalParam,
  );

  group('create', () {
    test('should return band extends belonging', () {
      // act
      final result = factory.create(tParams);
      // assert
      expect(
        result,
        isA<Belonging>()
            .having((result) => result.id, 'id', tValue.id)
            .having((result) => result.name, 'id', tValue.name)
            .having((result) => result.memberIds, 'id',
                unorderedEquals(tValue.memberIds)),
      );
    });
  });

  group('createFromModel', () {
    test('should return band extends belonging from belonging model', () {
      // act
      final result = factory.createFromModel(tModel);
      // assert
      expect(
        result,
        isA<Belonging>()
            .having((result) => result.id, 'id', tValue.id)
            .having((result) => result.name, 'id', tValue.name)
            .having((result) => result.memberIds, 'id',
                unorderedEquals(tValue.memberIds)),
      );
    });
  });

  group('convertToModel', () {
    test('should return belonging model from band extends belonging', () {
      // act
      final result = factory.convertToModel(tValue);
      // assert
      expect(
        result,
        isA<BelongingModel<NoAdditionalParam>>()
            .having((result) => result.id, 'id', tModel.id)
            .having((result) => result.name, 'name', tModel.name)
            .having((result) => result.memberIds, 'memberIds',
                unorderedEquals(tModel.memberIds)),
      );
    });
  });
}
