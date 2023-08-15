import 'package:cist_keion_app/feature/data/factory/member_detail/belonging_factory.dart';
import 'package:cist_keion_app/feature/data/model/member_detail/belonging_model.dart';
import 'package:cist_keion_app/feature/domain/value/belongings/band.dart';
import 'package:cist_keion_app/feature/domain/value/belongings/belonging.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final factory = BelongingFactoryImpl();

  const tId = 'testId';
  const tType = BelongingType.band;
  const tName = 'testName';

  const tParams = BelongingParams(
    id: tId,
    type: tType,
    name: tName,
  );

  final tValue = Band(id: tId, name: tName);
  const tModel = BelongingModel(
    id: tId,
    type: tType,
    name: tName,
  );

  group('create', () {
    test('should return band extends belonging', () {
      // act
      final result = factory.create(tParams);
      // assert
      expect(
          result,
          isA<Band>()
              .having((result) => result.id, 'id', tValue.id)
              .having((result) => result.name, 'id', tValue.name));
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
            .having((result) => result.name, 'name', tValue.name),
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
        isA<BelongingModel>()
            .having((result) => result.id, 'id', tModel.id)
            .having((result) => result.name, 'name', tModel.name)
            .having((result) => result.type, 'type', tModel.type),
      );
    });
  });
}
